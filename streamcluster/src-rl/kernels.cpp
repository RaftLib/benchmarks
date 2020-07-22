#include "kernels.hpp"
#include <limits>

PStreamReader::PStreamReader(PStream* stream, float* block, int dim, long chunkSize, bool* shouldContinue, long* IDoffset)
    : raft::kernel(), m_Stream(stream), m_Block(block), m_Dim(dim), m_ChunkSize(chunkSize), m_Continue(shouldContinue), m_IDoffset(IDoffset)
{
    // Create our output port
    output.addPort<PStreamReader_Output>("output");
}

raft::kstatus PStreamReader::run()
{
    size_t numRead = 0;
    std::cout << "Executing PStreamReader run" << std::endl;
    if (*m_Continue)
    {
        // Get the number of points to operate on
        numRead = m_Stream->read(m_Block, m_Dim, m_ChunkSize);

        // Error checking
        if (m_Stream->ferror() || numRead < (unsigned int) m_ChunkSize && !m_Stream->feof())
        {
            std::cerr << "Error reading data!" << std::endl;
            exit(EXIT_FAILURE);
        }
    }

    // Push our output data
    output["output"].push<PStreamReader_Output>(PStreamReader_Output(numRead, !*m_Continue));

    *m_IDoffset += numRead;

    // If we've reached the end of the stream, alert the while loop
    if (m_Stream->feof())
        *m_Continue = false;

    return raft::stop;
}

LocalSearchStarter::LocalSearchStarter(Points* points, Points* centers, unsigned int threadCount, bool** isCenter, int** centerTable, bool** switchMembership)
    : raft::kernel(), m_Points(points), m_Centers(centers), m_ThreadCount(threadCount), m_IsCenter(isCenter), m_SwitchMembership(switchMembership), m_CenterTable(centerTable)
{
    // Create our input port
    input.addPort<PStreamReader_Output>("input");

    // Create our output ports based on the number of desired threads
    for (auto i = 0; i < m_ThreadCount; i++)
        output.addPort<LocalSearchStarter_Output>(std::to_string(i).c_str());
}

raft::kstatus LocalSearchStarter::run()
{
    std::cout << "Executing LocalSearchStarter run" << std::endl;
    // Get our input data
    PStreamReader_Output inputData = input["input"].peek<PStreamReader_Output>();

    // Calculate the blockSize for each "thread"
    size_t blockSize = inputData.numRead / (size_t) m_ThreadCount;

    if (inputData.useCenters)
    {
        std::cout << "Using centers for local search" << std::endl;
        *m_SwitchMembership = new bool[m_Centers->num];
        *m_IsCenter = new bool[m_Centers->num];
        *m_CenterTable = new int[m_Centers->num];
    }
    else
    {
        std::cout << "Using points for local search" << std::endl;
        m_Points->num = inputData.numRead;
        *m_SwitchMembership = new bool[inputData.numRead];
        *m_IsCenter = new bool[inputData.numRead];
        *m_CenterTable = new int[inputData.numRead];
    }
    

    for (auto i = 0; i < inputData.numRead; i++)
    {
        if (!inputData.useCenters)
            m_Points->p[i].weight = 1.0;
    }

    for (auto i = 0; i < m_ThreadCount; i++)
    {
        if (inputData.useCenters)
            output[std::to_string(i).c_str()].push<LocalSearchStarter_Output>(LocalSearchStarter_Output(m_Centers, m_Centers->num, blockSize, i));
        else
            output[std::to_string(i).c_str()].push<LocalSearchStarter_Output>(LocalSearchStarter_Output(m_Points, inputData.numRead, blockSize, i));
    }
        

    // Cleanup
    input["input"].recycle();

    return raft::proceed;
}

PKMedianWorker1::PKMedianWorker1() : raft::kernel()
{
    input.addPort<LocalSearchStarter_Output>("input");
    output.addPort<PKMedianWorker1_Output>("output");
}

raft::kstatus PKMedianWorker1::run()
{
    std::cout << "Executing PKMedianWorker1 run" << std::endl;
    // Get input data
    LocalSearchStarter_Output inputData = input["input"].peek<LocalSearchStarter_Output>();

    // Calculate bounds for iteration
    size_t k1 = inputData.blockSize * inputData.tid;
    size_t k2 = k1 + inputData.blockSize;
    if (k2 > inputData.numRead) 
        k2 = inputData.numRead;

    double hiz = 0.0;

    // Calculate myHiz
    for (auto i = k1; i < k2; i++)
        hiz += dist(inputData.points->p[i], inputData.points->p[0], inputData.points->dim) * inputData.points->p[i].weight;

    // Push result to output
    output["output"].push<PKMedianWorker1_Output>(PKMedianWorker1_Output(inputData.points, inputData.numRead, hiz));

    // Cleanup
    input["input"].recycle();

    return raft::proceed;
}

PKMedianAccumulator1::PKMedianAccumulator1(long kmin, long kmax, long* kFinal, unsigned int threadCount)
    : raft::kernel_all(), m_kMin(kmin), m_kMax(kmax), m_kFinal(kFinal), m_ThreadCount(threadCount)
{
    // Create our input ports based on the number of desired threads
    for (auto i = 0; i < m_ThreadCount; i++)
        input.addPort<PKMedianWorker1_Output>(std::to_string(i).c_str());

    // PSpeedyCallManager Output
    output.addPort<PSpeedyCallManager_Input>("output_pspeedy");

    output.addPort<ContCentersKernel_Input>("output_end");
}

