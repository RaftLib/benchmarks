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


#ifdef ENABLE_THREADS
#include <pthread.h>
#include "parsec_barrier.hpp"
#endif

#ifdef ENABLE_PARSEC_HOOKS
#include <hooks.h>
#endif

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


static bool *switch_membership; //whether to switch membership in pgain
static bool* is_center; //whether a point is a center
static int* center_table; //index table of centers

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


// used in pkmedian
float pspeedy(Points *points, float z, long *kcenter, int pid, pthread_barrier_t* barrier)
{
#ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
#endif
  //my block
  long bsize = points->num/nproc;
  long k1 = bsize * pid;
  long k2 = k1 + bsize;
  if( pid == nproc-1 ) k2 = points->num;

  static double totalcost;

  static bool open = false;
  static double* costs; //cost for each thread. 
  static int i;

#ifdef ENABLE_THREADS
  static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
  static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
#endif

  /* create center at first point, send it to itself */
  for( int k = k1; k < k2; k++ )    {
    float distance = dist(points->p[k],points->p[0],points->dim);
    points->p[k].cost = distance * points->p[k].weight;
    points->p[k].assign=0;
  }

  if( pid==0 )   {
    *kcenter = 1;
    costs = (double*)malloc(sizeof(double)*nproc);
  }

#ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
#endif
    
  if( pid != 0 ) { // we are not the master threads. we wait until a center is opened.
    while(1) {
#ifdef ENABLE_THREADS
      pthread_mutex_lock(&mutex);
      while(!open) pthread_cond_wait(&cond,&mutex);
      pthread_mutex_unlock(&mutex);
#endif
      if( i >= points->num ) break;
      for( int k = k1; k < k2; k++ )
	{
	  float distance = dist(points->p[i],points->p[k],points->dim);
	  if( distance*points->p[k].weight < points->p[k].cost )
	    {
	      points->p[k].cost = distance * points->p[k].weight;
	      points->p[k].assign=i;
	    }
	}
#ifdef ENABLE_THREADS
      pthread_barrier_wait(barrier);
      pthread_barrier_wait(barrier);
#endif
    } 
  }
  else  { // I am the master thread. I decide whether to open a center and notify others if so. 
    for(i = 1; i < points->num; i++ )  {
      bool to_open = ((float)lrand48()/(float)INT_MAX)<(points->p[i].cost/z);
      if( to_open )  {
	(*kcenter)++;
#ifdef ENABLE_THREADS
	pthread_mutex_lock(&mutex);
#endif
	open = true;
#ifdef ENABLE_THREADS
	pthread_mutex_unlock(&mutex);
	pthread_cond_broadcast(&cond);
#endif
	for( int k = k1; k < k2; k++ )  {
	  float distance = dist(points->p[i],points->p[k],points->dim);
	  if( distance*points->p[k].weight < points->p[k].cost )  {
	    points->p[k].cost = distance * points->p[k].weight;
	    points->p[k].assign=i;
	  }
	}
#ifdef ENABLE_THREADS
	pthread_barrier_wait(barrier);
#endif
	open = false;
#ifdef ENABLE_THREADS
	pthread_barrier_wait(barrier);
#endif
      }
    }
#ifdef ENABLE_THREADS
    pthread_mutex_lock(&mutex);
#endif
    open = true;
#ifdef ENABLE_THREADS
    pthread_mutex_unlock(&mutex);
    pthread_cond_broadcast(&cond);
#endif
  }
#ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
#endif
  open = false;
  double mytotal = 0;
  for( int k = k1; k < k2; k++ )  {
    mytotal += points->p[k].cost;
  }
  costs[pid] = mytotal;
#ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
#endif
  // aggregate costs from each thread
  if( pid == 0 )
    {
      totalcost=z*(*kcenter);
      for( int i = 0; i < nproc; i++ )
	{
	  totalcost += costs[i];
	} 
      free(costs);
    }
#ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
#endif

  return(totalcost);
}

