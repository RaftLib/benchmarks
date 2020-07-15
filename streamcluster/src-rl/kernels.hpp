#ifndef KERNELS_HPP
#define KERNELS_HPP

#include "streamcluster.hpp"
#include <raft>

struct PSpeedyCallManager_Input
{
    Points* points;
    size_t numRead;
    float* z;
    long* kCenter;

    PSpeedyCallManager_Input() : points(nullptr), numRead(0), z(nullptr), kCenter(nullptr) {}
    PSpeedyCallManager_Input(Points* points, size_t numRead, float* z, long* kCenter) : points(points), numRead(numRead), z(z), kCenter(kCenter) {}
};

struct PSpeedyCallManager_Output
{
    Points* points;
    size_t numRead;
    float* z;
    long* kCenter;
    double cost;

    PSpeedyCallManager_Output() : points(nullptr), numRead(0), z(nullptr), kCenter(nullptr), cost(0.0) {}
    PSpeedyCallManager_Output(Points* points, size_t numRead, float* z, long* kCenter, double cost) : points(points), numRead(numRead), z(z), kCenter(kCenter), cost(cost) {}
};

struct PSpeedyWorker_Input
{
    Points* points;
    size_t numRead;
    unsigned int tid;
    unsigned int blockSize;
    unsigned int iterationIndex;
    bool checkCost;
    bool work;

    PSpeedyWorker_Input() : points(nullptr), tid(0), work(false), blockSize(0), numRead(0), checkCost(false), iterationIndex(0) {}
    PSpeedyWorker_Input(Points* points, unsigned int tid, unsigned int blockSize, unsigned int iterationIndex, size_t numRead, bool checkCost, bool work) : points(points), tid(tid), work(work), blockSize(blockSize), numRead(numRead), checkCost(checkCost), iterationIndex(iterationIndex) {}
};

class PSpeedyCallManager : public raft::kernel
{
private:
    Points* m_Points;
    size_t m_NumRead;
    float* m_Z;
    long* m_kCenter;
    unsigned int m_ThreadCount;
    unsigned int m_IterationIndex;
public:
    PSpeedyCallManager(unsigned int threadCount);
    virtual raft::kstatus run();
};

class PSpeedyWorker : public raft::kernel
{
public:
    PSpeedyWorker();
    virtual raft::kstatus run();
};

#endif