raft::kstatus PKMedianAccumulator1::run()
{
    std::cout << "Executing PKMedianAccumulator1 run" << std::endl;
    // Save the input data so we can recycle after reading once
    double* hiz = new double(0.0);
    double* loz = new double(0.0);
    double* z = new double(0.0);
    long* kCenter = new long(0);
    Points* points;
    size_t numRead = 0;

    // Read the input data
    for (auto i = 0; i < m_ThreadCount; i++)
    {
        PKMedianWorker1_Output inputData = input[std::to_string(i).c_str()].peek<PKMedianWorker1_Output>();
        numRead = inputData.numRead;
        points = inputData.points;
        *hiz += inputData.hiz;
        input[std::to_string(i).c_str()].recycle();
    }

    *z = (*hiz + *loz) / 2.0;

    if (numRead <= m_kMax)
    {
        for (auto kk = 0; kk < numRead; kk++)
        {
            points->p[kk].assign = kk;
            points->p[kk].cost = 0;
        }
        *m_kFinal = *kCenter;

        delete hiz;
        delete loz;
        delete z;
        delete kCenter;

        output["output_end"].push<ContCentersKernel_Input>(ContCentersKernel_Input(numRead, points));

        return raft::proceed;
    }
    std::cout << "Pushing to PSpeedyCallManager" << std::endl;
    output["output_pspeedy"].push<PSpeedyCallManager_Input>(PSpeedyCallManager_Input(points, numRead, z, kCenter, hiz, loz));

    return raft::proceed;
}

PSpeedyCallManager::PSpeedyCallManager(unsigned int threadCount, long kmin, unsigned int SP) : raft::kernel(), m_ThreadCount(threadCount), m_kMin(kmin), m_SP(SP)
{
    // This input will come from whatever function calls pspeedy (should be pkmedian)
    input.addPort<PSpeedyCallManager_Input>("input");

    // This is the result of the pspeedy function operation
    output.addPort<PSpeedyCallManager_Output>("output");
}

raft::kstatus PSpeedyCallManager::run()
{
    std::cout << "Executing PSpeedyCallManager run" << std::endl;
    
    // This code runs when PSpeedyCallManager is given data from the call in pkmedian 
    // Should only be called once per iteration
    PSpeedyCallManager_Input inputData = input["input"].peek<PSpeedyCallManager_Input>();
    unsigned int iterationIndex = 0;
    unsigned int pSpeedyExecutionCount = 0;

    double totalCost = 0.0;

    // Do the initial points shuffle
    shuffle(inputData.points);

    // Command the worker threads (the first point is guaranteed to be a center)
    PSpeedyWorkerProducer producer1(inputData.points, inputData.numRead, true, iterationIndex, m_ThreadCount);
    PSpeedyWorker workers1[m_ThreadCount];
    PSpeedyWorkerConsumer consumer1(&totalCost, m_ThreadCount);
    raft::map m1;

    for (auto i = 0; i < m_ThreadCount; i++)
        m1 += producer1[std::to_string(i).c_str()] >> workers1[i] >> consumer1[std::to_string(i).c_str()];

    m1.exe();
    iterationIndex++;
    *(inputData.kCenter) = 1;

    bool shouldContinue = true;

    while (shouldContinue)
    {
        // Checks that take care of the 3 function calls of pspeedy
        if (iterationIndex >= inputData.numRead)
        {
            // At this point, an entire function call of "pspeedy" has been completed
            // Now, we need to decide whether to perform another based upon the values of kCenter, kmin, and SP
            pSpeedyExecutionCount++;
            
            if ((*(inputData.kCenter) < m_kMin) && (pSpeedyExecutionCount < m_SP + 1))
            {
                // At this point, we are giving pspeedy SP chances to get at least kmin/2 facilities
                // Perform pspeedy again like we just restarted
                iterationIndex = 0;
                *(inputData.kCenter) = 1;
            }
            else if (*(inputData.kCenter) < m_kMin)
            {
                // At this point, we are now assuming that z is too high and will decrease its value for each new call of pspeedy
                iterationIndex = 0;
                shuffle(inputData.points);
                *(inputData.hiz) = *(inputData.z);
                *(inputData.z) = (*(inputData.hiz) + *(inputData.loz)) / 2.0;
                pSpeedyExecutionCount = 0;
                *(inputData.kCenter) = 1;
            }
            else
                shouldContinue = false;
        }

        while (iterationIndex < inputData.numRead)
        {
            // We will try to pick another center
            bool to_open = false;
            if (iterationIndex != 0)
            {
                to_open = ((float) lrand48() / (float) INT_MAX) < (inputData.points->p[iterationIndex].cost / *(inputData.z));
                if (to_open)
                    (*(inputData.kCenter))++;
            }       
            
            // Command the worker threads (they will not do any operations if to_open is false)
            PSpeedyWorkerProducer producer(inputData.points, inputData.numRead, to_open, iterationIndex, m_ThreadCount);
            PSpeedyWorker workers[m_ThreadCount];
            PSpeedyWorkerConsumer consumer(&totalCost, m_ThreadCount);
            raft::map m;

            for (auto i = 0; i < m_ThreadCount; i++)
                m += producer[std::to_string(i).c_str()] >> workers[i] >> consumer[std::to_string(i).c_str()];

            m.exe();
            iterationIndex++;
        }
    }

    // We are done picking centers, totalCost has the summed cost but we need to add a value onto it first
    totalCost += *(inputData.z) * *(inputData.kCenter);

    input["input"].recycle();
    
    std::cout << "KCenters after all PSpeedy: " << *(inputData.kCenter) << std::endl;
    std::cout << "Cost after all PSpeedy: " << totalCost << std::endl;

    // Push our output
    output["output"].push<PSpeedyCallManager_Output>(PSpeedyCallManager_Output(inputData.points, inputData.numRead, inputData.z, inputData.kCenter, totalCost, inputData.hiz, inputData.loz));
    
    return raft::proceed;
}

PSpeedyWorkerProducer::PSpeedyWorkerProducer(Points* points, size_t numRead, bool work, unsigned int iterationIndex, unsigned int threadCount)
    : raft::kernel(), m_Points(points), m_NumRead(numRead), m_ThreadCount(threadCount), m_Work(work), m_IterationIndex(iterationIndex)
{
    for (auto i = 0; i < m_ThreadCount; i++)
        output.addPort<PSpeedyWorker_Input>(std::to_string(i).c_str());
}

raft::kstatus PSpeedyWorkerProducer::run()
{
    for (auto i = 0; i < m_ThreadCount; i++)
        output[std::to_string(i).c_str()].push<PSpeedyWorker_Input>(PSpeedyWorker_Input(m_Points, m_NumRead, i, m_NumRead/m_ThreadCount, m_IterationIndex, m_Work));

    return raft::stop;
}