/* For a given point x, find the cost of the following operation:
 * -- open a facility at x if there isn't already one there,
 * -- for points y such that the assignment distance of y exceeds dist(y, x),
 *    make y a member of x,
 * -- for facilities y such that reassigning y and all its members to x 
 *    would save cost, realize this closing and reassignment.
 * 
 * If the cost of this operation is negative (i.e., if this entire operation
 * saves cost), perform this operation and return the amount of cost saved;
 * otherwise, do nothing.
 */

/* numcenters will be updated to reflect the new number of centers */
/* z is the facility cost, x is the number of this point in the array 
   points */



// used in pFL
double pgain(long x, Points *points, double z, long int *numcenters, int pid, pthread_barrier_t* barrier)
{
  //  printf("pgain pthread %d begin\n",pid);
#ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
#endif

  // PGainCallManager - start

  //my block
  long bsize = points->num/nproc;
  long k1 = bsize * pid;
  long k2 = k1 + bsize;
  if( pid == nproc-1 ) 
    k2 = points->num;

  int i;
  int number_of_centers_to_close = 0;

  static double *work_mem;
  static double gl_cost_of_opening_x;
  static int gl_number_of_centers_to_close;

  //each thread takes a block of working_mem.
  int stride = *numcenters+2;
  //make stride a multiple of CACHE_LINE
  int cl = CACHE_LINE/sizeof(double);
  if( stride % cl != 0 ) 
  { 
    stride = cl * ( stride / cl + 1);
  }
  int K = stride -2 ; // K==*numcenters
  
  //my own cost of opening x
  double cost_of_opening_x = 0;

  if( pid==0 )    
  { 
    work_mem = (double*) malloc(stride*(nproc+1)*sizeof(double));
    gl_cost_of_opening_x = 0;
    gl_number_of_centers_to_close = 0;
  }

// PGainCallManager - end

#ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
#endif
  /*For each center, we have a *lower* field that indicates 
    how much we will save by closing the center. 
    Each thread has its own copy of the *lower* fields as an array.
    We first build a table to index the positions of the *lower* fields. 
  */

// PGainWorker1 - start

  int count = 0;
  for( int i = k1; i < k2; i++ ) 
  {
    if( is_center[i] ) 
    {
      center_table[i] = count++;
    }
  }
  work_mem[pid*stride] = count;

// PGainWorker1 - end

#ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
#endif

// PGainAccumulator1 - start

  if( pid == 0 ) 
  {
    int accum = 0;
    for( int p = 0; p < nproc; p++ ) 
    {
      int tmp = (int)work_mem[p*stride];
      work_mem[p*stride] = accum;
      accum += tmp;
    }
  }

// PGainAccumulator1 - end

#ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
#endif

// PGainWorker2 - start

  for( int i = k1; i < k2; i++ ) 
  {
    if( is_center[i] ) 
    {
      center_table[i] += (int)work_mem[pid*stride];
    }
  }

  //now we finish building the table. clear the working memory.
  memset(switch_membership + k1, 0, (k2-k1)*sizeof(bool));
  memset(work_mem+pid*stride, 0, stride*sizeof(double));

// PGainWorker2 - end

// PGainAccumulator2 - start
  if( pid== 0 ) 
    memset(work_mem+nproc*stride,0,stride*sizeof(double));

// PGainAccumulator2 - end

#ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
#endif

// PGainWorker3 - start
  
  //my *lower* fields
  double* lower = &work_mem[pid*stride];
  //global *lower* fields
  double* gl_lower = &work_mem[nproc*stride];

  for ( i = k1; i < k2; i++ ) 
  {
    float x_cost = dist(points->p[i], points->p[x], points->dim) * points->p[i].weight;
    float current_cost = points->p[i].cost;

    if ( x_cost < current_cost ) 
    {

      // point i would save cost just by switching to x
      // (note that i cannot be a median, 
      // or else dist(p[i], p[x]) would be 0)
      
      switch_membership[i] = 1;
      cost_of_opening_x += x_cost - current_cost;

    } 
    else 
    {

      // cost of assigning i to x is at least current assignment cost of i

      // consider the savings that i's **current** median would realize
      // if we reassigned that median and all its members to x;
      // note we've already accounted for the fact that the median
      // would save z by closing; now we have to subtract from the savings
      // the extra cost of reassigning that median and its members 
      int assign = points->p[i].assign;
      lower[center_table[assign]] += current_cost - x_cost;
    }
  }

// PGainWorker3 - end

// PGainAccumulator3 - start and end

#ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
#endif

// PGainWorker 4 - start

  // at this time, we can calculate the cost of opening a center
  // at x; if it is negative, we'll go through with opening it

  for ( int i = k1; i < k2; i++ ) 
  {
    if( is_center[i] ) 
    {
      double low = z;
      //aggregate from all threads
      for( int p = 0; p < nproc; p++ ) 
      {
	      low += work_mem[center_table[i]+p*stride];
      }
      gl_lower[center_table[i]] = low;
      if ( low > 0 ) 
      {
        // i is a median, and
        // if we were to open x (which we still may not) we'd close i

        // note, we'll ignore the following quantity unless we do open x
        ++number_of_centers_to_close;  
        cost_of_opening_x -= low;
      }
    }
  }
  //use the rest of working memory to store the following
  work_mem[pid*stride + K] = number_of_centers_to_close;
  work_mem[pid*stride + K+1] = cost_of_opening_x;

// PGainWorker4 - end

#ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
#endif
  //  printf("thread %d cost complete\n",pid); 

// PGainAccumulator4 - start

  if( pid==0 )
  {
    gl_cost_of_opening_x = z;
    //aggregate
    for( int p = 0; p < nproc; p++ ) 
    {
      gl_number_of_centers_to_close += (int)work_mem[p*stride + K];
      gl_cost_of_opening_x += work_mem[p*stride+K+1];
    }
  }

// PGainAccumulator4 - end

#ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
#endif
  // Now, check whether opening x would save cost; if so, do it, and
  // otherwise do nothing

// PGainWorker5 - start

  if ( gl_cost_of_opening_x < 0 ) 
  {
    //  we'd save money by opening x; we'll do it
    for ( int i = k1; i < k2; i++ ) 
    {
      bool close_center = gl_lower[center_table[points->p[i].assign]] > 0;
      if ( switch_membership[i] || close_center ) 
      {
        // Either i's median (which may be i itself) is closing,
        // or i is closer to x than to its current median
        points->p[i].cost = points->p[i].weight * dist(points->p[i], points->p[x], points->dim);
        points->p[i].assign = x;
      }
    }
    for( int i = k1; i < k2; i++ ) 
    {
      if( is_center[i] && gl_lower[center_table[i]] > 0 ) 
      {
	      is_center[i] = false;
      }
    }
    if( x >= k1 && x < k2 ) 
    {
      is_center[x] = true;
    }

    if( pid==0 ) 
    {
      *numcenters = *numcenters + 1 - gl_number_of_centers_to_close;
    }
  }
  else 
  {
    if( pid==0 )
      gl_cost_of_opening_x = 0;  // the value we'll return
  }

// PGainWorker5 - end

#ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
#endif

// PGainAccumulator5 - start (and pid == 0 blocks from above included)

  if( pid == 0 ) 
  {
    free(work_mem);
    //    free(is_center);
    //    free(switch_membership);
    //    free(proc_cost_of_opening_x);
    //    free(proc_number_of_centers_to_close);
  }

// PGainAccumulator5 - end

  return -gl_cost_of_opening_x;
}

