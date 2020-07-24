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

struct SynchronizeKernelData
{
  int tid;
  bool done;

  SynchronizeKernelData() {}
  SynchronizeKernelData(int tid, bool done) : tid(tid), done(done) {}
};

class SimpleAccumulatorKernel : public raft::kernel_all
{
private:
  int m_ThreadCount;
public:
  SimpleAccumulatorKernel(int threadCount);
  virtual raft::kstatus run();
};

class AdvancedAccumulatorKernel : public raft::kernel_all
{
private:
  int m_ThreadCount;
public:
  AdvancedAccumulatorKernel(int threadCount);
  virtual raft::kstatus run();
};

class ClearParticlesMTWorker : public raft::kernel
{
public:
    ClearParticlesMTWorker();
    virtual raft::kstatus run();
};

struct CellModificationInfo
{
  Cell* cell2;
  int index;
  int j;
  SynchronizeKernelData kernelData;

  CellModificationInfo() {}
  CellModificationInfo(Cell* cell2, int index, int j, SynchronizeKernelData kernelData) : cell2(cell2), index(index), j(j), kernelData(kernelData) {}
};

class RebuildGridMTWorker : public raft::kernel
{
public:
  RebuildGridMTWorker();
  virtual raft::kstatus run();
};

class CellModificationKernel : public raft::kernel
{
private:
  int m_ThreadCount;
  bool* m_Done;
public:
  CellModificationKernel(int threadCount);
  virtual raft::kstatus run();
};

class InitDensitiesAndForcesMTWorker : public raft::kernel
{
public:
    InitDensitiesAndForcesMTWorker();
    virtual raft::kstatus run();
};

struct DensityModificationInfo
{
  Cell* cell;
  int index;
  fptype tc;
  SynchronizeKernelData kernelData;

  DensityModificationInfo() {}
  DensityModificationInfo(Cell* cell, int index, fptype tc, SynchronizeKernelData kernelData) : cell(cell), index(index), tc(tc), kernelData(kernelData) {}
};

class ComputeDensitiesMTWorker : public raft::kernel
{
public:
  ComputeDensitiesMTWorker();
  virtual raft::kstatus run();
};

class DensityModificationKernel : public raft::kernel
{
private:
  int m_ThreadCount;
  bool* m_Done;
public:
  DensityModificationKernel(int threadCount);
  virtual raft::kstatus run();
};

class ComputeDensities2MTWorker : public raft::kernel
{
public:
    ComputeDensities2MTWorker();
    virtual raft::kstatus run();
};

struct AccelerationModificationInfo
{
  Cell* cell;
  int index;
  Vec3 acc;
  SynchronizeKernelData kernelData;

  AccelerationModificationInfo() {}
  AccelerationModificationInfo(Cell* cell, int index, Vec3 acc, SynchronizeKernelData kernelData) : cell(cell), index(index), acc(acc), kernelData(kernelData) {}
};

class ComputeForcesMTWorker : public raft::kernel
{
public:
  ComputeForcesMTWorker();
  virtual raft::kstatus run();
};

class AccelerationModificationKernel : public raft::kernel
{
private:
  int m_ThreadCount;
  bool* m_Done;
public:
  AccelerationModificationKernel(int threadCount);
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

class AdvanceParticlesMTWorker : public raft::kernel
{
public:
    AdvanceParticlesMTWorker();
    virtual raft::kstatus run();
};

#endif