PSpeedyWorker::PSpeedyWorker() : raft::kernel()
{
    input.addPort<PSpeedyWorker_Input>("input");
    output.addPort<double>("output");
}

raft::kstatus PSpeedyWorker::run()
{
    //std::cout << "Executing PSpeedyWorker run" << std::endl;
    PSpeedyWorker_Input inputData = input["input"].peek<PSpeedyWorker_Input>();
    double cost = 0.0;
    unsigned int k1 = inputData.blockSize * inputData.tid;
    unsigned int k2 = k1 + inputData.blockSize;
    if (k2 > inputData.numRead) 
        k2 = inputData.numRead;

    Points* points = inputData.points;

    if (inputData.iterationIndex == 0)
    {
        for (auto k = k1; k < k2; k++)
        {
            float distance = dist(points->p[k], points->p[0], points->dim);
            points->p[k].cost = distance * points->p[k].weight;
            points->p[k].assign=inputData.iterationIndex;
        }
    }
    else if (inputData.work)
    {
        // If a center was opened for this iteration
        for (auto k = k1; k < k2; k++)
        {
            float distance = dist(points->p[inputData.iterationIndex], points->p[k], points->dim);
            if (distance * points->p[k].weight < points->p[k].cost)
            {
                points->p[k].cost = distance * points->p[k].weight;
	            points->p[k].assign=inputData.iterationIndex;
            }
        }
    }

    // Sum the costs
    for (auto k = k1; k < k2; k++)
        cost += points->p[k].cost;

    // Push the cost calculated from this worker's points
    output["output"].push<double>(cost);    

    // Cleanup
    input["input"].recycle();

    return raft::proceed;
}

PSpeedyWorkerConsumer::PSpeedyWorkerConsumer(double* cost, unsigned int threadCount)
    : raft::kernel_all(), m_ThreadCount(threadCount), m_Cost(cost)
{
    for (auto i = 0; i < m_ThreadCount; i++)
        input.addPort<double>(std::to_string(i).c_str());
}

raft::kstatus PSpeedyWorkerConsumer::run()
{
    *m_Cost = 0.0;
    for (auto i = 0; i < m_ThreadCount; i++)
    {
        *m_Cost += input[std::to_string(i).c_str()].peek<double>();
        input[std::to_string(i).c_str()].recycle();
    }

    return raft::proceed;
}

SelectFeasible_FastKernel::SelectFeasible_FastKernel(int kmin, unsigned int ITER, bool** is_center)
    : raft::kernel(), m_kMin(kmin), m_ITER(ITER), m_IsCenter(is_center)
{
    input.addPort<PSpeedyCallManager_Output>("input");
    output.addPort<SelectFeasible_FastKernel_Output>("output");
}

raft::kstatus SelectFeasible_FastKernel::run()
{
    std::cout << "Executing SelectFeasible run" << std::endl;
    PSpeedyCallManager_Output inputData = input["input"].peek<PSpeedyCallManager_Output>();
    int numfeasible = (int) inputData.numRead;

    if (numfeasible > (m_ITER * m_kMin * log((double) m_kMin)))
        numfeasible = (int) (m_ITER * m_kMin * log((double) m_kMin));
        
    int* feasible = new int[numfeasible];
    
    //Calcuate my block. 
    //For now this routine does not seem to be the bottleneck, so it is not parallelized. 
    //When necessary, this can be parallelized by setting k1 and k2 to 
    //proper values and calling this routine from all threads ( it is called only
    //by thread 0 for now ). 
    //Note that when parallelized, the randomization might not be the same and it might
    //not be difficult to measure the parallel speed-up for the whole program. 
    
    //  long bsize = numfeasible;
    long k1 = 0;
    long k2 = numfeasible;

    float w;
    int l,r,k;

    // not many points, all will be feasible 
    if (numfeasible == inputData.numRead) 
    {
        for (int i = k1; i < k2; i++)
            feasible[i] = i;
    }
    else
    {
        float* accumweight = new float[inputData.numRead];
        float totalweight=0;

        accumweight[0] = inputData.points->p[0].weight;
        
        for (auto i = 1; i < inputData.numRead; i++ ) 
            accumweight[i] = accumweight[i-1] + inputData.points->p[i].weight;

        totalweight = accumweight[inputData.numRead-1];

        for (auto i = k1; i < k2; i++) 
        {
            w = (lrand48() / (float) INT_MAX) * totalweight;
            //binary search
            l=0;
            r= inputData.numRead - 1;
            if (accumweight[0] > w)  
            { 
                feasible[i] = 0; 
                continue;
            }
            while (l + 1 < r) 
            {
                k = (l + r) / 2;
                if (accumweight[k] > w) 
                    r = k;
                else
                    l = k;
            }
            feasible[i] = r;
        }

        delete[] accumweight; 
    }

    // Will also perform the is_center assignments
    for (auto i = 0; i < inputData.numRead; i++)
        (*m_IsCenter)[inputData.points->p[i].assign] = true;

    output["output"].push<SelectFeasible_FastKernel_Output>(SelectFeasible_FastKernel_Output(inputData.points, inputData.numRead, inputData.z, inputData.kCenter, inputData.cost, inputData.hiz, inputData.loz, numfeasible, feasible));
    input["input"].recycle();

    return raft::proceed;
}

PGainCallManager::PGainCallManager(unsigned int CACHE_LINE, unsigned int threadCount, PGainCallManager_Input inputData)
    : raft::kernel(), m_CL(CACHE_LINE / sizeof(double)), m_ThreadCount(threadCount), m_InputData(inputData)
{
    for (auto i = 0; i < m_ThreadCount; i++)
    {
        // The output will command the worker threads
        output.addPort<PGainWorker1_IO>(std::to_string(i).c_str());
    }
}