/* facility location on the points using local search */
/* z is the facility cost, returns the total cost and # of centers */
/* assumes we are seeded with a reasonable solution */
/* cost should represent this solution's cost */
/* halt if there is < e improvement after iter calls to gain */
/* feasible is an array of numfeasible points which may be centers */
// used in pkmedian
float pFL(Points *points, int *feasible, int numfeasible,
	  float z, long *k, double cost, long iter, float e, 
	  int pid, pthread_barrier_t* barrier)
{
  #ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
  #endif
  long i;
  long x;
  double change;
  long numberOfPoints;

  change = cost;
  /* continue until we run iter iterations without improvement */
  /* stop instead if improvement is less than e */
  while (change/cost > 1.0*e) 
  {
    change = 0.0;
    numberOfPoints = points->num;
    /* randomize order in which centers are considered */

    if( pid == 0 ) 
    {
      intshuffle(feasible, numfeasible);
    }
    #ifdef ENABLE_THREADS
    pthread_barrier_wait(barrier);
    #endif
    for (i=0;i<iter;i++) 
    {
      x = i%numfeasible;
      change += pgain(feasible[x], points, z, k, pid, barrier);
    }
    cost -= change;
    #ifdef ENABLE_THREADS
    pthread_barrier_wait(barrier);
    #endif
  }
  return(cost);
}

