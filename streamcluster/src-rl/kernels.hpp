/*
 * Copyright (C) 2008 Princeton University
 * All rights reserved.
 * Authors: Jia Deng, Gilberto Contreras
 *
 * streamcluster - Online clustering algorithm
 *
 */

/**
 * kernels.hpp -
 * @author: James Wood
 * @version: Thu July 23 13:25:00 2020
 *
 * Copyright 2020 Jonathan Beard
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef KERNELS_HPP
#define KERNELS_HPP

#include "streamcluster.hpp"
#include <raft>

// Stream Reading ----------------------------------------------------------------------------------------

/** 
 * Output data of PStreamReader to the rest of the pipeline (LocalSearchStarter)
 */
struct PStreamReader_Output
{
    size_t numRead;
    bool useCenters;

    PStreamReader_Output() : numRead(0), useCenters(false) {}
    PStreamReader_Output(size_t numRead, bool useCenters) : numRead(numRead), useCenters(useCenters) {}
};

/**
 * Manages a PStream of data for the pipeline. Has no inputs, output connects to a LocalSearchStarter.
 */
class PStreamReader : public raft::kernel
{
private:
    PStream* m_Stream;
    int m_Dim;
    long m_ChunkSize;
    float* m_Block;

    bool* m_Continue;
    long* m_IDoffset;

public:
    PStreamReader(PStream* stream, float* block, int dim, long chunkSize, bool* shouldContinue, long* IDoffset);
    virtual raft::kstatus run();
};

// Stream Reading ----------------------------------------------------------------------------------------

// Local Search ----------------------------------------------------------------------------------------

/**
 *  Output data of LocalSearchStarter to the rest of the pipeline (PKMedianWorkers)
 */
struct LocalSearchStarter_Output
{
    Points* points;
    size_t numRead;
    size_t blockSize;
    unsigned int tid;

    LocalSearchStarter_Output() : points(nullptr), numRead(0), blockSize(0), tid(0) {}
    LocalSearchStarter_Output(Points* points, size_t numRead, size_t blockSize, unsigned int tid) : points(points), numRead(numRead), blockSize(blockSize), tid(tid) {}
};

/**
 *  Processes data from the PStreamReader and initializes data for the local search process. Input from PStreamReader, output to PKMedianWorkers.
 */
class LocalSearchStarter : public raft::kernel
{
private:
    Points* m_Points;
    Points* m_Centers;
    unsigned int m_ThreadCount;
    bool** m_IsCenter;
    int** m_CenterTable;
    bool** m_SwitchMembership;
public:
    LocalSearchStarter(Points* points, Points* centers, unsigned int threadCount, bool** isCenter, int** centerTable, bool** switchMembership);
    virtual raft::kstatus run();
};

// Local Search ----------------------------------------------------------------------------------------

// pkmedian ----------------------------------------------------------------------------------------

/**
 *  Output data of a PKMedianWorker, contains the calculated hiz values of its assigned points.
 */
struct PKMedianWorker_Output
{
    Points* points;
    size_t numRead;
    double hiz;

    PKMedianWorker_Output() : points(nullptr), numRead(0), hiz(0.0) {}
    PKMedianWorker_Output(Points* points, size_t numRead, double hiz) : points(points), numRead(numRead), hiz(hiz) {}
};

/**
 *  Performs the initial calculation of the "hiz' value. Input from a LocalSearchStarter, output to PKMedianAccumulator1.
 */
class PKMedianWorker : public raft::kernel
{
public:
    PKMedianWorker();
    virtual raft::kstatus run();
};

/**
 *  Sums the calculated hiz value of each worker kernel, and creates the initial values of z, loz, and kCenter.
 */
class PKMedianAccumulator1 : public raft::kernel_all
{
private:
    long m_kMin;
    long m_kMax;
    long* m_kFinal;
    unsigned int m_ThreadCount;
public:
    PKMedianAccumulator1(long kmin, long kmax, long* kFinal, unsigned int threadCount);
    virtual raft::kstatus run();
};

// pkmedian ----------------------------------------------------------------------------------------

// pspeedy ----------------------------------------------------------------------------------------

/**
 *  Input data for the PSpeedyCallManager, effectively all of the information gathered so far and for an execution of pspeedy.
 */
