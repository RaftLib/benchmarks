#ifndef RAFTLIB_H
#define RAFTLIB_H

#include "fluid.hpp"
#include <raft>

// Info
// Main function is AdvanceFrameMT, which calls all of the other functions
// Goal is to make a kernel out of all of these functions
/**
 * Kernels
 * 
 * ClearParticlesMT
 * RebuildGridMT * uses mutex lock
 * InitDensitiesAndForcesMT
 * ComputeDensitiesMT * uses mutex lock
 * ComputeForcesMT * uses mutex lock
 * ProcessCollisionsMT
 * AdvanceParticlesMT
 * 
 */

struct Grid
{
  union {
    struct {
      int sx, sy, sz;
      int ex, ey, ez;
    };
    unsigned char pp[CACHELINE_SIZE];
  };
};

class ClearParticlesMTWorker : public raft::kernel
{
public:
    ClearParticlesMTWorker();
    virtual raft::kstatus run();
};

class InitDensitiesAndForcesMTWorker : public raft::kernel
{
public:
    InitDensitiesAndForcesMTWorker();
    virtual raft::kstatus run();
};

class ComputeDensities2MTWorker : public raft::kernel
{
public:
    ComputeDensities2MTWorker();
    virtual raft::kstatus run();
};

class ProcessCollisionsMTWorker : public raft::kernel
{
public:
    ProcessCollisionsMTWorker();
    virtual raft::kstatus run();
};

class ProcessCollisions2MTWorker : public raft::kernel
{
public:
    ProcessCollisions2MTWorker();
    virtual raft::kstatus run();
};

#endif