int selectfeasible_fast(Points *points, int **feasible, int kmin, int pid, pthread_barrier_t* barrier)
{
  int numfeasible = points->num;
  if (numfeasible > (ITER*kmin*log((double)kmin)))
    numfeasible = (int)(ITER*kmin*log((double)kmin));
  *feasible = (int *)malloc(numfeasible*sizeof(int));
  
  float* accumweight;
  float totalweight;

  /* 
     Calcuate my block. 
     For now this routine does not seem to be the bottleneck, so it is not parallelized. 
     When necessary, this can be parallelized by setting k1 and k2 to 
     proper values and calling this routine from all threads ( it is called only
     by thread 0 for now ). 
     Note that when parallelized, the randomization might not be the same and it might
     not be difficult to measure the parallel speed-up for the whole program. 
   */
  //  long bsize = numfeasible;
  long k1 = 0;
  long k2 = numfeasible;

  float w;
  int l,r,k;

  /* not many points, all will be feasible */
  if (numfeasible == points->num) {
    for (int i=k1;i<k2;i++)
      (*feasible)[i] = i;
    return numfeasible;
  }
  accumweight= (float*)malloc(sizeof(float)*points->num);

  accumweight[0] = points->p[0].weight;
  totalweight=0;
  for( int i = 1; i < points->num; i++ ) {
    accumweight[i] = accumweight[i-1] + points->p[i].weight;
  }
  totalweight=accumweight[points->num-1];

  for(int i=k1; i<k2; i++ ) {
    w = (lrand48()/(float)INT_MAX)*totalweight;
    //binary search
    l=0;
    r=points->num-1;
    if( accumweight[0] > w )  { 
      (*feasible)[i]=0; 
      continue;
    }
    while( l+1 < r ) {
      k = (l+r)/2;
      if( accumweight[k] > w ) {
	r = k;
      } 
      else {
	l=k;
      }
    }
    (*feasible)[i]=r;
  }

  free(accumweight); 

  return numfeasible;
}



