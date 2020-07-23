/*
 * Copyright (C) 2008 Princeton University
 * All rights reserved.
 * Authors: Jia Deng, Gilberto Contreras
 *
 * streamcluster - Online clustering algorithm
 *
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
#include <raft>
#include <raftio>
#include <limits>

#include "streamcluster.hpp"
#include "kernels.hpp"
#define USE_RAFT

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

static int nproc; //# of threads

/* shuffle points into random order */
void shuffle(Points *points)
{
  long i, j;
  Point temp;
  for (i=0;i<points->num-1;i++) {
    j=(lrand48()%(points->num - i)) + i;
    temp = points->p[i];
    points->p[i] = points->p[j];
    points->p[j] = temp;
  }
}

/* shuffle an array of integers */
void intshuffle(int *intarray, int length)
{
  long i, j;
  int temp;
  for (i=0;i<length;i++) {
    j=(lrand48()%(length - i))+i;
    temp = intarray[i];
    intarray[i]=intarray[j];
    intarray[j]=temp;
  }
}

void streamCluster( PStream* stream, long kmin, long kmax, int dim, long chunksize, long centersize, char* outfile)
{
  float* block = (float*)malloc( chunksize*dim*sizeof(float) );
  float* centerBlock = (float*)malloc(centersize*dim*sizeof(float) );
  long* centerIDs = (long*)malloc(centersize*dim*sizeof(long));

  if( block == NULL ) { 
    fprintf(stderr,"not enough memory for a chunk!\n");
    exit(1);
  }

  std::cout << "Chunksize: " << chunksize << std::endl;
  std::cout << "Centersize: " << centersize << std::endl;

  Points points( chunksize /** n **/, dim /** dim **/, chunksize /** reserve **/ );

  for( int i = 0; i < chunksize; i++ ) 
  {
    points.p[i].coord = &block[i*dim];
  }

  Points centers( 0 /** n **/, dim /** dim **/, centersize /** reserve **/ );

  for( int i = 0; i< centersize; i++ ) 
  {
    centers.p[i].coord  = &centerBlock[i*dim];
  }

  bool** switchMembership = new bool*[1];
  bool** isCenter = new bool*[1];
  int** centerTable = new int*[1];

  long IDoffset = 0;
  long kfinal = 0;

  bool shouldContinue = true;
  bool finalIterationDone = false;
  while (!finalIterationDone)
  {
    finalIterationDone = !shouldContinue;    

    // Kernel Initialization
    PStreamReader streamReader(stream, block, dim, chunksize, &shouldContinue, &IDoffset);
    LocalSearchStarter localSearchStarter(&points, &centers, nproc, isCenter, centerTable, switchMembership);
    std::vector<PKMedianWorker1*> pkMedianWorkers;
    PKMedianAccumulator1 pkMedianAccumulator1(kmin, kmax, &kfinal, nproc);
    PSpeedyCallManager pSpeedyCallManager(nproc, kmin, SP);
    SelectFeasible_FastKernel selectFeasible(kmin, ITER, isCenter);
    PKMedianAccumulator2 pkMedianAccumulator2(CACHE_LINE, kmin, kmax, &kfinal, ITER, isCenter, centerTable, switchMembership, nproc);
    ContCentersKernel contCenters(&points, &centers, &kfinal, centersize);
    CopyCentersKernel copyCenters(&points, &centers, centerIDs, &IDoffset);
    OutCenterIDsKernel outCenters(&centers, centerIDs, outfile);
    raft::map m;

    for (auto i = 0; i < nproc; i++)
      pkMedianWorkers.push_back(new PKMedianWorker1);

    // Map Construction
    m += streamReader >> localSearchStarter;
    m += pkMedianAccumulator1["output_pspeedy"] >> pSpeedyCallManager;
    m += pSpeedyCallManager >> selectFeasible;
    m += selectFeasible >> pkMedianAccumulator2;
    m += pkMedianAccumulator2 >> contCenters["input_pkmedian2"];
    m += pkMedianAccumulator1["output_end"] >> contCenters["input_pkmedian1"];
    m += contCenters["output_copy"] >> copyCenters;
    m += contCenters["output_out"] >> outCenters;
  

    for (auto i = 0; i < nproc; i++)
    {
      const char* to_str = std::to_string(i).c_str();
      m += localSearchStarter[to_str] >> *(pkMedianWorkers[i]);
      m += *(pkMedianWorkers[i]) >> pkMedianAccumulator1[to_str];
    }

    m.exe();

    for (auto i = 0; i < nproc; i++)
      delete pkMedianWorkers[i];
  }
}

int main(int argc, char **argv)
{
  char *outfilename = new char[MAXNAMESIZE];
  char *infilename = new char[MAXNAMESIZE];
  long kmin, kmax, n, chunksize, clustersize;
  int dim;

  if (argc<10) {
    fprintf(stderr,"usage: %s k1 k2 d n chunksize clustersize infile outfile nproc\n",
	    argv[0]);
    fprintf(stderr,"  k1:          Min. number of centers allowed\n");
    fprintf(stderr,"  k2:          Max. number of centers allowed\n");
    fprintf(stderr,"  d:           Dimension of each data point\n");
    fprintf(stderr,"  n:           Number of data points\n");
    fprintf(stderr,"  chunksize:   Number of data points to handle per step\n");
    fprintf(stderr,"  clustersize: Maximum number of intermediate centers\n");
    fprintf(stderr,"  infile:      Input file (if n<=0)\n");
    fprintf(stderr,"  outfile:     Output file\n");
    fprintf(stderr,"  nproc:       Number of parallel kernels to use\n");
    fprintf(stderr,"\n");
    fprintf(stderr, "if n > 0, points will be randomly generated instead of reading from infile.\n");
    exit(1);
  }

  kmin = atoi(argv[1]);
  kmax = atoi(argv[2]);
  dim = atoi(argv[3]);
  n = atoi(argv[4]);
  chunksize = atoi(argv[5]);
  clustersize = atoi(argv[6]);
  strcpy(infilename, argv[7]);
  strcpy(outfilename, argv[8]);
  nproc = atoi(argv[9]);

  if (nproc > MAX_PARALLEL_KERNELS)
  {
    std::cerr << "Number of requested kernels exceeds max set in code. Change max in kernels.hpp to continue!" << std::endl;
    exit(EXIT_FAILURE);
  }


  srand48(SEED);
  PStream* stream;
  if( n > 0 ) {
    stream = new SimStream(n);
  }
  else {
    stream = new FileStream(infilename);
  }

  streamCluster(stream, kmin, kmax, dim, chunksize, clustersize, outfilename );

  delete stream;
  
  return 0;
}