raft::kstatus PGainCallManager::run()
{
    std::cout << "Executing PGainCallManager run" << std::endl;
    //PGainCallManager_Input inputData = input["input"].peek<PGainCallManager_Input>();

    // cl and stride are values which are all the same when calculated by each thread...
    // might as well condense the first section of pgain into one thread work.
    unsigned int stride = *(m_InputData.kCenter) + 2;
    if (stride % m_CL != 0)
        stride = m_CL * (stride / m_CL + 1);
    
    // This will need to be deleted at the end of the pgain pipeline
    double* work_mem = new double[stride * (m_ThreadCount + 1)];

    for (auto i = 0; i < m_ThreadCount; i++)
        output[std::to_string(i).c_str()].push<PGainWorker1_IO>(PGainWorker1_IO(m_InputData.points, m_InputData.numRead, m_InputData.z, m_InputData.kCenter, m_InputData.cost, m_InputData.numFeasible, stride, m_CL, work_mem, i, m_InputData.numRead / m_ThreadCount, m_InputData.x));

    return raft::stop;
}

PGainWorker1::PGainWorker1(bool** is_center, int** center_table) 
    : raft::kernel(), m_IsCenter(is_center), m_CenterTable(center_table)
{
    input.addPort<PGainWorker1_IO>("input");
    output.addPort<PGainWorker1_IO>("output");
}

raft::kstatus PGainWorker1::run()
{
    //std::cout << "Executing PGainWorker1 run" << std::endl;
    PGainWorker1_IO inputData = input["input"].peek<PGainWorker1_IO>();

    unsigned int stride = inputData.stride;
    int cl = inputData.cl;
    unsigned int k1 = inputData.blockSize * inputData.tid;
    unsigned int k2 = k1 + inputData.blockSize;
    if (k2 > inputData.numRead)
        k2 = inputData.numRead;

    int count = 0;

    for (auto i = k1; i < k2; i++) 
    {
        if ((*m_IsCenter)[i]) 
            (*m_CenterTable)[i] = count++;
    }
    inputData.work_mem[inputData.tid * stride] = count;

    //std::cout << "Count: " << count << std::endl;

    output["output"].push<PGainWorker1_IO>(PGainWorker1_IO(inputData.points, inputData.numRead, inputData.z, inputData.kCenter, inputData.cost, inputData.numFeasible, inputData.stride, inputData.cl, inputData.work_mem, inputData.tid, inputData.blockSize, inputData.x));
    input["input"].recycle();
    
    return raft::proceed;
}

PGainAccumulator1::PGainAccumulator1(unsigned int threadCount)
    : raft::kernel_all(), m_ThreadCount(threadCount)
{
    for (auto i = 0; i < m_ThreadCount; i++)
    {
        // Input from the worker threads
        input.addPort<PGainWorker1_IO>(std::to_string(i).c_str());

        // The output will command the worker threads
        output.addPort<PGainWorker1_IO>(std::to_string(i).c_str());
    }
}

raft::kstatus PGainAccumulator1::run()
{
    //std::cout << "Executing PGainAccumulator1 run" << std::endl;
    double* work_mem;
    unsigned int stride;

    for (auto i = 0; i < m_ThreadCount; i++)
    {
        PGainWorker1_IO inputData = input[std::to_string(i).c_str()].peek<PGainWorker1_IO>();
        work_mem = inputData.work_mem;
        stride = inputData.stride;
    }

    int accum = 0;
    for (auto p = 0; p < m_ThreadCount; p++)
    {
        int tmp = (int) work_mem[p * stride];
        work_mem[p * stride] = accum;
        accum += tmp;
    }

    for (auto i = 0; i < m_ThreadCount; i++)
    {
        PGainWorker1_IO inputData = input[std::to_string(i).c_str()].peek<PGainWorker1_IO>();
        output[std::to_string(i).c_str()].push<PGainWorker1_IO>(inputData);
        input[std::to_string(i).c_str()].recycle();
    }

    return raft::proceed;
}

PGainWorker2::PGainWorker2(bool** is_center, int** center_table, bool** switch_membership) 
    : raft::kernel(), m_IsCenter(is_center), m_CenterTable(center_table), m_SwitchMembership(switch_membership)
{
    input.addPort<PGainWorker1_IO>("input");
    output.addPort<PGainWorker1_IO>("output");
}

raft::kstatus PGainWorker2::run()
{
    //std::cout << "Executing PGainWorker2 run" << std::endl;
    PGainWorker1_IO inputData = input["input"].peek<PGainWorker1_IO>();

    unsigned int stride = inputData.stride;
    unsigned int k1 = inputData.blockSize * inputData.tid;
    unsigned int k2 = k1 + inputData.blockSize;
    if (k2 > inputData.numRead)
        k2 = inputData.numRead;

    for (auto i = k1; i < k2; i++) 
    {
        if ((*m_IsCenter)[i]) 
            (*m_CenterTable)[i] += (int) inputData.work_mem[inputData.tid * stride];
    }

    //for (auto i = 0; i < inputData.numRead; i++)
    //    std::cout << "Center Table: " << (*m_CenterTable)[i] << std::endl;

    memset(*m_SwitchMembership + k1, 0, (k2 - k1) * sizeof(bool));
    memset(inputData.work_mem + inputData.tid * stride, 0, stride * sizeof(double)); // getting stuck here, sometimes segfaults

    output["output"].push<PGainWorker1_IO>(PGainWorker1_IO(inputData.points, inputData.numRead, inputData.z, inputData.kCenter, inputData.cost, inputData.numFeasible, inputData.stride, inputData.cl, inputData.work_mem, inputData.tid, inputData.blockSize, inputData.x));
    input["input"].recycle();
    
    return raft::proceed;
}

PGainAccumulator2::PGainAccumulator2(unsigned int threadCount)
    : raft::kernel_all(), m_ThreadCount(threadCount)
{
    for (auto i = 0; i < m_ThreadCount; i++)
    {
        // Input from the worker threads
        input.addPort<PGainWorker1_IO>(std::to_string(i).c_str());

        // The output will command the worker threads
        output.addPort<PGainWorker1_IO>(std::to_string(i).c_str());
    }
}

raft::kstatus PGainAccumulator2::run()
{
    //std::cout << "Executing PGainAccumulator2 run" << std::endl;
    double* work_mem;
    unsigned int stride;

    for (auto i = 0; i < m_ThreadCount; i++)
    {
        PGainWorker1_IO inputData = input[std::to_string(i).c_str()].peek<PGainWorker1_IO>();
        work_mem = inputData.work_mem;
        stride = inputData.stride;
    }

    memset(work_mem + m_ThreadCount * stride, 0, stride * sizeof(double));

    for (auto i = 0; i < m_ThreadCount; i++)
    {
        PGainWorker1_IO inputData = input[std::to_string(i).c_str()].peek<PGainWorker1_IO>();
        output[std::to_string(i).c_str()].push<PGainWorker1_IO>(inputData);
        input[std::to_string(i).c_str()].recycle();
    }

    return raft::proceed;
}