struct PSpeedyCallManager_Input
{
    Points* points;
    size_t numRead;
    double* z;
    double* hiz;
    double* loz;
    long* kCenter;

    PSpeedyCallManager_Input() {}
    PSpeedyCallManager_Input(Points* points, size_t numRead, double* z, long* kCenter, double* hiz, double* loz) : points(points), numRead(numRead), z(z), hiz(hiz), loz(loz), kCenter(kCenter) {}
};

/**
 *  Output data from PSpeedyCallManager, it includes the calculated cost after all pspeedy calls have been made.
 */
struct PSpeedyCallManager_Output
{
    Points* points;
    size_t numRead;
    double* z;
    double* hiz;
    double* loz;
    long* kCenter;
    double cost;

    PSpeedyCallManager_Output() {}
    PSpeedyCallManager_Output(Points* points, size_t numRead, double* z, long* kCenter, double cost, double* hiz, double* loz) : points(points), numRead(numRead), z(z), hiz(hiz), loz(loz), kCenter(kCenter), cost(cost) {}
};

/**
 *  Input data for a PSpeedyWorker, including whether a center has been opened this iteration (work).
 */
struct PSpeedyWorker_Input
{
    Points* points;
    size_t numRead;
    unsigned int tid;
    unsigned int blockSize;
    unsigned int iterationIndex;
    bool work;

    PSpeedyWorker_Input() {}
    PSpeedyWorker_Input(Points* points, size_t numRead, unsigned int tid, unsigned int blockSize, unsigned int iterationIndex, bool work) : points(points), numRead(numRead), tid(tid), blockSize(blockSize), iterationIndex(iterationIndex), work(work) {}
};

/**
 *  PSpeedyCallManager encapsulates all of the pspeedy calls from the original code, deciding when to continue or stop executing on its own.
 *  Input from PKMedianAccumulator 1, output to SelectFeasible.
 */
class PSpeedyCallManager : public raft::kernel
{
private:
    long m_kMin;
    unsigned int m_SP;
    unsigned int m_ThreadCount;
public:
    PSpeedyCallManager(unsigned int threadCount, long kmin, unsigned int SP);
    virtual raft::kstatus run();
};

/**
 *  Producer kernel for the internal pspeedy pipeline, this notifies the workers to begin working. Outputs to PSpeedyWorker.
 */
class PSpeedyWorkerProducer : public raft::kernel
{
private:
    Points* m_Points;
    size_t m_NumRead;
    unsigned int m_ThreadCount;
    unsigned int m_IterationIndex;
    bool m_Work;
public:
    PSpeedyWorkerProducer(Points* points, size_t numRead, bool work, unsigned int iterationIndex, unsigned int threadCount);
    virtual raft::kstatus run();
};

/**
 *  PSpeedyWorker executes all of the calculations performed within pspeedy. Input from PSpeedyWorkerProducer, output to PSpeedyWorkerConsumer.
 */
class PSpeedyWorker : public raft::kernel
{
public:
    PSpeedyWorker();
    virtual raft::kstatus run();
};

/**
 *  Consumer kernel for the internal pspeedy pipeline, this sums all of the worker kernel work into one place. Input from PSpeedyWorker.
 */
class PSpeedyWorkerConsumer : public raft::kernel_all
{
private:
    double* m_Cost;
    unsigned int m_ThreadCount;
public:
    PSpeedyWorkerConsumer(double* cost, unsigned int threadCount);
    virtual raft::kstatus run();
};

// pspeedy ----------------------------------------------------------------------------------------

// selectFeasibleFast ----------------------------------------------------------------------------------------

/**
 *  Output data for SelectFeasible_FastKernel, contains the newly calculated numFeasible and int[] feasible data.
 */
struct SelectFeasible_FastKernel_Output
{
    Points* points;
    size_t numRead;
    double* z;
    double* hiz;
    double* loz;
    long* kCenter;
    double cost;
    int numFeasible;
    int* feasible;

    SelectFeasible_FastKernel_Output() {}
    SelectFeasible_FastKernel_Output(Points* points, size_t numRead, double* z, long* kCenter, double cost, double* hiz, double* loz, int numFeasible, int* feasible) 
        : points(points), numRead(numRead), z(z), hiz(hiz), loz(loz), kCenter(kCenter), cost(cost), numFeasible(numFeasible), feasible(feasible) {}
};

