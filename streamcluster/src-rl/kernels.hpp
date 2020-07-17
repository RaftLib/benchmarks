#ifndef KERNELS_HPP
#define KERNELS_HPP

#include "streamcluster.hpp"
#include <raft>

struct PSpeedyCallManager_Input
{
    Points* points;
    size_t numRead;
    double* z;
    double* hiz;
    double* loz;
    long* kCenter;

    PSpeedyCallManager_Input() : points(nullptr), numRead(0), z(nullptr), kCenter(nullptr), hiz(nullptr), loz(nullptr) {}
    PSpeedyCallManager_Input(Points* points, size_t numRead, double* z, long* kCenter, double* hiz, double* loz) : points(points), numRead(numRead), z(z), kCenter(kCenter), hiz(hiz), loz(loz) {}
};

struct PSpeedyCallManager_Output
{
    Points* points;
    size_t numRead;
    double* z;
    long* kCenter;
    double cost;

    PSpeedyCallManager_Output() : points(nullptr), numRead(0), z(nullptr), kCenter(nullptr), cost(0.0) {}
    PSpeedyCallManager_Output(Points* points, size_t numRead, double* z, long* kCenter, double cost) : points(points), numRead(numRead), z(z), kCenter(kCenter), cost(cost) {}
};

struct PSpeedyWorker_Input
{
    Points* points;
    size_t numRead;
    unsigned int tid;
    unsigned int blockSize;
    unsigned int iterationIndex;
    bool work;

    PSpeedyWorker_Input() : points(nullptr), tid(0), work(false), blockSize(0), numRead(0), iterationIndex(0) {}
    PSpeedyWorker_Input(Points* points, unsigned int tid, unsigned int blockSize, unsigned int iterationIndex, size_t numRead, bool work) : points(points), tid(tid), work(work), blockSize(blockSize), numRead(numRead), iterationIndex(iterationIndex) {}
};

class PSpeedyCallManager : public raft::kernel
{
private:
    Points* m_Points;
    size_t m_NumRead;
    long m_kMin;
    unsigned int m_SP;
    double* m_Z;
    double* m_Hiz;
    double* m_Loz;
    long* m_kCenter;
    unsigned int m_ThreadCount;
    unsigned int m_IterationIndex;
    unsigned int m_PSpeedyExecutionCount;
public:
    PSpeedyCallManager(unsigned int threadCount, long kmin, unsigned int SP);
    virtual raft::kstatus run();
};

class PSpeedyWorker : public raft::kernel
{
public:
    PSpeedyWorker();
    virtual raft::kstatus run();
};

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

    SelectFeasible_FastKernel_Output() : points(nullptr), numRead(0), z(nullptr), kCenter(nullptr), cost(0.0), hiz(nullptr), loz(nullptr), numFeasible(0) {}
    SelectFeasible_FastKernel_Output(Points* points, size_t numRead, double* z, long* kCenter, double cost, double* hiz, double* loz, int numFeasible) : points(points), numRead(numRead), z(z), kCenter(kCenter), cost(cost), hiz(hiz), loz(loz), numFeasible(numFeasible) {}
};

class SelectFeasible_FastKernel : public raft::kernel
{
private:
    Points* m_Points;
    int** m_Feasible;
    int m_kMin;
    unsigned int m_ITER;
    bool* m_IsCenter;
public:
    SelectFeasible_FastKernel(int** feasible, int kmin, unsigned int ITER, bool* is_center);
    virtual raft::kstatus run();
};

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

    PGainCallManager_Input() : points(nullptr), numRead(0), z(nullptr), kCenter(nullptr), cost(0.0), numFeasible(0), x(0), tid(0) {}
    PGainCallManager_Input(Points* points, size_t numRead, double* z, long* kCenter, double cost, int numFeasible, unsigned int x, unsigned int tid) : points(points), numRead(numRead), z(z), kCenter(kCenter), cost(cost), numFeasible(numFeasible), x(x), tid(tid) {}
};

class PGainCallManager : public raft::kernel
{
private:
    int** m_Feasible;
    unsigned int m_CL;
    unsigned int m_ThreadCount;
public:
    PGainCallManager(int** feasible, unsigned int CACHE_LINE, unsigned int threadCount);
    virtual raft::kstatus run();
};

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

    PGainWorker1_IO() : points(nullptr), numRead(0), z(nullptr), kCenter(nullptr), cost(0.0), numFeasible(0), tid(0), stride(0), cl(0), work_mem(nullptr), blockSize(0), x(0) {}
    PGainWorker1_IO(Points* points, size_t numRead, double* z, long* kCenter, double cost, int numFeasible, unsigned int stride, unsigned int cl, double* work_mem, unsigned int tid, size_t blockSize, unsigned int x) : points(points), numRead(numRead), z(z), kCenter(kCenter), cost(cost), numFeasible(numFeasible), stride(stride), cl(cl), work_mem(work_mem), tid(tid), blockSize(blockSize), x(x) {}
};