PGainWorker3::PGainWorker3(bool** is_center, int** center_table, bool** switch_membership, unsigned int threadCount) 
    : raft::kernel(), m_IsCenter(is_center), m_CenterTable(center_table), m_SwitchMembership(switch_membership), m_ThreadCount(threadCount)
{
    input.addPort<PGainWorker1_IO>("input");
    output.addPort<PGainWorker3_Output>("output");
}

raft::kstatus PGainWorker3::run()
{
    //std::cout << "Executing PGainWorker3 run" << std::endl;
    PGainWorker1_IO inputData = input["input"].peek<PGainWorker1_IO>();

    unsigned int k1 = inputData.blockSize * inputData.tid;
    unsigned int k2 = k1 + inputData.blockSize;
    if (k2 > inputData.numRead)
        k2 = inputData.numRead;

    double* lower = &(inputData.work_mem[inputData.tid * inputData.stride]);
    double* gl_lower = &(inputData.work_mem[m_ThreadCount * inputData.stride]);

    double cost_of_opening_x = 0;

    for (auto i = k1; i < k2; i++)
    {
        float x_cost = dist(inputData.points->p[i], inputData.points->p[inputData.x], inputData.points->dim) * inputData.points->p[i].weight;
        float current_cost = inputData.points->p[i].cost;
        
        if ( x_cost < current_cost ) 
        {
            // point i would save cost just by switching to x
            // (note that i cannot be a median, 
            // or else dist(p[i], p[x]) would be 0)
            (*m_SwitchMembership)[i] = 1;
            cost_of_opening_x += x_cost - current_cost;
            
        } 
        else 
        {
            // cost of assigning i to x is at least current assignment cost of i

            // consider the savings that i's **current** median would realize
            // if we reassigned that median and all its members to x;
            // note we've already accounted for the fact that the median
            // would save z by closing; now we have to subtract from the savings
            // the extra cost of reassigning that median and its members 
            int assign = inputData.points->p[i].assign;
            lower[(*m_CenterTable)[assign]] += current_cost - x_cost;
        }
    }

    output["output"].push<PGainWorker3_Output>(PGainWorker3_Output(inputData.points, inputData.numRead, inputData.z, inputData.kCenter, inputData.cost, inputData.numFeasible, inputData.stride, inputData.cl, inputData.work_mem, inputData.tid, inputData.blockSize, inputData.x, lower, gl_lower, cost_of_opening_x));
    input["input"].recycle();
    
    return raft::proceed;
}

PGainAccumulator3::PGainAccumulator3(unsigned int threadCount)
    : raft::kernel_all(), m_ThreadCount(threadCount)
{
    for (auto i = 0; i < m_ThreadCount; i++)
    {
        // Input from the worker threads
        input.addPort<PGainWorker3_Output>(std::to_string(i).c_str());

        // The output will command the worker threads
        output.addPort<PGainWorker3_Output>(std::to_string(i).c_str());
    }
}

raft::kstatus PGainAccumulator3::run()
{
    //std::cout << "Executing PGainAccumulator3 run" << std::endl;
    for (auto i = 0; i < m_ThreadCount; i++)
    {
        PGainWorker3_Output inputData = input[std::to_string(i).c_str()].peek<PGainWorker3_Output>();
        output[std::to_string(i).c_str()].push<PGainWorker3_Output>(inputData);
        input[std::to_string(i).c_str()].recycle();
    }

    return raft::proceed;
}

PGainWorker4::PGainWorker4(bool** is_center, int** center_table, unsigned int threadCount) 
    : raft::kernel(), m_IsCenter(is_center), m_CenterTable(center_table), m_ThreadCount(threadCount)
{
    input.addPort<PGainWorker3_Output>("input");
    output.addPort<PGainWorker4_Output>("output");
}

raft::kstatus PGainWorker4::run()
{
    //std::cout << "Executing PGainWorker4 run" << std::endl;
    PGainWorker3_Output inputData = input["input"].peek<PGainWorker3_Output>();

    unsigned int k1 = inputData.blockSize * inputData.tid;
    unsigned int k2 = k1 + inputData.blockSize;
    if (k2 > inputData.numRead)
        k2 = inputData.numRead;

    unsigned int number_of_centers_to_close = 0;

    //std::cout << "Number of centers to close prior: " << number_of_centers_to_close << std::endl;
    //std::cout << "Cost of opening x prior: " << inputData.cost_of_opening_x << std::endl;

    for (auto i = k1; i < k2; i++) 
    {
        if ((*m_IsCenter)[i]) 
        {
            double low = *(inputData.z);
            //aggregate from all threads
            for (auto p = 0; p < m_ThreadCount; p++) 
                low += inputData.work_mem[(*m_CenterTable)[i] + p * inputData.stride];
            
            inputData.gl_lower[(*m_CenterTable)[i]] = low;
            if ( low > 0 ) 
            {
                // i is a median, and
                // if we were to open x (which we still may not) we'd close i

                // note, we'll ignore the following quantity unless we do open x
                ++number_of_centers_to_close;  
                inputData.cost_of_opening_x -= low;
            }
        }
    }

    //std::cout << "Number of centers to close: " << number_of_centers_to_close << std::endl;
    //std::cout << "Cost of opening x: " << inputData.cost_of_opening_x << std::endl;

    //use the rest of working memory to store the following
    inputData.work_mem[inputData.tid * inputData.stride + *(inputData.kCenter)] = number_of_centers_to_close;
    inputData.work_mem[inputData.tid * inputData.stride + *(inputData.kCenter) + 1] = inputData.cost_of_opening_x;

    output["output"].push<PGainWorker4_Output>(PGainWorker4_Output(inputData.points, inputData.numRead, inputData.z, inputData.kCenter, inputData.cost, inputData.numFeasible, inputData.stride, inputData.cl, inputData.work_mem, inputData.tid, inputData.blockSize, inputData.x, inputData.lower, inputData.gl_lower, inputData.cost_of_opening_x, number_of_centers_to_close));
    input["input"].recycle();
    
    return raft::proceed;
}

