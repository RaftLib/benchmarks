#include "kernels.hpp"

PSpeedyCallManager::PSpeedyCallManager(unsigned int threadCount, long kmin, unsigned int SP) : raft::kernel(), m_ThreadCount(threadCount), m_kMin(kmin), m_SP(SP)
{
    // This input will come from whatever function calls pspeedy (should be pkmedian)
    input.addPort<PSpeedyCallManager_Input>("in_main");

    // These inputs and outputs represent the FIFOs for communication with the worker threads
    // This structure is necessary because every iteration that pspeedy runs internally, 
    // the data is potentially updated which influences the next iteration decision-making.
    for (auto i = 0; i < m_ThreadCount; i++)
    {
        // The input will the cost total of each of the worker threads
        // This will not always be used, but it is very little extra computation to total this each time the thread runs
        input.addPort<double>(std::to_string(i).c_str());

        // The output will command the worker threads
        output.addPort<PSpeedyWorker_Input>(std::to_string(i).c_str());
    }

    // This is the result of the pspeedy function operation
    output.addPort<double>("cost");
}

raft::kstatus PSpeedyCallManager::run()
{
    if (input["in_main"].size() > 0)
    {
        // This code runs when PSpeedyCallManager is given data from the call in pkmedian 
        // Should only be called once per iteration
        PSpeedyCallManager_Input inputData = input["in_main"].peek<PSpeedyCallManager_Input>();
        m_Points = inputData.points;
        m_IterationIndex = 0;
        m_NumRead = inputData.numRead;
        m_Z = inputData.z;
        m_kCenter = inputData.kCenter;
        m_PSpeedyExecutionCount = 0;
        m_Hiz = inputData.hiz;
        m_Loz = inputData.loz;

        // Do the initial points shuffle
        shuffle(m_Points);

        // Command the worker threads (the first point is guaranteed to be a center)
        for (auto i = 0; i < m_ThreadCount; i++)
            output[std::to_string(i).c_str()].push<PSpeedyWorker_Input>(PSpeedyWorker_Input(m_Points, i, m_NumRead / m_ThreadCount, m_IterationIndex, m_NumRead, true));

        input["in_main"].recycle();
        m_IterationIndex++;
        *m_kCenter = 1;

        return raft::proceed;
    }
    else
    {
        // We need to wait for all of the worker threads to finish before executing
        bool allThreadsFinished = true;
        for (auto i = 0; i < m_ThreadCount; i++)
        {
            if (input[std::to_string(i).c_str()].size() < 1)
            {
                allThreadsFinished = false;
            }
        }
        if (!allThreadsFinished)
            return raft::proceed;
        
        // Checks that take care of the 3 function calls of pspeedy
        if (m_IterationIndex >= m_NumRead)
        {
            // At this point, an entire function call of "pspeedy" has been completed
            // Now, we need to decide whether to perform another based upon the values of kCenter, kmin, and SP
            m_PSpeedyExecutionCount++;
            *m_kCenter = 1;

            if ((*m_kCenter < m_kMin) && (m_PSpeedyExecutionCount < m_SP + 1))
            {
                // At this point, we are giving pspeedy SP chances to get at least kmin/2 facilities
                // Perform pspeedy again like we just restarted
                m_IterationIndex = 0;
            }
            else if (*m_kCenter < m_kMin)
            {
                // At this point, we are now assuming that z is too high and will decrease its value for each new call of pspeedy
                m_IterationIndex = 0;
                shuffle(m_Points);
                *m_Hiz = *m_Z;
                *m_Z = (*m_Hiz + *m_Loz) / 2.0;
                m_PSpeedyExecutionCount = 0;
            }
        }

        if (m_IterationIndex < m_NumRead)
        {
            // We will try to pick another center
            bool to_open = ((float) lrand48() / (float) INT_MAX) < (m_Points->p[m_IterationIndex].cost / *m_Z);
            if (to_open)
                (*m_kCenter)++;
            
            // Command the worker threads (they will not do any operations if to_open is false)
            for (auto i = 0; i < m_ThreadCount; i++)
                output[std::to_string(i).c_str()].push<PSpeedyWorker_Input>(PSpeedyWorker_Input(m_Points, i, m_NumRead / m_ThreadCount, m_IterationIndex, m_NumRead, to_open));

            m_IterationIndex++;
        }
        else
        {
            // We are done picking centers, sum the costs (with the starting value) and then "return"
            double totalCost = *m_Z * *m_kCenter;
            for (auto i = 0; i < m_ThreadCount; i++)
                totalCost += input[std::to_string(i).c_str()].peek<double>();

            // Cleanup
            for (auto i = 0; i < m_ThreadCount; i++)
                input[std::to_string(i).c_str()].recycle();

            // Push our output
            output["cost"].push<PSpeedyCallManager_Output>(PSpeedyCallManager_Output(m_Points, m_NumRead, m_Z, m_kCenter, totalCost));
            
            return raft::stop;
        }

        // Cleanup
        for (auto i = 0; i < m_ThreadCount; i++)
            input[std::to_string(i).c_str()].recycle();

        return raft::proceed;
    }
}