class PGainWorker1 : public raft::kernel
{
private:
    bool* m_IsCenter;
    int* m_CenterTable;
public:
    PGainWorker1(bool* is_center, int* center_table);
    virtual raft::kstatus run(); 
};

class PGainAccumulator1 : public raft::kernel_all
{
private:
    unsigned int m_ThreadCount;
public:
    PGainAccumulator1(unsigned int threadCount);
    virtual raft::kstatus run();
};

class PGainWorker2 : public raft::kernel
{
private:
    bool* m_IsCenter;
    int* m_CenterTable;
    bool* m_SwitchMembership;
public:
    PGainWorker2(bool* is_center, int* center_table, bool* switch_membership);
    virtual raft::kstatus run(); 
};

class PGainAccumulator2 : public raft::kernel_all
{
private:
    unsigned int m_ThreadCount;
public:
    PGainAccumulator2(unsigned int threadCount);
    virtual raft::kstatus run();
};

class PGainWorker3 : public raft::kernel
{
private:
    bool* m_IsCenter;
    int* m_CenterTable;
    bool* m_SwitchMembership;
    unsigned int m_ThreadCount;
public:
    PGainWorker3(bool* is_center, int* center_table, bool* switch_membership, unsigned int m_ThreadCount);
    virtual raft::kstatus run(); 
};

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

    PGainWorker3_Output() : points(nullptr), numRead(0), z(nullptr), kCenter(nullptr), cost(0.0), numFeasible(0), tid(0), stride(0), cl(0), work_mem(nullptr), blockSize(0), x(0), lower(nullptr), gl_lower(nullptr), cost_of_opening_x(0.0) {}
    PGainWorker3_Output(Points* points, size_t numRead, double* z, long* kCenter, double cost, int numFeasible, unsigned int stride, unsigned int cl, double* work_mem, unsigned int tid, size_t blockSize, unsigned int x, double* lower, double* gl_lower, double cost_of_opening_x) 
        :   points(points), numRead(numRead), z(z), kCenter(kCenter), cost(cost), numFeasible(numFeasible), 
            stride(stride), cl(cl), work_mem(work_mem), tid(tid), blockSize(blockSize), x(x), lower(lower), 
            gl_lower(gl_lower), cost_of_opening_x(cost_of_opening_x) {}
};

class PGainAccumulator3 : public raft::kernel_all
{
private:
    unsigned int m_ThreadCount;
public:
    PGainAccumulator3(unsigned int threadCount);
    virtual raft::kstatus run();
};

class PGainWorker4 : public raft::kernel
{
private:
    bool* m_IsCenter;
    int* m_CenterTable;
    unsigned int m_ThreadCount;
public:
    PGainWorker4(bool* is_center, int* center_table, unsigned int m_ThreadCount);
    virtual raft::kstatus run(); 
};

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

    PGainWorker4_Output() : points(nullptr), numRead(0), z(nullptr), kCenter(nullptr), cost(0.0), numFeasible(0), tid(0), stride(0), cl(0), work_mem(nullptr), blockSize(0), x(0), lower(nullptr), gl_lower(nullptr), cost_of_opening_x(0.0), number_of_centers_to_close(0) {}
    PGainWorker4_Output(Points* points, size_t numRead, double* z, long* kCenter, double cost, int numFeasible, unsigned int stride, unsigned int cl, double* work_mem, unsigned int tid, size_t blockSize, unsigned int x, double* lower, double* gl_lower, double cost_of_opening_x, unsigned int number_of_centers_to_close) 
        :   points(points), numRead(numRead), z(z), kCenter(kCenter), cost(cost), numFeasible(numFeasible), 
            stride(stride), cl(cl), work_mem(work_mem), tid(tid), blockSize(blockSize), x(x), lower(lower), 
            gl_lower(gl_lower), cost_of_opening_x(cost_of_opening_x), number_of_centers_to_close(number_of_centers_to_close) {}
};

class PGainAccumulator4 : public raft::kernel_all
{
private:
    unsigned int m_ThreadCount;
public:
    PGainAccumulator4(unsigned int threadCount);
    virtual raft::kstatus run();
};

class PGainWorker5 : public raft::kernel
{
private:
    bool* m_IsCenter;
    int* m_CenterTable;
    bool* m_SwitchMembership;
public:
    PGainWorker5(bool* is_center, int* center_table, bool* switch_membership);
    virtual raft::kstatus run(); 
};

class PGainAccumulator5 : public raft::kernel_all
{
private:
    unsigned int m_ThreadCount;
public:
    PGainAccumulator5(unsigned int threadCount);
    virtual raft::kstatus run();
};


#endif