/* compute approximate kmedian on the points */
// used in local search sub
float pkmedian(Points *points, long kmin, long kmax, long* kfinal,
	       int pid, pthread_barrier_t* barrier )
{
  // PKMedianWorker1 - start
  int i;
  double cost;
  double lastcost;
  double hiz, loz, z;

  static long k;
  static int *feasible;
  static int numfeasible;
  static double* hizs;

  if( pid==0 ) hizs = (double*)calloc(nproc,sizeof(double));
  hiz = loz = 0.0;
  long numberOfPoints = points->num;
  long ptDimension = points->dim;

  //my block
  long bsize = points->num/nproc;
  long k1 = bsize * pid;
  long k2 = k1 + bsize;
  if( pid == nproc-1 ) k2 = points->num;

  double myhiz = 0;
  for (long kk=k1;kk < k2; kk++ ) 
  {
    myhiz += dist(points->p[kk], points->p[0], ptDimension ) * points->p[kk].weight;
  }

  hizs[pid] = myhiz;

  // PKMedianWorker1 - end

#ifdef ENABLE_THREADS  
  pthread_barrier_wait(barrier);
#endif

// PKMedianAccumulator1 - start

  for( int i = 0; i < nproc; i++ )   {
    hiz += hizs[i];
  }

  loz=0.0; z = (hiz+loz)/2.0;
  /* NEW: Check whether more centers than points! */
  if (points->num <= kmax) {
    /* just return all points as facilities */
    for (long kk=k1;kk<k2;kk++) {
      points->p[kk].assign = kk;
      points->p[kk].cost = 0;
    }
    cost = 0;
    if( pid== 0 ) {
      free(hizs); 
      *kfinal = k;
    }
    return cost;
  }

  // PKMedianAccumulator1 - end

  if( pid == 0 ) shuffle(points);
  cost = pspeedy(points, z, &k, pid, barrier);

  i=0;
  /* give speedy SP chances to get at least kmin/2 facilities */
  while ((k < kmin)&&(i<SP)) {
    cost = pspeedy(points, z, &k, pid, barrier);
    i++;
  }

  /* if still not enough facilities, assume z is too high */
  while (k < kmin) {
    if (i >= SP) {hiz=z; z=(hiz+loz)/2.0; i=0;}
    if( pid == 0 ) shuffle(points);
    cost = pspeedy(points, z, &k, pid, barrier);
    i++;
  }

  /* now we begin the binary search for real */
  /* must designate some points as feasible centers */
  /* this creates more consistancy between FL runs */
  /* helps to guarantee correct # of centers at the end */
  
  if( pid == 0 )
    {
      numfeasible = selectfeasible_fast(points,&feasible,kmin,pid,barrier);
      for( int i = 0; i< points->num; i++ ) {
	is_center[points->p[i].assign]= true;
      }
    }

#ifdef ENABLE_THREADS
  pthread_barrier_wait(barrier);
#endif

// PKMedianAccumulator2 - start

  while(1) {
    /* first get a rough estimate on the FL solution */
    lastcost = cost;
    cost = pFL(points, feasible, numfeasible,
	       z, &k, cost, (long)(ITER*kmax*log((double)kmax)), 0.1, pid, barrier);

    /* if number of centers seems good, try a more accurate FL */
    if (((k <= (1.1)*kmax)&&(k >= (0.9)*kmin))||
	((k <= kmax+2)&&(k >= kmin-2))) {

      /* may need to run a little longer here before halting without
	 improvement */
      cost = pFL(points, feasible, numfeasible,
		 z, &k, cost, (long)(ITER*kmax*log((double)kmax)), 0.001, pid, barrier);
    }

    if (k > kmax) {
      /* facilities too cheap */
      /* increase facility cost and up the cost accordingly */
      loz = z; z = (hiz+loz)/2.0;
      cost += (z-loz)*k;
    }
    if (k < kmin) {
      /* facilities too expensive */
      /* decrease facility cost and reduce the cost accordingly */
      hiz = z; z = (hiz+loz)/2.0;
      cost += (z-hiz)*k;
    }

    /* if k is good, return the result */
    /* if we're stuck, just give up and return what we have */
    if (((k <= kmax)&&(k >= kmin))||((loz >= (0.999)*hiz)) )
	      break;

#ifdef ENABLE_THREADS
    pthread_barrier_wait(barrier);
#endif
  }

  //clean up...
  if( pid==0 ) {
    free(feasible); 
    free(hizs);
    *kfinal = k;
  }

// PKMedianAccumulator2 - end

  return cost;
}