PSpeedyWorker::PSpeedyWorker() : raft::kernel()
{
    input.addPort<PSpeedyWorker_Input>("input");
    output.addPort<double>("output");
}

raft::kstatus PSpeedyWorker::run()
{
    PSpeedyWorker_Input inputData = input["input"].peek<PSpeedyWorker_Input>();
    double cost = 0.0;
    unsigned int k1 = inputData.blockSize * inputData.tid;
    unsigned int k2 = k1 + inputData.blockSize;
    if (k2 > inputData.numRead) 
        k2 = inputData.numRead;

    Points* points = inputData.points;

    // If a center was opened for this iteration
    if (inputData.work)
    {
        for (auto k = k1; k < k2; k++)
        {
            float distance = dist(points->p[k], points->p[0], points->dim);
            if (distance * points->p[k].weight < points->p[k].cost || inputData.iterationIndex == 0)
            {
                points->p[k].cost = distance * points->p[k].weight;
	            points->p[k].assign=inputData.iterationIndex;
            }
        }
    }

    // Sum the costs
    for (auto k = k1; k < k2; k++)
        cost += points->p[k].cost;

    // Push the cost calculate from this worker's points
    output["output"].push<double>(cost);    

    // Cleanup
    input["input"].recycle();

    return raft::proceed;
}

SelectFeasible_FastKernel::SelectFeasible_FastKernel(int** feasible, int kmin, unsigned int ITER, bool* is_center)
    : raft::kernel(), m_Feasible(feasible), m_kMin(kmin), m_ITER(ITER), m_IsCenter(is_center)
{
    input.addPort<PSpeedyCallManager_Output>("input");
    output.addPort<SelectFeasible_FastKernel_Output>("output");
}

raft::kstatus SelectFeasible_FastKernel::run()
{
    PSpeedyCallManager_Output inputData = input["input"].peek<PSpeedyCallManager_Output>();
    int numfeasible = (int) inputData.numRead;

    if (numfeasible > (m_ITER * m_kMin * log((double) m_kMin)))
        numfeasible = (int) (m_ITER * m_kMin * log((double) m_kMin));
        
    *m_Feasible = new int[numfeasible];
    
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
            (*m_Feasible)[i] = i;
    }
    else
    {
        float* accumweight = new float[inputData.numRead];
        float totalweight=0;

        accumweight[0] = m_Points->p[0].weight;
        
        for (auto i = 1; i < inputData.numRead; i++ ) 
            accumweight[i] = accumweight[i-1] + m_Points->p[i].weight;

        totalweight = accumweight[inputData.numRead-1];

        for (auto i = k1; i < k2; i++) 
        {
            w = (lrand48() / (float) INT_MAX) * totalweight;
            //binary search
            l=0;
            r= inputData.numRead - 1;
            if (accumweight[0] > w)  
            { 
                (*m_Feasible)[i] = 0; 
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
            (*m_Feasible)[i] = r;
        }

        delete[] accumweight; 
    }

    // Will also perform the is_center assignments
    for (auto i = 0; i < inputData.numRead; i++)
        m_IsCenter[m_Points->p[i].assign] = true;

    

    return raft::proceed;
}

PGainCallManager::PGainCallManager(int** feasible, unsigned int CACHE_LINE, unsigned int threadCount)
    : raft::kernel(), m_Feasible(feasible), m_CL(CACHE_LINE / sizeof(double)), m_ThreadCount(threadCount)
{
    input.addPort<PGainCallManager_Input>("input");
    
    for (auto i = 0; i < m_ThreadCount; i++)
    {
        // The output will command the worker threads
        output.addPort<PGainWorker1_IO>(std::to_string(i).c_str());
    }
}

raft::kstatus PGainCallManager::run()
{
    PGainCallManager_Input inputData = input["input"].peek<PGainCallManager_Input>();

    // cl and stride are values which are all the same when calculated by each thread...
    // might as well condense the first section of pgain into one thread work.
    unsigned int stride = *(inputData.kCenter) + 2;
    if (stride % m_CL != 0)
        stride = m_CL * (stride / m_CL + 1);
    
    // This will need to be deleted at the end of the pgain pipeline
    double* work_mem = new double[stride * (m_ThreadCount + 1)];

    for (auto i = 0; i < m_ThreadCount; i++)
        output[std::to_string(i).c_str()].push<PGainWorker1_IO>(PGainWorker1_IO(inputData.points, inputData.numRead, inputData.z, inputData.kCenter, inputData.cost, inputData.numFeasible, stride, m_CL, work_mem, i, inputData.numRead / m_ThreadCount, inputData.x));

    input["input"].recycle();

    return raft::proceed;
}