PGainAccumulator4::PGainAccumulator4(unsigned int threadCount)
    : raft::kernel_all(), m_ThreadCount(threadCount)
{
    for (auto i = 0; i < m_ThreadCount; i++)
    {
        // Input from the worker threads
        input.addPort<PGainWorker4_Output>(std::to_string(i).c_str());

        // The output will command the worker threads
        output.addPort<PGainWorker4_Output>(std::to_string(i).c_str());
    }
}

raft::kstatus PGainAccumulator4::run()
{
    //std::cout << "Executing PGainAccumulator4 run" << std::endl;
    unsigned int gl_number_of_centers_to_close = 0;
    double gl_cost_of_opening_x = *(input["0"].peek<PGainWorker4_Output>().z);

    for (auto i = 0; i < m_ThreadCount; i++)
    {
        PGainWorker4_Output inputData = input[std::to_string(i).c_str()].peek<PGainWorker4_Output>();
        gl_number_of_centers_to_close += inputData.number_of_centers_to_close;
        gl_cost_of_opening_x += inputData.cost_of_opening_x;
    }

    for (auto i = 0; i < m_ThreadCount; i++)
    {
        PGainWorker4_Output inputData = input[std::to_string(i).c_str()].peek<PGainWorker4_Output>();
        output[std::to_string(i).c_str()].push<PGainWorker4_Output>(PGainWorker4_Output(inputData.points, inputData.numRead, inputData.z, inputData.kCenter, inputData.cost, inputData.numFeasible, inputData.stride, inputData.cl, inputData.work_mem, inputData.tid, inputData.blockSize, inputData.x, inputData.lower, inputData.gl_lower, gl_cost_of_opening_x, gl_number_of_centers_to_close));
        input[std::to_string(i).c_str()].recycle();
    }

    return raft::proceed;
}

PGainWorker5::PGainWorker5(bool** is_center, int** center_table, bool** switch_membership) 
    : raft::kernel(), m_IsCenter(is_center), m_CenterTable(center_table), m_SwitchMembership(switch_membership)
{
    input.addPort<PGainWorker4_Output>("input");
    output.addPort<PGainWorker4_Output>("output");
}

raft::kstatus PGainWorker5::run()
{
    //std::cout << "Executing PGainWorker5 run" << std::endl;
    PGainWorker4_Output inputData = input["input"].peek<PGainWorker4_Output>();

    unsigned int k1 = inputData.blockSize * inputData.tid;
    unsigned int k2 = k1 + inputData.blockSize;
    if (k2 > inputData.numRead)
        k2 = inputData.numRead;

    if (inputData.cost_of_opening_x < 0)
    {
        //  we'd save money by opening x; we'll do it
        for (auto i = k1; i < k2; i++)
        {
            bool close_center = inputData.gl_lower[(*m_CenterTable)[inputData.points->p[i].assign]] > 0;
            if ((*m_SwitchMembership)[i] || close_center)
            {
                // Either i's median (which may be i itself) is closing,
                // or i is closer to x than to its current median
                inputData.points->p[i].cost = inputData.points->p[i].weight * dist(inputData.points->p[i], inputData.points->p[inputData.x], inputData.points->dim);
                inputData.points->p[i].assign = inputData.x;
            }
        }

        for (auto i = k1; i < k2; i++)
        {
            if ((*m_IsCenter)[i] && inputData.gl_lower[(*m_CenterTable)[i]] > 0)
                (*m_IsCenter)[i] = false;
        }

        if (inputData.x >= k1 && inputData.x < k2)
            (*m_IsCenter)[inputData.x] = true;
    }

    output["output"].push<PGainWorker4_Output>(inputData);
    input["input"].recycle();
    
    return raft::proceed;
}

PGainAccumulator5::PGainAccumulator5(double* result, unsigned int threadCount)
    : raft::kernel_all(), m_ThreadCount(threadCount), m_Result(result)
{
    for (auto i = 0; i < m_ThreadCount; i++)
    {
        // Input from the worker threads
        input.addPort<PGainWorker4_Output>(std::to_string(i).c_str());
    }
}

raft::kstatus PGainAccumulator5::run()
{
    //std::cout << "Executing PGainAccumulator5 run" << std::endl;
    long* kCenter;
    double* work_mem;
    unsigned int gl_number_of_centers_to_close = 0;
    double gl_cost_of_opening_x = 0.0;

    for (auto i = 0; i < m_ThreadCount; i++)
    {
        PGainWorker4_Output inputData = input[std::to_string(i).c_str()].peek<PGainWorker4_Output>();
        kCenter = inputData.kCenter;
        gl_number_of_centers_to_close = inputData.number_of_centers_to_close;
        gl_cost_of_opening_x = inputData.cost_of_opening_x;
        work_mem = inputData.work_mem;
    }

    if (gl_cost_of_opening_x < 0)
    {
        *kCenter = *kCenter + 1 - gl_number_of_centers_to_close;
    }
    else
    {
        gl_cost_of_opening_x = 0.0;
    }

    delete[] work_mem;

    for (auto i = 0; i < m_ThreadCount; i++)
        input[std::to_string(i).c_str()].recycle();

    *m_Result = -gl_cost_of_opening_x;

    return raft::proceed;
}

PFLCallManager::PFLCallManager(unsigned int CL, bool** isCenter, bool** switchMembership, int** centerTable, unsigned int threadCount, PFLCallManager_Input inputData)
    : raft::kernel(), m_CL(CL), m_IsCenter(isCenter), m_SwitchMembership(switchMembership), m_CenterTable(centerTable), m_ThreadCount(threadCount), m_InputData(inputData)
{
    // This is the output of pFL
    output.addPort<double>("output");
}

