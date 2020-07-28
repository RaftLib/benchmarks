/*
 * Copyright (C) 2008 Princeton University
 * All rights reserved.
 * Authors: Jia Deng, Gilberto Contreras
 *
 * streamcluster - Online clustering algorithm
 *
 */

/**
 * streamcluster.cpp -
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

#include <stdio.h>
#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <cstring>
#include <assert.h>
#include <math.h>
#include <sys/resource.h>
#include <climits>
#include <vector>
#include <limits>

#include "streamcluster.hpp"
#include "kernels.hpp"
#define USE_RAFT

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Global variables from original streamCluster program

constexpr static std::uint16_t MAXNAMESIZE = 1024;
constexpr static std::uint8_t  SEED = 1;
/* increase this to reduce probability of random error */
/* increasing it also ups running time of "speedy" part of the code */
/* SP = 1 seems to be fine */
constexpr static std::uint8_t  SP   = 1;

/* higher ITER --> more likely to get correct # of centers */
/* higher ITER also scales the running time almost linearly */
constexpr static std::uint8_t ITER  = 3;

constexpr static std::uint8_t CACHE_LINE = 64;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Helper functions

/**
 * Shuffle points into random order.
 */
void shuffle(Points *points)
{
  for (long i=0; i < points->num - 1; i++) 
  {
    long j = (lrand48() % (points->num - i)) + i;
    Point temp = points->p[i];
    points->p[i] = points->p[j];
    points->p[j] = temp;
  }
}

/**
 *  Shuffle an array of integers.
 */
void intshuffle(int *intarray, int length)
{
  for (long i=0; i < length; i++) 
  {
    long j = (lrand48() % (length - i)) + i;
    int temp = intarray[i];
    intarray[i] = intarray[j];
    intarray[j] = temp;
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void streamCluster( PStream* stream, long kmin, long kmax, int dim, long chunksize, long centersize, char* outfile, int nproc)
{
  // Create our "global" arrays
  float* block = new float[chunksize * dim];
  float* centerBlock = new float[centersize * dim];
  long* centerIDs = new long[centersize * dim];

  bool** switchMembership = new bool*[1];
  bool** isCenter = new bool*[1];
  int** centerTable = new int*[1];

  if( block == NULL ) { 
    std::cerr << "Not enough memory for a chunk!" << std::endl;
    exit(EXIT_FAILURE);
  }

  // Create the points and centers arrays

  Points points(chunksize /** n **/, dim /** dim **/, chunksize /** reserve **/);

  for( int i = 0; i < chunksize; i++ ) 
    points.p[i].coord = &block[i*dim];

  Points centers(0 /** n **/, dim /** dim **/, centersize /** reserve **/);

  for( int i = 0; i< centersize; i++ ) 
    centers.p[i].coord  = &centerBlock[i*dim];

  long IDoffset = 0;
  long kfinal = 0;

  bool shouldContinue = true; // once shouldContinue is false (stream is finished), continue for one extra iteration
  bool finalIterationDone = false;
  while (!finalIterationDone)
  {
    finalIterationDone = !shouldContinue;    

    // Kernel Initialization
    PStreamReader streamReader(stream, block, dim, chunksize, &shouldContinue, &IDoffset);
    LocalSearchStarter localSearchStarter(&points, &centers, nproc, isCenter, centerTable, switchMembership);
    std::vector<PKMedianWorker*> pkMedianWorkers;
    PKMedianAccumulator1 pkMedianAccumulator1(kmin, kmax, &kfinal, nproc);
    PSpeedyCallManager pSpeedyCallManager(nproc, kmin, SP);
    SelectFeasible_FastKernel selectFeasible(kmin, ITER, isCenter);
    PKMedianAccumulator2 pkMedianAccumulator2(CACHE_LINE, kmin, kmax, &kfinal, ITER, isCenter, centerTable, switchMembership, nproc);
    ContCentersKernel contCenters(&points, &centers, &kfinal, centersize);
    CopyCentersKernel copyCenters(&points, &centers, centerIDs, &IDoffset);
    OutCenterIDsKernel outCenters(&centers, centerIDs, outfile);
    raft::map m;

    for (auto i = 0; i < nproc; i++)
      pkMedianWorkers.push_back(new PKMedianWorker);

    // Map Construction
    m += streamReader >> localSearchStarter;
    m += pkMedianAccumulator1["output_pspeedy"] >> pSpeedyCallManager;
    m += pSpeedyCallManager >> selectFeasible;
    m += selectFeasible >> pkMedianAccumulator2;
    m += pkMedianAccumulator2 >> contCenters["input_pkmedian2"];
    m += pkMedianAccumulator1["output_end"] >> contCenters["input_pkmedian1"];
    m += contCenters["output_copy"] >> copyCenters;
    m += contCenters["output_out"] >> outCenters;
  
    // Worker connections
    for (auto i = 0; i < nproc; i++)
    {
      const char* to_str = std::to_string(i).c_str();
      m += localSearchStarter[to_str] >> *(pkMedianWorkers[i]);
      m += *(pkMedianWorkers[i]) >> pkMedianAccumulator1[to_str];
    }

    // Execute the map
    m.exe();

    // Cleanup
    for (auto i = 0; i < nproc; i++)
      delete pkMedianWorkers[i];
  }

  // Cleanup
  delete[] block;
  delete[] centerBlock;
  delete[] centerIDs;

  delete[] switchMembership;
  delete[] isCenter;
  delete[] centerTable;
}