PGainWorker1::PGainWorker1(bool* is_center, int* center_table) 
    : raft::kernel(), m_IsCenter(is_center), m_CenterTable(center_table)
{
    input.addPort<PGainWorker1_IO>("input");
    output.addPort<PGainWorker1_IO>("output");
}

raft::kstatus PGainWorker1::run()
{
    PGainWorker1_IO inputData = input["input"].peek<PGainWorker1_IO>();

    int stride = inputData.stride;
    int cl = inputData.cl;
    unsigned int k1 = inputData.blockSize * inputData.tid;
    unsigned int k2 = k1 + inputData.blockSize;
    if (k2 > inputData.numRead)
        k2 = inputData.numRead;

    int count = 0;

    for (auto i = k1; i < k2; i++) 
    {
        if (m_IsCenter[i]) 
            m_CenterTable[i] = count++;
    }
    inputData.work_mem[inputData.tid * stride] = count;

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
        output.addPort<PSpeedyWorker_Input>(std::to_string(i).c_str());
    }
}

raft::kstatus PGainAccumulator1::run()
{
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

PGainWorker2::PGainWorker2(bool* is_center, int* center_table, bool* switch_membership) 
    : raft::kernel(), m_IsCenter(is_center), m_CenterTable(center_table), m_SwitchMembership(switch_membership)
{
    input.addPort<PGainWorker1_IO>("input");
    output.addPort<PGainWorker1_IO>("output");
}

raft::kstatus PGainWorker2::run()
{
    PGainWorker1_IO inputData = input["input"].peek<PGainWorker1_IO>();

    int stride = inputData.stride;
    unsigned int k1 = inputData.blockSize * inputData.tid;
    unsigned int k2 = k1 + inputData.blockSize;
    if (k2 > inputData.numRead)
        k2 = inputData.numRead;

    for (auto i = k1; i < k2; i++) 
    {
        if (m_IsCenter[i]) 
            m_CenterTable[i] += (int) inputData.work_mem[inputData.tid * stride];
    }

    memset(m_SwitchMembership + k1, 0, (k2 - k1) * sizeof(bool));
    memset(inputData.work_mem + inputData.tid * stride, 0, stride * sizeof(double));

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
        output.addPort<PSpeedyWorker_Input>(std::to_string(i).c_str());
    }
}

raft::kstatus PGainAccumulator2::run()
{
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

PGainWorker3::PGainWorker3(bool* is_center, int* center_table, bool* switch_membership, unsigned int threadCount) 
    : raft::kernel(), m_IsCenter(is_center), m_CenterTable(center_table), m_SwitchMembership(switch_membership), m_ThreadCount(threadCount)
{
    input.addPort<PGainWorker1_IO>("input");
    output.addPort<PGainWorker3_Output>("output");
}

raft::kstatus PGainWorker3::run()
{
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
            
            m_SwitchMembership[i] = 1;
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
            lower[m_CenterTable[assign]] += current_cost - x_cost;
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
        output.addPort<PSpeedyWorker_Input>(std::to_string(i).c_str());
    }
}

raft::kstatus PGainAccumulator3::run()
{
    for (auto i = 0; i < m_ThreadCount; i++)
    {
        PGainWorker3_Output inputData = input[std::to_string(i).c_str()].peek<PGainWorker3_Output>();
        output[std::to_string(i).c_str()].push<PGainWorker3_Output>(inputData);
        input[std::to_string(i).c_str()].recycle();
    }

    return raft::proceed;
}

PGainWorker4::PGainWorker4(bool* is_center, int* center_table, unsigned int threadCount) 
    : raft::kernel(), m_IsCenter(is_center), m_CenterTable(center_table), m_ThreadCount(threadCount)
{
    input.addPort<PGainWorker3_Output>("input");
    output.addPort<PGainWorker4_Output>("output");
}