/**
 *  Performs the selectFeasible_fast operation. Input from PSpeedyCallManager, output to PFLCallManager.
 */
class SelectFeasible_FastKernel : public raft::kernel
{
private:
    int m_kMin;
    unsigned int m_ITER;
    bool** m_IsCenter;
public:
    SelectFeasible_FastKernel(int kmin, unsigned int ITER, bool** is_center);
    virtual raft::kstatus run();
};

// selectFeasibleFast ----------------------------------------------------------------------------------------

// pgain ----------------------------------------------------------------------------------------

/**
 *  Input for the internal pgain pipeline. This contains all necessary information for an entire iteration of pgain.
 */
struct PGainCallManager_Input
{
    Points* points;
    size_t numRead;
    double* z;
    long* kCenter;
    double cost;
    int numFeasible;
    unsigned int x;
    unsigned int tid;

    PGainCallManager_Input() {}
    PGainCallManager_Input(Points* points, size_t numRead, double* z, long* kCenter, double cost, int numFeasible, unsigned int x, unsigned int tid) : points(points), numRead(numRead), z(z), kCenter(kCenter), cost(cost), numFeasible(numFeasible), x(x), tid(tid) {}
};

/**
 *  PGainCallManager is used whenever a call to pgain is used in the original code. It is formed as a internal pipeline within pFL. Outputs to PGainWorker1.
 */
class PGainCallManager : public raft::kernel
{
private:
    unsigned int m_CL;
    unsigned int m_ThreadCount;
    PGainCallManager_Input m_InputData;
public:
    PGainCallManager(unsigned int CACHE_LINE, unsigned int threadCount, PGainCallManager_Input inputData);
    virtual raft::kstatus run();
};

/**
 *  Manages data for the first few stages of the pgain pipeline.
 */
struct PGainWorker1_IO
{
    Points* points;
    size_t numRead;
    size_t blockSize;
    double* z;
    long* kCenter;
    double cost;
    int numFeasible;
    unsigned int stride;
    unsigned int cl;
    double* work_mem;
    unsigned int tid;
    unsigned int x;

    PGainWorker1_IO() {}
    PGainWorker1_IO(Points* points, size_t numRead, double* z, long* kCenter, double cost, int numFeasible, unsigned int stride, unsigned int cl, double* work_mem, unsigned int tid, size_t blockSize, unsigned int x) 
        : points(points), numRead(numRead), blockSize(blockSize), z(z), kCenter(kCenter), cost(cost), numFeasible(numFeasible), stride(stride), cl(cl), work_mem(work_mem), tid(tid), x(x) {}
};

/**
 *  First stage of calculations within the pgain function.
 */
class PGainWorker1 : public raft::kernel
{
private:
    bool** m_IsCenter;
    int** m_CenterTable;
public:
    PGainWorker1(bool** is_center, int** center_table);
    virtual raft::kstatus run(); 
};

/**
 *  Consolidates calculations from the first stage of the pgain function.
 */
class PGainAccumulator1 : public raft::kernel_all
{
private:
    unsigned int m_ThreadCount;
public:
    PGainAccumulator1(unsigned int threadCount);
    virtual raft::kstatus run();
};

/**
 *  Second stage of calculations within the pgain function.
 */
class PGainWorker2 : public raft::kernel
{
private:
    bool** m_IsCenter;
    int** m_CenterTable;
    bool** m_SwitchMembership;
public:
    PGainWorker2(bool** is_center, int** center_table, bool** switch_membership);
    virtual raft::kstatus run(); 
};

/**
 *  Consolidates calculations from the second stage of the pgain function.
 */
class PGainAccumulator2 : public raft::kernel_all
{
private:
    unsigned int m_ThreadCount;
public:
    PGainAccumulator2(unsigned int threadCount);
    virtual raft::kstatus run();
};

/**
 *  Third stage of calculations within the pgain function.
 */
class PGainWorker3 : public raft::kernel
{
private:
    bool** m_IsCenter;
    int** m_CenterTable;
    bool** m_SwitchMembership;
    unsigned int m_ThreadCount;
public:
    PGainWorker3(bool** is_center, int** center_table, bool** switch_membership, unsigned int m_ThreadCount);
    virtual raft::kstatus run(); 
};