/* compute the means for the k clusters */
int contcenters(Points *points)
{
  long i, ii;
  float relweight;

  for (i=0;i<points->num;i++) {
    /* compute relative weight of this point to the cluster */
    if (points->p[i].assign != i) {
      relweight=points->p[points->p[i].assign].weight + points->p[i].weight;
      relweight = points->p[i].weight/relweight;
      for (ii=0;ii<points->dim;ii++) {
	points->p[points->p[i].assign].coord[ii]*=1.0-relweight;
	points->p[points->p[i].assign].coord[ii]+=
	  points->p[i].coord[ii]*relweight;
      }
      points->p[points->p[i].assign].weight += points->p[i].weight;
    }
  }
  
  return 0;
}

/* copy centers from points to centers */
void copycenters(Points *points, Points* centers, long* centerIDs, long offset)
{
  long i;
  long k;

  bool *is_a_median = (bool *) calloc(points->num, sizeof(bool));

  /* mark the centers */
  for ( i = 0; i < points->num; i++ ) {
    is_a_median[points->p[i].assign] = 1;
  }

  k=centers->num;

  /* count how many  */
  for ( i = 0; i < points->num; i++ ) {
    if ( is_a_median[i] ) {
      memcpy( centers->p[k].coord, points->p[i].coord, points->dim * sizeof(float));
      centers->p[k].weight = points->p[i].weight;
      centerIDs[k] = i + offset;
      k++;
    }
  }

  centers->num = k;

  free(is_a_median);
}

// used in localSearch
void* localSearchSub(void* arg_) {

  pkmedian_arg_t* arg= (pkmedian_arg_t*)arg_;
  pkmedian(arg->points,arg->kmin,arg->kmax,arg->kfinal,arg->pid,arg->barrier);

  return NULL;
}

// used in streamCluster
void localSearch( Points* points, long kmin, long kmax, long* kfinal ) {
    pthread_barrier_t barrier;
    pthread_t* threads = new pthread_t[nproc];
    pkmedian_arg_t* arg = new pkmedian_arg_t[nproc];

#ifdef ENABLE_THREADS
    pthread_barrier_init(&barrier,NULL,nproc);
#endif
    for( int i = 0; i < nproc; i++ ) {
      arg[i].points = points;
      arg[i].kmin = kmin;
      arg[i].kmax = kmax;
      arg[i].pid = i;
      arg[i].kfinal = kfinal;

      arg[i].barrier = &barrier;
#ifdef ENABLE_THREADS
      pthread_create(threads+i,NULL,localSearchSub,(void*)&arg[i]);
#else
      localSearchSub(&arg[0]);
#endif
    }

#ifdef ENABLE_THREADS
    for ( int i = 0; i < nproc; i++) {
      pthread_join(threads[i],NULL);
    }
#endif

    delete[] threads;
    delete[] arg;
#ifdef ENABLE_THREADS
    pthread_barrier_destroy(&barrier);
#endif
}