raft::kstatus PFLCallManager::run()
{
    std::cout << "Executing PFLCallManager run" << std::endl;

    unsigned int iterationIndex = 0;
    double cost = m_InputData.cost;
    double change = m_InputData.cost;

    std::cout << "Z: " << *(m_InputData.z) << std::endl;
    std::cout << "Initial cost: " << cost << std::endl;
    std::cout << "Iter: " << m_InputData.iter << std::endl;
    std::cout << "E: " << m_InputData.e << std::endl;

    while (change / cost > 1.0 * m_InputData.e)
    {
        change = 0.0;
        iterationIndex = 0;
        intshuffle(m_InputData.feasible, m_InputData.numFeasible);

        while (iterationIndex < m_InputData.iter)
        {
            double result = 0.0;

            PGainCallManager manager(m_CL, m_ThreadCount, PGainCallManager_Input(m_InputData.points, m_InputData.numRead, m_InputData.z, m_InputData.kCenter, cost, m_InputData.numFeasible, m_InputData.feasible[iterationIndex % m_InputData.numFeasible], 0));
            PGainWorker1* worker1s[m_ThreadCount];
            PGainAccumulator1 accum1(m_ThreadCount);
            PGainWorker2* worker2s[m_ThreadCount];
            PGainAccumulator2 accum2(m_ThreadCount);
            PGainWorker3* worker3s[m_ThreadCount];
            PGainAccumulator3 accum3(m_ThreadCount);
            PGainWorker4* worker4s[m_ThreadCount];
            PGainAccumulator4 accum4(m_ThreadCount);
            PGainWorker5* worker5s[m_ThreadCount];
            PGainAccumulator5 accum5(&result, m_ThreadCount);
            raft::map m;

            for (auto i = 0; i < m_ThreadCount; i++)
            {
                const char* val = std::to_string(i).c_str();
                worker1s[i] = new PGainWorker1(m_IsCenter, m_CenterTable);
                m += manager[val] >> *(worker1s[i]) >> accum1[val];
                worker2s[i] = new PGainWorker2(m_IsCenter, m_CenterTable, m_SwitchMembership);
                m += accum1[val] >> *(worker2s[i]) >> accum2[val];
                worker3s[i] = new PGainWorker3(m_IsCenter, m_CenterTable, m_SwitchMembership, m_ThreadCount);
                m += accum2[val] >> *(worker3s[i]) >> accum3[val];
                worker4s[i] = new PGainWorker4(m_IsCenter, m_CenterTable, m_ThreadCount);
                m += accum3[val] >> *(worker4s[i]) >> accum4[val];
                worker5s[i] = new PGainWorker5(m_IsCenter, m_CenterTable, m_SwitchMembership);
                m += accum4[val] >> *(worker5s[i]) >> accum5[val];
            }

            m.exe();
            change += result;
            // pgain has completed
            iterationIndex++;

            for (auto i = 0; i < m_ThreadCount; i++)
            {
                delete worker1s[i];
                delete worker2s[i];
                delete worker3s[i];
                delete worker4s[i];
                delete worker5s[i];
            }
        }
        cost -= change;
    }
    std::cout << "PFL Cost Result: " << cost << std::endl;

    output["output"].push<double>(cost);
    return raft::stop;
}

PFLCallConsumer::PFLCallConsumer(double* result)
    : raft::kernel(), m_Result(result)
{
    input.addPort<double>("input");
}

raft::kstatus PFLCallConsumer::run()
{
    *m_Result = input["input"].peek<double>();
    input["input"].recycle();
    return raft::proceed;
}

PKMedianAccumulator2::PKMedianAccumulator2(unsigned int CACHE_LINE, long kmin, long kmax, long* kfinal, unsigned int ITER, bool** isCenter, int** centerTable, bool** switchMembership, unsigned int threadCount)
    : raft::kernel(), m_CL(CACHE_LINE), m_kMin(kmin), m_kMax(kmax), m_ITER(ITER), m_kFinal(kfinal), m_IsCenter(isCenter), m_CenterTable(centerTable), m_SwitchMembership(switchMembership), m_ThreadCount(threadCount)
{
    // This is the entry point to this kernel from selectfeasible_fast
    input.addPort<SelectFeasible_FastKernel_Output>("input");

    output.addPort<ContCentersKernel_Input>("output");
}

raft::kstatus PKMedianAccumulator2::run()
{
    std::cout << "Executing PMedianAccumulator2 kernel" << std::endl;

    // This is the entry in PKMedianPt3
    SelectFeasible_FastKernel_Output inputData = input["input"].peek<SelectFeasible_FastKernel_Output>();
    double cost = inputData.cost;

    while (true)
    {
        std::cout << "Calling pFL" << std::endl;
        PFLCallManager manager(m_CL, m_IsCenter, m_SwitchMembership, m_CenterTable, m_ThreadCount, PFLCallManager_Input(inputData.points, inputData.numRead, inputData.z, inputData.kCenter, cost, inputData.numFeasible, inputData.feasible, (long) (m_ITER * m_kMax * log((double) m_kMax)), 0.1));
        PFLCallConsumer consumer(&cost);
        raft::map m;
        m += manager >> consumer;
        m.exe();

        bool should_run_again = ((*(inputData.kCenter) <= (1.1) * m_kMax) && (*(inputData.kCenter) >= (0.9) * m_kMin)) || ((*(inputData.kCenter) <= m_kMax + 2) && (*(inputData.kCenter) >= m_kMin - 2));
        if (should_run_again)
        {
            std::cout << "Calling pFL a second time" << std::endl;
            PFLCallManager manager1(m_CL, m_IsCenter, m_SwitchMembership, m_CenterTable, m_ThreadCount, PFLCallManager_Input(inputData.points, inputData.numRead, inputData.z, inputData.kCenter, cost, inputData.numFeasible, inputData.feasible, (long) (m_ITER * m_kMax * log((double) m_kMax)), 0.001));
            PFLCallConsumer consumer1(&cost);
            raft::map m1;
            m1 += manager1 >> consumer1;
            m1.exe();
        }

        if (*(inputData.kCenter) > m_kMax)
        {
            *(inputData.loz) = *(inputData.z);
            *(inputData.z) = (*(inputData.hiz) + *(inputData.loz)) / 2.0;
            cost += (*(inputData.z) - *(inputData.loz)) * *(inputData.kCenter);
        }

        if (*(inputData.kCenter) < m_kMin)
        {
            *(inputData.hiz) = *(inputData.z);
            *(inputData.z) = (*(inputData.hiz) + *(inputData.loz)) / 2.0;
            cost += (*(inputData.z) - *(inputData.hiz)) * *(inputData.kCenter);
        }


        bool should_break = ((*(inputData.kCenter) <= m_kMax) && (*(inputData.kCenter) >= m_kMin)) || ((*(inputData.loz) >= (0.999) * *(inputData.hiz)));
        if (should_break)
            break;
    }

    *m_kFinal = *(inputData.kCenter);

    delete[] inputData.feasible;
    delete inputData.hiz;
    delete inputData.loz;
    delete inputData.z;
    delete[] *m_SwitchMembership;
    delete[] *m_IsCenter;
    delete[] *m_CenterTable;

    input["input"].recycle();
    output["output"].push<ContCentersKernel_Input>(ContCentersKernel_Input(inputData.numRead, inputData.points));

    return raft::proceed;
}

