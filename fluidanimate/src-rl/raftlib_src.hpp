/**
 * raftlib_src.hpp
 * @author: James Wood
 * @version: Thu July 29 18:05:00 2020
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

#ifndef RAFTLIBSRC_H
#define RAFTLIBSRC_H

#include "fluid.hpp"
#include <raft>

//Comment to disable use of mutex locks in RebuildGridMT execution
//#define USE_MUTEX

// To avoid issues with ISO C++
#define MAX_THREADS 128

/**
 *  Executes fluidanimate with the given parameters
 */
int fluidanimate(int argc, char *argv[]);

union Grid
{
  struct
  {
    int sx, sy, sz;
    int ex, ey, ez;
  }ind;

  unsigned char pp[CACHELINE_SIZE];
};

/**
 *  Data contained in other structs which identifies the kernel and its state
 */
struct SynchronizeKernelData
{
  int tid;
  bool done;

  SynchronizeKernelData() {}
  SynchronizeKernelData(int tid, bool done) : tid(tid), done(done) {}
};

/**
 *  Generic accumulator kernelw which takes in threadCount kernels and pushes to threadCount kernels
 */
class SimpleAccumulatorKernel : public raft::kernel_all
{
private:
  int m_ThreadCount;
public:
  SimpleAccumulatorKernel(int threadCount);
  virtual raft::kstatus run();
};

/**
 *  Generic producer kernel which pushes to threadCount kernels
 */
class SimpleProducerKernel : public raft::kernel
{
private:
  int m_ThreadCount;
public:
  SimpleProducerKernel(int threadCount);
  virtual raft::kstatus run();
};

/**
 *  Generic consumer kernel which consumes threadCount kernels.
 */
class SimpleConsumerKernel : public raft::kernel_all
{
private:
  int m_ThreadCount;
public:
  SimpleConsumerKernel(int threadCount);
  virtual raft::kstatus run();
};

/**
 *  Special case accumulator kernel where it will not proceed until an additional kernel is complete.
 */
class AdvancedAccumulatorKernel : public raft::kernel_all
{
private:
  int m_ThreadCount;
public:
  AdvancedAccumulatorKernel(int threadCount);
  virtual raft::kstatus run();
};

/**
 *  Kernel wrapper for the ClearParticlesMT function.
 */
class ClearParticlesMTWorker : public raft::kernel
{
public:
    ClearParticlesMTWorker();
    virtual raft::kstatus run();
};

#ifdef USE_MUTEX

/**
 *  Wrapper kernel for the RebuildGridMT function.
 */
class RebuildGridMTWorker : public raft::kernel
{
public:
  RebuildGridMTWorker();
  virtual raft::kstatus run();
};

#else

struct RebuildGridMTWorker0_Output
{
  int tid;
  int index2;
  Cell* cell2;
  int np2;
  bool done;

  RebuildGridMTWorker0_Output() {}
  RebuildGridMTWorker0_Output(int tid, int index2, Cell* cell2, int np2, bool done) : tid(tid), index2(index2), cell2(cell2), np2(np2), done(done) {}
};

class RebuildGridMTWorker0 : public raft::kernel
{
private:
  int tid;
  int iz;
  int iy;
  int ix;
public:
  RebuildGridMTWorker0();
  virtual raft::kstatus run();
};

/**
 *  Wrapper kernel for the RebuildGridMT function.
 */
class RebuildGridMTWorker1 : public raft::kernel
{
public:
  RebuildGridMTWorker1();
  virtual raft::kstatus run();
};

class RebuildGridMTWorker2 : public raft::kernel
{
public:
  RebuildGridMTWorker2();
  virtual raft::kstatus run();
};

/**
 *  Data for the CellModificationKernel to perform an operation.
 */
struct CellModificationInfo
{
  Cell* cell2;
  int index;
  int index2;
  int np2;
  int j;
  SynchronizeKernelData kernelData;

