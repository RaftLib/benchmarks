/*
 * Copyright (C) 2008 Princeton University
 * All rights reserved.
 * Authors: Jia Deng, Gilberto Contreras
 *
 * streamcluster - Online clustering algorithm
 *
 */

/**
 * streamcluster.hpp -
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

#ifndef STREAMCLUSTER_H
#define STREAMCLUSTER_H

#include <stdio.h>
#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <cstring>
#include <vector>
#include <assert.h>
#include <math.h>
#include <sys/resource.h>
#include <climits>

#define MAX_PARALLEL_KERNELS 128

/* this structure represents a point */
/* these will be passed around to avoid copying coordinates */
struct Point 
{
  float     weight  = 1.0;
  float     *coord  = nullptr;
  long      assign  = 0;  /* number of point where this one is assigned */
  float     cost    = 0.0;  /* cost of that assignment, weight*distance */
};

/* this is the array of points */
struct Points 
{
    Points( long n, long d, std::size_t count ) : num( n ), dim( d )
    {
        p.reserve( count );
    }

    long  num; /* number of points; may not be N if this is a sample */
    int   dim;  /* dimensionality */
    std::vector< Point > p; /* the array itself */
};

/* compute Euclidean distance squared between two points */
inline float dist( const Point &p1, const Point &p2, const int dim )
{
  float result=0.0;
  for ( auto i( 0 ); i<dim; i++ )
  {
    result += ( p1.coord[i] - p2.coord[i] ) * ( p1.coord[i] - p2.coord[i] );
  }
  return(result);
}

void shuffle(Points*);
void intshuffle(int *intarray, int length);

struct pkmedian_arg_t
{
  Points* points;
  long kmin;
  long kmax;
  long* kfinal;
  int pid;
  pthread_barrier_t* barrier;
};

class PStream {
public:
  PStream() = default;
  virtual ~PStream() = default;
  
  virtual size_t read( float* dest, int dim, int num ) = 0;
  virtual int ferror() = 0;
  virtual int feof() = 0;
};

//synthetic stream
class SimStream : public PStream 
{
public:
  SimStream(long n_ ) : PStream(), n( n_ ) {};

  size_t read( float* dest, int dim, int num ) 
  {
    size_t count = 0;
    for( int i = 0; i < num && n > 0; i++ ) 
    {
      for( int k = 0; k < dim; k++ ) 
      {
	    dest[i*dim + k] = lrand48()/(float)INT_MAX;
      }
      n--;
      count++;
    }
    return count;
  }

  virtual int ferror() { return 0; }
  
  virtual int feof() { return n <= 0; }

private:
  long n;
};

class FileStream : public PStream 
{
public:
  FileStream( char* filename ) 
  {
    fp = fopen( filename, "rb");
    if( fp == NULL ) {
      fprintf(stderr,"error opening file %s\n.",filename);
      exit(1);
    }
  }
  size_t read( float* dest, int dim, int num ) {
    return std::fread(dest, sizeof(float)*dim, num, fp); 
  }
  int ferror() {
    return std::ferror(fp);
  }
  int feof() {
    return std::feof(fp);
  }
  ~FileStream() {
    fprintf(stderr,"closing file stream\n");
    fclose(fp);
  }
private:
  FILE* fp;
};

/**
 *  Performs the streamCluster operation and outputs the result to the given file.
 */
void streamCluster(PStream*, long, long, int, long, long, char*, int);



#endif