/**
 *  Manages the output data from the third stage of the pgain pipeline. 
 */
struct PGainWorker3_Output
{
    Points* points;
    size_t numRead;
    size_t blockSize;
    double* z;
    long* kCenter;
    double cost;
    int numFeasible;
    unsigned int stride;
    unsigned int cl;
    double* work_mem;
    unsigned int tid;
    unsigned int x;
    double* lower;
    double* gl_lower;
    double cost_of_opening_x;

    PGainWorker3_Output() {}
    PGainWorker3_Output(Points* points, size_t numRead, double* z, long* kCenter, double cost, int numFeasible, unsigned int stride, unsigned int cl, double* work_mem, unsigned int tid, size_t blockSize, unsigned int x, double* lower, double* gl_lower, double cost_of_opening_x) 
        :   points(points), numRead(numRead), blockSize(blockSize), z(z), kCenter(kCenter), cost(cost), numFeasible(numFeasible), stride(stride), cl(cl), work_mem(work_mem), tid(tid), x(x), lower(lower), gl_lower(gl_lower), cost_of_opening_x(cost_of_opening_x) {}
};

/**
 *  Consolidates calculkations from the third stage of the pgain function.
 */
class PGainAccumulator3 : public raft::kernel_all
{
private:
    unsigned int m_ThreadCount;
public:
    PGainAccumulator3(unsigned int threadCount);
    virtual raft::kstatus run();
};

/**
 *  Fourth stage of calculations within the pgain function.
 */
class PGainWorker4 : public raft::kernel
{
private:
    bool** m_IsCenter;
    int** m_CenterTable;
    unsigned int m_ThreadCount;
public:
    PGainWorker4(bool** is_center, int** center_table, unsigned int m_ThreadCount);
    virtual raft::kstatus run(); 
};

/**
 *  Manages the output data from the fourth stage of the pgain pipeline.
 */
struct PGainWorker4_Output
{
    Points* points;
    size_t numRead;
    size_t blockSize;
    double* z;
    long* kCenter;
    double cost;
    int numFeasible;
    unsigned int stride;
    unsigned int cl;
    double* work_mem;
    unsigned int tid;
    unsigned int x;
    double* lower;
    double* gl_lower;
    double cost_of_opening_x;
    unsigned int number_of_centers_to_close;

    PGainWorker4_Output() {}
    PGainWorker4_Output(Points* points, size_t numRead, double* z, long* kCenter, double cost, int numFeasible, unsigned int stride, unsigned int cl, double* work_mem, unsigned int tid, size_t blockSize, unsigned int x, double* lower, double* gl_lower, double cost_of_opening_x, unsigned int number_of_centers_to_close) 
        :   points(points), numRead(numRead), blockSize(blockSize), z(z), kCenter(kCenter), cost(cost), numFeasible(numFeasible), stride(stride), cl(cl), work_mem(work_mem), tid(tid), x(x), lower(lower), gl_lower(gl_lower), cost_of_opening_x(cost_of_opening_x), number_of_centers_to_close(number_of_centers_to_close) {}
};

/**
 *  Consolidates calculations from the fourth stage of the pgain function.
 */
class PGainAccumulator4 : public raft::kernel_all
{
private:
    unsigned int m_ThreadCount;
public:
    PGainAccumulator4(unsigned int threadCount);
    virtual raft::kstatus run();
};

/**
 *  Fifth and final stage of calculations within the pgain function.
 */
class PGainWorker5 : public raft::kernel
{
private:
    bool** m_IsCenter;
    int** m_CenterTable;
    bool** m_SwitchMembership;
public:
    PGainWorker5(bool** is_center, int** center_table, bool** switch_membership);
    virtual raft::kstatus run(); 
};

/**
 *  Consolidates calculations from the fifth stage of the pgain function, and outputs the result to a given pointer.
 */
class PGainAccumulator5 : public raft::kernel_all
{
private:
    double* m_Result;
    unsigned int m_ThreadCount;
public:
    PGainAccumulator5(double* result, unsigned int threadCount);
    virtual raft::kstatus run();
};

// pgain ----------------------------------------------------------------------------------------

// pFL ----------------------------------------------------------------------------------------

/**
 *  Handles all of the input information up to the calls for pFL in the code. 
 */