  CellModificationInfo() {}
  CellModificationInfo(Cell* cell2, int index, int index2, int np2, int j, SynchronizeKernelData kernelData) : cell2(cell2), index(index), index2(index2), np2(np2), j(j), kernelData(kernelData) {}
};

/**
 *  CellModificationKernel is a "thread-safe" kernel for managing writes to cells in RebuildGridMT.
 */
class CellModificationKernel : public raft::kernel
{
private:
  int m_ThreadCount;
  bool* m_Done;
public:
  CellModificationKernel(int threadCount);
  ~CellModificationKernel();
  virtual raft::kstatus run();
};

#endif

/**
 *  Wrapper kernel for the InitDensitiesAndForcesMT function.
 */
class InitDensitiesAndForcesMTWorker : public raft::kernel
{
public:
    InitDensitiesAndForcesMTWorker();
    virtual raft::kstatus run();
};

/**
 *  Data for the DensityModificationKernel to perform an operation.
 */
struct DensityModificationInfo
{
  Cell* cell;
  int index;
  fptype tc;
  SynchronizeKernelData kernelData;

  DensityModificationInfo() {}
  DensityModificationInfo(Cell* cell, int index, fptype tc, SynchronizeKernelData kernelData) : cell(cell), index(index), tc(tc), kernelData(kernelData) {}
};

/**
 *  Wrapper kernel for the ComputeDensitiesMT function.
 */
class ComputeDensitiesMTWorker : public raft::kernel
{
public:
  ComputeDensitiesMTWorker();
  virtual raft::kstatus run();
};

/**
 *  DensityModificationKernel is a "thread-safe" kernel for managing writes to cell densities.
 */
class DensityModificationKernel : public raft::kernel
{
private:
  int m_ThreadCount;
  bool* m_Done;
public:
  DensityModificationKernel(int threadCount);
  ~DensityModificationKernel();
  virtual raft::kstatus run();
};

/**
 *  Wrapper kernel for the ComputeDensities2MT function.
 */
class ComputeDensities2MTWorker : public raft::kernel
{
public:
    ComputeDensities2MTWorker();
    virtual raft::kstatus run();
};

/**
 *  Data for the AccelerationModificationKernel to perform an operation.
 */
struct AccelerationModificationInfo
{
  Cell* cell;
  int index;
  Vec3 acc;
  SynchronizeKernelData kernelData;

  AccelerationModificationInfo() {}
  AccelerationModificationInfo(Cell* cell, int index, Vec3 acc, SynchronizeKernelData kernelData) : cell(cell), index(index), acc(acc), kernelData(kernelData) {}
};

/**
 *  Wrapper kernel for the ComputeForcesMT function.
 */
class ComputeForcesMTWorker : public raft::kernel
{
public:
  ComputeForcesMTWorker();
  virtual raft::kstatus run();
};

/**
 *  AccelerationModificationKernel is a "thread-safe" kernel for managing writes to cell accelerations.
 */
class AccelerationModificationKernel : public raft::kernel
{
private:
  int m_ThreadCount;
  bool* m_Done;
public:
  AccelerationModificationKernel(int threadCount);
  ~AccelerationModificationKernel();
  virtual raft::kstatus run();
};

/**
 *  Wrapper kernel for the ProcessCollisionsMT function.
 */
class ProcessCollisionsMTWorker : public raft::kernel
{
public:
    ProcessCollisionsMTWorker();
    virtual raft::kstatus run();
};

/**
 *  Wrapper kernel for the ProcessCollisions2MT function.
 */
class ProcessCollisions2MTWorker : public raft::kernel
{
public:
    ProcessCollisions2MTWorker();
    virtual raft::kstatus run();
};

/**
 *  Wrapper kernel for the AdvanceParticlesMT function.
 */
class AdvanceParticlesMTWorker : public raft::kernel
{
public:
    AdvanceParticlesMTWorker();
    virtual raft::kstatus run();
};

#endif