ContCentersKernel::ContCentersKernel(Points* points, Points* centers, long* kFinal, long centersize) 
    : raft::kernel(), m_Points(points), m_Centers(centers), m_kFinal(kFinal), m_CenterSize(centersize)
{
    input.addPort<ContCentersKernel_Input>("input_pkmedian2");
    input.addPort<ContCentersKernel_Input>("input_pkmedian1");
    output.addPort<size_t>("output_copy");
    output.addPort<size_t>("output_out");
}

raft::kstatus ContCentersKernel::run()
{
    std::cout << "Executing ContCentersKernel" << std::endl;
    ContCentersKernel_Input inputData;

    if (input["input_pkmedian2"].size() > 0)
    {
        ContCentersKernel_Input temp = input["input_pkmedian2"].peek<ContCentersKernel_Input>();
        inputData.numRead = temp.numRead;
        inputData.points = temp.points;
        input["input_pkmedian2"].recycle();
    }
    else
    {
        ContCentersKernel_Input temp = input["input_pkmedian1"].peek<ContCentersKernel_Input>();
        inputData.numRead = temp.numRead;
        inputData.points = temp.points;
        input["input_pkmedian1"].recycle();
    }
    
    size_t numRead = inputData.numRead;
    Points* points = inputData.points;
    if (points == m_Centers)
        numRead = m_Centers->num;

    float relweight = 0.0;
    for (auto i = 0; i < numRead; i++)
    {
        if (points->p[i].assign != i)
        {
            relweight = points->p[points->p[i].assign].weight + points->p[i].weight;
            relweight = points->p[i].weight / relweight;
            for (auto ii = 0; ii < points->dim; ii++)
            {
                points->p[points->p[i].assign].coord[ii] *= 1.0 - relweight;
                points->p[points->p[i].assign].coord[ii] += points->p[i].coord[ii] * relweight;
            }
            points->p[points->p[i].assign].weight += points->p[i].weight;
        }
    }

    if (*m_kFinal + m_Centers->num > m_CenterSize)
    {
        std::cerr << "No more space for centers!" << std::endl;
        exit(EXIT_FAILURE);
    }

    if (points == m_Points)
    {
        std::cout << "Sending data to copy centers" << std::endl;
        output["output_copy"].push<size_t>(numRead);
    }
    else
    {
        std::cout << "Sending data to output centers" << std::endl;
        output["output_out"].push<size_t>(numRead);
    }
    
    //input["input"].recycle();

    return raft::proceed;
}

CopyCentersKernel::CopyCentersKernel(Points* points, Points* centers, long* centerIDs, long* offset)
    : raft::kernel(), m_Points(points), m_Centers(centers), m_CenterIDs(centerIDs), m_Offset(offset)
{
    input.addPort<size_t>("input");
}

raft::kstatus CopyCentersKernel::run()
{
    std::cout << "Copying centers" << std::endl;
    size_t numRead = input["input"].peek<size_t>();

    bool* is_a_median = new bool[m_Points->num];
    for (auto i = 0; i < m_Points->num; i++)
        is_a_median[i] = 0;

    for (auto i = 0; i < m_Points->num; i++)
        is_a_median[m_Points->p[i].assign] = 1;

    long k = m_Centers->num;

    for (auto i = 0; i < m_Points->num; i++)
    {
        std::cout << i << std::endl;
        if (is_a_median[i])
        {
            memcpy(m_Centers->p[k].coord, m_Points->p[i].coord, m_Points->dim * sizeof(float));
            m_Centers->p[k].weight = m_Points->p[i].weight;
            m_CenterIDs[k] = i + *m_Offset - m_Points->num;
            k++;
        }
    }
    m_Centers->num = k;

    delete[] is_a_median;

    input["input"].recycle();

    std::cout << "Done copying centers" << std::endl;

    return raft::proceed;
}

OutCenterIDsKernel::OutCenterIDsKernel(Points* centers, long* centerIDs, char* outfile)
    : raft::kernel(), m_Centers(centers), m_CenterIDs(centerIDs), m_Outfile(outfile)
{
    input.addPort<size_t>("input");
}

raft::kstatus OutCenterIDsKernel::run()
{
    std::cout << "Outputing center IDs" << std::endl;
    input["input"].recycle();

    FILE* fp = fopen(m_Outfile, "w");
    if (!fp)
    {
        std::cerr << "Error opening " << m_Outfile << std::endl;
        exit(EXIT_FAILURE);
    }

    int* is_a_median = new int[m_Centers->num];
    for (auto i = 0; i < m_Centers->num; i++)
        is_a_median[i] = 0;


    for (auto i = 0; i < m_Centers->num; i++)
        is_a_median[m_Centers->p[i].assign] = 1;

    for (auto i = 0; i < m_Centers->num; i++)
    {
        if (is_a_median[i])
        {
            fprintf(fp, "%lu\n", m_CenterIDs[i]);
            fprintf(fp, "%lf\n", m_Centers->p[i].weight);
            for (auto k = 0; k < m_Centers->dim; k++)
                fprintf(fp, "%lf ", m_Centers->p[i].coord[k]);
            fprintf(fp, "\n\n");
        }
    }
    fclose(fp);

    std::cout << "Done!" << std::endl;
    delete[] is_a_median;

    return raft::stop;
}