raft::kstatus PGainWorker4::run()
{
    PGainWorker3_Output inputData = input["input"].peek<PGainWorker3_Output>();

    unsigned int k1 = inputData.blockSize * inputData.tid;
    unsigned int k2 = k1 + inputData.blockSize;
    if (k2 > inputData.numRead)
        k2 = inputData.numRead;

    unsigned int number_of_centers_to_close;

    for (auto i = k1; i < k2; i++) 
    {
        if (m_IsCenter[i]) 
        {
            double low = *(inputData.z);
            //aggregate from all threads
            for (auto p = 0; p < m_ThreadCount; p++) 
                low += inputData.work_mem[m_CenterTable[i] + p * inputData.stride];
            
            inputData.gl_lower[m_CenterTable[i]] = low;
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
        output.addPort<PSpeedyWorker_Input>(std::to_string(i).c_str());
    }
}

raft::kstatus PGainAccumulator4::run()
{
    unsigned int gl_number_of_centers_to_close = 0;
    double gl_cost_of_opening_x = 0.0;

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

PGainWorker5::PGainWorker5(bool* is_center, int* center_table, bool* switch_membership) 
    : raft::kernel(), m_IsCenter(is_center), m_CenterTable(center_table), m_SwitchMembership(switch_membership)
{
    input.addPort<PGainWorker3_Output>("input");
    output.addPort<PGainWorker4_Output>("output");
}

raft::kstatus PGainWorker5::run()
{
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
            bool close_center = inputData.gl_lower[m_CenterTable[inputData.points->p[i].assign]] > 0;
            if (m_SwitchMembership[i] || close_center)
            {
                // Either i's median (which may be i itself) is closing,
                // or i is closer to x than to its current median
                inputData.points->p[i].cost = inputData.points->p[i].weight * dist(inputData.points->p[i], inputData.points->p[inputData.x], inputData.points->dim);
                inputData.points->p[i].assign = inputData.x;
            }
        }

        for (auto i = k1; i < k2; i++)
        {
            if (m_IsCenter[i] && inputData.gl_lower[m_CenterTable[i]] > 0)
                m_IsCenter[i] = false;
        }

        if (inputData.x >= k1 && inputData.x < k2)
            m_IsCenter[inputData.x] = true;
    }

    output["output"].push<PGainWorker4_Output>(inputData);
    input["input"].recycle();
    
    return raft::proceed;
}

PGainAccumulator5::PGainAccumulator5(unsigned int threadCount)
    : raft::kernel_all(), m_ThreadCount(threadCount)
{
    for (auto i = 0; i < m_ThreadCount; i++)
    {
        // Input from the worker threads
        input.addPort<PGainWorker4_Output>(std::to_string(i).c_str());
    }

    output.addPort<double>("output");
}

raft::kstatus PGainAccumulator5::run()
{
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

    output["output"].push<double>(-gl_cost_of_opening_x);

    return raft::proceed;
}

PFLCallManager::PFLCallManager()
    : raft::kernel(), m_Change(0.0)
{
    // This is for when pFL is called in the code
    input.addPort<PFLCallManager_Input>("input_main");

    // This is for the result of pgain
    input.addPort<double>("input_change");

    // This is for calling pgain
    output.addPort<PGainCallManager_Input>("output_pgain");

    // This is the output of pFL
    output.addPort<double>("output_cost");
}

raft::kstatus PFLCallManager::run()
{
    if (input["input_main"].size() > 0)
    {
        // This is a call for pFL
        PFLCallManager_Input inputData = input["input_main"].peek<PFLCallManager_Input>();
        m_Change = inputData.cost;
        m_Cost = inputData.cost;
        m_E = inputData.e;
        m_Points = inputData.points;
        m_NumRead = inputData.numRead;
        m_Z = inputData.z;
        m_kCenter = inputData.kCenter;
        m_Iter = inputData.iter;
        m_NumFeasible = inputData.numFeasible;
        m_Feasible = inputData.feasible;
        m_IterationIndex = 0;

        intshuffle(m_Feasible, m_NumFeasible);

        output["output_pgain"].push<PGainCallManager_Input>(PGainCallManager_Input(m_Points, m_NumRead, m_Z, m_kCenter, m_Cost, m_NumFeasible, m_IterationIndex % m_NumFeasible, 0));
        input["input_main"].recycle();

        return raft::proceed;
    }
    else if (input["input_change"].size() > 0)
    {
        // pgain has completed
        m_IterationIndex++;

        m_Change += input["input_change"].peek<double>();
        input["input_chance"].recycle();

        if (m_IterationIndex >= m_Iter)
        {
            m_Cost -= m_Change;
            if (m_Change / m_Cost > 1.0 * m_E)
            {
                m_IterationIndex = 0;
                m_Change = 0.0;
                intshuffle(m_Feasible, m_NumFeasible);
            }
        }

        if (m_IterationIndex < m_Iter)
            output["output_pgain"].push<PGainCallManager_Input>(PGainCallManager_Input(m_Points, m_NumRead, m_Z, m_kCenter, m_Cost, m_NumFeasible, m_IterationIndex % m_NumFeasible, 0));
        else
            output["output_cost"].push<double>(m_Cost);

        return raft::proceed;
    }

    return raft::proceed;
}

