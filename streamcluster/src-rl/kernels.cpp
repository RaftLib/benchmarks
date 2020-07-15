#include "kernels.hpp"

PSpeedyCallManager::PSpeedyCallManager(unsigned int threadCount) : raft::kernel(), m_ThreadCount(threadCount)
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

        // Command the worker threads (the first point is guaranteed to be a center)
        for (auto i = 0; i < m_ThreadCount; i++)
            output[std::to_string(i).c_str()].push<PSpeedyWorker_Input>(PSpeedyWorker_Input(m_Points, i, m_NumRead / m_ThreadCount, m_IterationIndex, m_NumRead, false, true));

        input["in_main"].recycle();
        m_IterationIndex++;
        *m_kCenter = 1;
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
        
        if (m_IterationIndex < m_NumRead)
        {
            // We will try to pick another center
            bool to_open = ((float) lrand48() / (float) INT_MAX) < (m_Points->p[m_IterationIndex].cost / *m_Z);
            if (to_open)
                (*m_kCenter)++;
            
            // Command the worker threads (they will not do any operations if to_open is false)
            for (auto i = 0; i < m_ThreadCount; i++)
                output[std::to_string(i).c_str()].push<PSpeedyWorker_Input>(PSpeedyWorker_Input(m_Points, i, m_NumRead / m_ThreadCount, m_IterationIndex, m_NumRead, true, to_open));

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
            if (distance * points->p[k].weight < points->p[k].cost || !inputData.checkCost)
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