void outcenterIDs( Points* centers, long* centerIDs, char* outfile ) {
  FILE* fp = fopen(outfile, "w");
  if( fp==NULL ) {
    fprintf(stderr, "error opening %s\n",outfile);
    exit(1);
  }
  int* is_a_median = (int*)calloc( sizeof(int), centers->num );
  for( int i =0 ; i< centers->num; i++ ) {
    is_a_median[centers->p[i].assign] = 1;
  }

  for( int i = 0; i < centers->num; i++ ) {
    if( is_a_median[i] ) {
      fprintf(fp, "%lu\n", centerIDs[i]);
      fprintf(fp, "%lf\n", centers->p[i].weight);
      for( int k = 0; k < centers->dim; k++ ) {
	fprintf(fp, "%lf ", centers->p[i].coord[k]);
      }
      fprintf(fp,"\n\n");
    }
  }
  fclose(fp);
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
  long kfinal;

  bool shouldContinue = true;
  // Kernel Initialization
  StreamClusterStarterKernel starter;
  PStreamReader streamReader(stream, block, dim, chunksize, &shouldContinue, &IDoffset);
  LocalSearchStarter localSearchStarter(&points, &centers, nproc, isCenter, centerTable, switchMembership);
  std::vector<PKMedianWorker1*> pkMedianWorkers;
  PKMedianAccumulator1 pkMedianAccumulator1(kmin, kmax, &kfinal, nproc);
  PSpeedyCallManager pSpeedyCallManager(nproc, kmin, SP);
  std::vector<PSpeedyWorker*> pSpeedyWorkers;
  SelectFeasible_FastKernel selectFeasible(kmin, ITER, isCenter);
  PGainCallManager pGainCallManager(CACHE_LINE, nproc);
  std::vector<PGainWorker1*> pGainWorker1s;
  PGainAccumulator1 pGainAccumulator1(nproc);
  std::vector<PGainWorker2*> pGainWorker2s;
  PGainAccumulator2 pGainAccumulator2(nproc);
  std::vector<PGainWorker3*> pGainWorker3s;
  PGainAccumulator3 pGainAccumulator3(nproc);
  std::vector<PGainWorker4*> pGainWorker4s;
  PGainAccumulator4 pGainAccumulator4(nproc);
  std::vector<PGainWorker5*> pGainWorker5s;
  PGainAccumulator5 pGainAccumulator5(nproc);
  PFLCallManager pFLCallManager;
  PKMedianAccumulator2 pkMedianAccumulator2(kmin, kmax, &kfinal, ITER, isCenter, centerTable, switchMembership);
  ContCentersKernel contCenters(&points, &centers);
  CopyCentersKernel copyCenters(&points, &centers, centerIDs, &IDoffset);
  OutCenterIDsKernel outCenters(&centers, centerIDs, outfile);
  raft::map m;

  for (auto i = 0; i < nproc; i++)
  {
    pkMedianWorkers.push_back(new PKMedianWorker1);
    pSpeedyWorkers.push_back(new PSpeedyWorker);
    pGainWorker1s.push_back(new PGainWorker1(isCenter, centerTable));
    pGainWorker2s.push_back(new PGainWorker2(isCenter, centerTable, switchMembership));
    pGainWorker3s.push_back(new PGainWorker3(isCenter, centerTable, switchMembership, nproc));
    pGainWorker4s.push_back(new PGainWorker4(isCenter, centerTable, nproc));
    pGainWorker5s.push_back(new PGainWorker5(isCenter, centerTable, switchMembership));
  }

  // Map Construction
  m += starter >> streamReader["input_start"];
  m += streamReader >> localSearchStarter;
  m += pkMedianAccumulator1["output_pspeedy"] >> pSpeedyCallManager["in_main"];
  m += selectFeasible >> pkMedianAccumulator2["input_main"];
  m += pkMedianAccumulator2["output_pfl"] >> pFLCallManager["input_main"];
  m += pFLCallManager["output_pgain"] >> pGainCallManager;
  m += pGainAccumulator5 >> pFLCallManager["input_change"];
  m += pFLCallManager["output_cost"] >> pkMedianAccumulator2["input_pfl"];
  m += pSpeedyCallManager["cost"] >> selectFeasible;
  m += pkMedianAccumulator2["output_end"] >> contCenters["input_pkmedian2"];
  m += pkMedianAccumulator1["output_end"] >> contCenters["input_pkmedian1"];
  m += contCenters["output_copy"] >> copyCenters;
  m += contCenters["output_out"] >> outCenters;
  m += copyCenters >> streamReader["input_continue"];
 

  for (auto i = 0; i < nproc; i++)
  {
    const char* to_str = std::to_string(i).c_str();
    m += localSearchStarter[to_str] >> *(pkMedianWorkers[i]);
    m += *(pkMedianWorkers[i]) >> pkMedianAccumulator1[to_str];
    m += pSpeedyCallManager[to_str] >> *(pSpeedyWorkers[i]);
    m += *(pSpeedyWorkers[i]) >> pSpeedyCallManager[to_str];
    m += pGainCallManager[to_str] >> *(pGainWorker1s[i]);
    m += *(pGainWorker1s[i]) >> pGainAccumulator1[to_str];
    m += pGainAccumulator1[to_str] >> *(pGainWorker2s[i]);
    m += *(pGainWorker2s[i]) >> pGainAccumulator2[to_str];
    m += pGainAccumulator2[to_str] >> *(pGainWorker3s[i]);
    m += *(pGainWorker3s[i]) >> pGainAccumulator3[to_str];
    m += pGainAccumulator3[to_str] >> *(pGainWorker4s[i]);
    m += *(pGainWorker4s[i]) >> pGainAccumulator4[to_str];
    m += pGainAccumulator4[to_str] >> *(pGainWorker5s[i]);
    m += *(pGainWorker5s[i]) >> pGainAccumulator5[to_str];
  }

  //while (shouldContinue)
  //{
  //while(1) 
  //{

    /**
     * TODO: figure out a way to set weights
     *
     * PIPELINE IDEA
     * streamread -> setweights -> localsearch
     */
    /*
    size_t numRead  = stream->read(block, dim, chunksize ); 
    fprintf(stderr,"read %d points\n",numRead);

    if( stream->ferror() || numRead < (unsigned int)chunksize && !stream->feof() ) {
      fprintf(stderr, "error reading data!\n");
      exit(1);
    }

    points.num = numRead;
    for( int i = 0; i < points.num; i++ ) {
      points.p[i].weight = 1.0;
    }
    */
    //switch_membership = (bool*)malloc(points.num*sizeof(bool));
    //is_center = (bool*)calloc(points.num,sizeof(bool));
    //center_table = (int*)malloc(points.num*sizeof(int));


    //fprintf(stderr,"center_table = 0x%08x\n",(int)center_table);
    //fprintf(stderr,"is_center = 0x%08x\n",(int)is_center);

    //localSearch(&points,kmin, kmax,&kfinal); // parallel
    
    //std::cout << "Executing the map" << std::endl;
    //m.exe();
    //std::cout << "Done with execution" << std::endl;

    //fprintf(stderr,"finish local search\n");
    //contcenters(&points); /* sequential */
    //if( kfinal + centers.num > centersize ) {
      //here we don't handle the situation where # of centers gets too large. 
      //fprintf(stderr,"oops! no more space for centers\n");
      //exit(1);
    //}

    //copycenters(&points, &centers, centerIDs, IDoffset); /* sequential */
    //IDoffset += numRead;
    //IDoffset += 0;

    //free(is_center);
    //free(switch_membership);
    //free(center_table);

    //if( stream->feof() ) {
    //  break;
    //}
  //}

  //finally cluster all temp centers
  //switch_membership = (bool*)malloc(centers.num*sizeof(bool));
  //is_center = (bool*)calloc(centers.num,sizeof(bool));
  //center_table = (int*)malloc(centers.num*sizeof(int));

  //localSearch( &centers, kmin, kmax ,&kfinal ); // parallel
  //std::cout << "Performing final execution of map" << std::endl;
  //m.exe();
  //contcenters(&centers);
  //outcenterIDs( &centers, centerIDs, outfile);

  m.exe();

  for (auto i = 0; i < nproc; i++)
  {
    delete pkMedianWorkers[i];
    delete pSpeedyWorkers[i];
    delete pGainWorker1s[i];
    delete pGainWorker2s[i];
    delete pGainWorker3s[i];
    delete pGainWorker4s[i];
    delete pGainWorker5s[i];
  }

  delete[] switchMembership;
  delete[] isCenter;
  delete[] centerTable;
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
    fprintf(stderr,"  nproc:       Number of threads to use\n");
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