struct PFLCallManager_Input
{
    Points* points;
    size_t numRead;
    double* z;
    long* kCenter;
    double cost;
    long iter;
    float e;
    int numFeasible;
    int* feasible;

    PFLCallManager_Input() {}
    PFLCallManager_Input(Points* points, size_t numRead, double* z, long* kCenter, double cost, int numFeasible, int* feasible, long iter, double e) 
        : points(points), numRead(numRead), z(z), kCenter(kCenter), cost(cost), iter(iter), e(e), numFeasible(numFeasible), feasible(feasible) {}
};

/**
 *  PFLCallManager is used whenever a call to pFL is made in the original code. It manages the internal pFL pipeline calls. Used within PKMedianAccumulator2.
 */
class PFLCallManager : public raft::kernel
{
private:
    unsigned int m_CL;
    bool** m_IsCenter;
    int** m_CenterTable;
    bool** m_SwitchMembership;
    unsigned int m_ThreadCount;
    PFLCallManager_Input m_InputData;
public:
    PFLCallManager(unsigned int CL, bool** isCenter, bool** switchMembership, int** centerTable, unsigned int threadCount, PFLCallManager_Input inputData);
    virtual raft::kstatus run();
};

/**
 *  Consumer for the pFL pipeline. Stores the result in a pointer.
 */
class PFLCallConsumer : public raft::kernel
{
private:
    double* m_Result;
public:
    PFLCallConsumer(double* result);
    virtual raft::kstatus run();
};

// pFL ----------------------------------------------------------------------------------------

// pkmedian ----------------------------------------------------------------------------------------

/**
 *  The latter half of the work done within the pkmedian function. Manages calls to pFL, which also manages calls to pGain. Input from selectFeasible, output to contCenters.
 */
class PKMedianAccumulator2 : public raft::kernel
{
private:
    long m_kMin;
    long m_kMax;
    long* m_kFinal;
    unsigned int m_ITER;
    bool** m_IsCenter;
    bool** m_SwitchMembership;
    int** m_CenterTable;
    unsigned int m_CL;
    unsigned int m_ThreadCount;
public:
    PKMedianAccumulator2(unsigned int CACHE_LINE, long kmin, long kmax, long* kfinal, unsigned int ITER, bool** isCenter, int** centerTable, bool** switchMembership, unsigned int m_ThreadCount);
    virtual raft::kstatus run();
};

// pkmedian ----------------------------------------------------------------------------------------

// contCenters ----------------------------------------------------------------------------------------

/**
 *  Handles the input information necessary for ContCenters to operate. 
 */
struct ContCentersKernel_Input
{
    size_t numRead;
    Points* points;

    ContCentersKernel_Input() : numRead(0), points(nullptr) {}
    ContCentersKernel_Input(size_t numRead, Points* points) : numRead(numRead), points(points) {}
};

/**
 *  Performs the operations necessary for the contCenters function, and then decides whether information is sent to copyCenters or outCenters. Input from PKMedianAccumulator2.
 */
class ContCentersKernel : public raft::kernel
{
    Points* m_Points;
    Points* m_Centers;
    long* m_kFinal;
    long m_CenterSize;
public:
    ContCentersKernel(Points* points, Points* centers, long* kFinal, long centersize);
    virtual raft::kstatus run();
};

// contCenters ----------------------------------------------------------------------------------------

// copyCenters ----------------------------------------------------------------------------------------

/**
 *  Performs the operations necessary for the copyCenters function, and terminates the pipeline.
 */
class CopyCentersKernel : public raft::kernel
{
private:
    Points* m_Points;
    Points* m_Centers;
    long* m_CenterIDs;
    long* m_Offset;
public:
    CopyCentersKernel(Points* points, Points* centers, long* centerIDs, long* offset);
    virtual raft::kstatus run();
};

// copyCenters ----------------------------------------------------------------------------------------

// outCenters ----------------------------------------------------------------------------------------

/**
 *  Performs the operations necessary for the outCenters function, and teminates the pipeline.
 */
class OutCenterIDsKernel : public raft::kernel
{
private:
    Points* m_Centers;
    long* m_CenterIDs;
    char* m_Outfile;
public:
    OutCenterIDsKernel(Points* centers, long* centerIDs, char* outfile);
    virtual raft::kstatus run();
};

// copyCenters ----------------------------------------------------------------------------------------

#endif