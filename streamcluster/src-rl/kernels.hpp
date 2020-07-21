#ifndef KERNELS_HPP
#define KERNELS_HPP

#include "streamcluster.hpp"
#include <raft>

class StreamClusterStarterKernel : public raft::kernel
{
public:
    StreamClusterStarterKernel();
    virtual raft::kstatus run();
};

struct PStreamReader_Output
{
    size_t numRead;
    bool useCenters;

    PStreamReader_Output() : numRead(0), useCenters(false) {}
    PStreamReader_Output(size_t numRead, bool useCenters) : numRead(numRead), useCenters(useCenters) {}
};

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

struct LocalSearchStarter_Output
{
    Points* points;
    size_t numRead;
    size_t blockSize;
    unsigned int tid;

    LocalSearchStarter_Output() : points(nullptr), numRead(0), blockSize(0), tid(0) {}
    LocalSearchStarter_Output(Points* points, size_t numRead, size_t blockSize, unsigned int tid) : points(points), numRead(numRead), blockSize(blockSize), tid(tid) {}
};

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

struct PKMedianWorker1_Output
{
    Points* points;
    size_t numRead;
    double hiz;

    PKMedianWorker1_Output() : points(nullptr), numRead(0), hiz(0.0) {}
    PKMedianWorker1_Output(Points* points, size_t numRead, double hiz) : points(points), numRead(numRead), hiz(hiz) {}
};

class PKMedianWorker1 : public raft::kernel
{
public:
    PKMedianWorker1();
    virtual raft::kstatus run();
};

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
    double* hiz;
    double* loz;
    long* kCenter;
    double cost;

    PSpeedyCallManager_Output() : points(nullptr), numRead(0), z(nullptr), kCenter(nullptr), cost(0.0), hiz(nullptr), loz(nullptr) {}
    PSpeedyCallManager_Output(Points* points, size_t numRead, double* z, long* kCenter, double cost, double* hiz, double* loz) : points(points), numRead(numRead), z(z), kCenter(kCenter), cost(cost), hiz(hiz), loz(loz) {}
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
    int* feasible;

    SelectFeasible_FastKernel_Output() : points(nullptr), numRead(0), z(nullptr), kCenter(nullptr), cost(0.0), hiz(nullptr), loz(nullptr), numFeasible(0), feasible(nullptr) {}
    SelectFeasible_FastKernel_Output(Points* points, size_t numRead, double* z, long* kCenter, double cost, double* hiz, double* loz, int numFeasible, int* feasible) : points(points), numRead(numRead), z(z), kCenter(kCenter), cost(cost), hiz(hiz), loz(loz), numFeasible(numFeasible), feasible(feasible) {}
};

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
    unsigned int m_CL;
    unsigned int m_ThreadCount;
public:
    PGainCallManager(unsigned int CACHE_LINE, unsigned int threadCount);
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
    bool** m_IsCenter;
    int** m_CenterTable;
public:
    PGainWorker1(bool** is_center, int** center_table);
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
    bool** m_IsCenter;
    int** m_CenterTable;
    bool** m_SwitchMembership;
public:
    PGainWorker2(bool** is_center, int** center_table, bool** switch_membership);
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
    bool** m_IsCenter;
    int** m_CenterTable;
    bool** m_SwitchMembership;
    unsigned int m_ThreadCount;
public:
    PGainWorker3(bool** is_center, int** center_table, bool** switch_membership, unsigned int m_ThreadCount);
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
    bool** m_IsCenter;
    int** m_CenterTable;
    unsigned int m_ThreadCount;
public:
    PGainWorker4(bool** is_center, int** center_table, unsigned int m_ThreadCount);
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
    bool** m_IsCenter;
    int** m_CenterTable;
    bool** m_SwitchMembership;
public:
    PGainWorker5(bool** is_center, int** center_table, bool** switch_membership);
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

    PFLCallManager_Input() : points(nullptr), numRead(0), z(nullptr), kCenter(nullptr), cost(0.0), numFeasible(0), iter(0), e(0.0), feasible(nullptr) {}
    PFLCallManager_Input(Points* points, size_t numRead, double* z, long* kCenter, double cost, int numFeasible, int* feasible, long iter, double e) : points(points), numRead(numRead), z(z), kCenter(kCenter), cost(cost), numFeasible(numFeasible), iter(iter), e(e), feasible(feasible) {}
};

class PFLCallManager : public raft::kernel
{
private:
    Points* m_Points;
    size_t m_NumRead;
    double* m_Z;
    long* m_kCenter;
    long m_Iter;
    int* m_Feasible;
    int m_NumFeasible;
    double m_Change;
    double m_Cost;
    float m_E;

    unsigned int m_IterationIndex;
public:
    PFLCallManager();
    virtual raft::kstatus run();
};

class PKMedianAccumulator2 : public raft::kernel
{
private:
    long m_kMin;
    long m_kMax;
    long* m_kFinal;
    Points* m_Points;
    size_t m_NumRead;
    double* m_Z;
    double* m_Hiz;
    double* m_Loz;
    long* m_kCenter;
    double m_Cost;
    unsigned int m_ITER;
    int m_NumFeasible;
    int* m_Feasible;

    bool** m_IsCenter;
    bool** m_SwitchMembership;
    int** m_CenterTable;

    unsigned int m_CallIndex;
public:
    PKMedianAccumulator2(long kmin, long kmax, long* kfinal, unsigned int ITER, bool** isCenter, int** centerTable, bool** switchMembership);
    virtual raft::kstatus run();
};

struct ContCentersKernel_Input
{
    size_t numRead;
    Points* points;

    ContCentersKernel_Input() : numRead(0), points(nullptr) {}
    ContCentersKernel_Input(size_t numRead, Points* points) : numRead(numRead), points(points) {}
};

class ContCentersKernel : public raft::kernel
{
    Points* m_Points;
    Points* m_Centers;
public:
    ContCentersKernel(Points* points, Points* centers);
    virtual raft::kstatus run();
};

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

#endif