//Code written by Richard O. Lee and Christian Bienia
//Modified by Christian Fensch
// RaftLib implementation provided by James Wood


#include <cstdlib>
#include <cstring>

#include <iostream>
#include <fstream>
#include <math.h>
#include <assert.h>
#include <float.h>

#include "fluid.hpp"
#include "cellpool.hpp"

#ifdef ENABLE_VISUALIZATION
#include "fluidview.hpp"
#endif

#include "raftlib_src.hpp"

//Uncomment to add code to check that Courant–Friedrichs–Lewy condition is satisfied at runtime
//#define ENABLE_CFL_CHECK

////////////////////////////////////////////////////////////////////////////////

cellpool *pools; //each thread has its private cell pool

fptype restParticlesPerMeter, h, hSq;
fptype densityCoeff, pressureCoeff, viscosityCoeff;

int nx, ny, nz;    // number of grid cells in each dimension
Vec3 delta;        // cell dimensions
int numParticles = 0;
int numCells = 0;
Cell *cells = 0;
Cell *cells2 = 0;
int *cnumPars = 0;
int *cnumPars2 = 0;
Cell **last_cells = NULL; //helper array with pointers to last cell structure of "cells" array lists
#ifdef ENABLE_VISUALIZATION
Vec3 vMax(0.0,0.0,0.0);
Vec3 vMin(0.0,0.0,0.0);
#endif

int XDIVS = 1;  // number of partitions in X
int ZDIVS = 1;  // number of partitions in Z

#define NUM_GRIDS  ((XDIVS) * (ZDIVS))
#define MUTEXES_PER_CELL 128
#define CELL_MUTEX_ID 0

Grid *grids;
bool  *border;
#ifdef USE_MUTEX
pthread_mutex_t **mutex;
#endif

typedef struct __thread_args {
  int tid;      //thread id, determines work partition
  int frames;      //number of frames to compute
} thread_args;      //arguments for threads

////////////////////////////////////////////////////////////////////////////////

/*
 * hmgweight
 *
 * Computes the hamming weight of x
 *
 * x      - input value
 * lsb    - if x!=0 position of smallest bit set, else -1
 *
 * return - the hamming weight
 */
unsigned int hmgweight(unsigned int x, int *lsb) {
  unsigned int weight=0;
  unsigned int mask= 1;
  unsigned int count=0;

  *lsb=-1;
  while(x > 0) {
    //unsigned int temp;
    //temp=(x&mask);
    if((x&mask) == 1) {
      weight++;
      if(*lsb == -1) *lsb = count;
    }
    x >>= 1;
    count++;
  }

  return weight;
}

void InitSim(char const *fileName, unsigned int threadnum)
{
  //Compute partitioning based on square root of number of threads
  //NOTE: Other partition sizes are possible as long as XDIVS * ZDIVS == threadnum,
  //      but communication is minimal (and hence optimal) if XDIVS == ZDIVS
  int lsb;
  if(hmgweight(threadnum,&lsb) != 1) {
    std::cerr << "Number of threads must be a power of 2" << std::endl;
    exit(1);
  }
  XDIVS = 1<<(lsb/2);
  ZDIVS = 1<<(lsb/2);
  if((unsigned int)(XDIVS*ZDIVS) != threadnum) XDIVS*=2;
  assert((unsigned int)(XDIVS * ZDIVS) == threadnum);

  grids = new struct Grid[NUM_GRIDS];
  assert(sizeof(Grid) <= CACHELINE_SIZE); // as we put and aligh grid on the cacheline size to avoid false-sharing
                                          // if asserts fails - increase pp union member in Grid declarationi
                                          // and change this macro 
  pools = new cellpool[NUM_GRIDS];

  //Load input particles
  std::cout << "Loading file \"" << fileName << "\"..." << std::endl;
  std::ifstream file(fileName, std::ios::binary);
  if(!file) {
    std::cerr << "Error opening file. Aborting." << std::endl;
    exit(1);
  }

  //Always use single precision float variables b/c file format uses single precision
  float restParticlesPerMeter_le;
  int numParticles_le;
  file.read((char *)&restParticlesPerMeter_le, FILE_SIZE_FLOAT);
  file.read((char *)&numParticles_le, FILE_SIZE_INT);
  if(!isLittleEndian()) {
    restParticlesPerMeter = bswap_float(restParticlesPerMeter_le);
    numParticles          = bswap_int32(numParticles_le);
  } else {
    restParticlesPerMeter = restParticlesPerMeter_le;
    numParticles          = numParticles_le;
  }
  for(int i=0; i<NUM_GRIDS; i++) cellpool_init(&pools[i], numParticles/NUM_GRIDS);

  h = kernelRadiusMultiplier / restParticlesPerMeter;
  hSq = h*h;

#ifndef ENABLE_DOUBLE_PRECISION
  fptype coeff1 = 315.0 / (64.0*pi*powf(h,9.0));
  fptype coeff2 = 15.0 / (pi*powf(h,6.0));
  fptype coeff3 = 45.0 / (pi*powf(h,6.0));
#else
  fptype coeff1 = 315.0 / (64.0*pi*pow(h,9.0));
  fptype coeff2 = 15.0 / (pi*pow(h,6.0));
  fptype coeff3 = 45.0 / (pi*pow(h,6.0));
#endif //ENABLE_DOUBLE_PRECISION
  fptype particleMass = 0.5*doubleRestDensity / (restParticlesPerMeter*restParticlesPerMeter*restParticlesPerMeter);
  densityCoeff = particleMass * coeff1;
  pressureCoeff = 3.0*coeff2 * 0.50*stiffnessPressure * particleMass;
  viscosityCoeff = viscosity * coeff3 * particleMass;

  Vec3 range = domainMax - domainMin;
  nx = (int)(range.x / h);
  ny = (int)(range.y / h);
  nz = (int)(range.z / h);
  assert(nx >= 1 && ny >= 1 && nz >= 1);
  numCells = nx*ny*nz;
  std::cout << "Number of cells: " << numCells << std::endl;
  delta.x = range.x / nx;
  delta.y = range.y / ny;
  delta.z = range.z / nz;
  assert(delta.x >= h && delta.y >= h && delta.z >= h);

  std::cout << "Grids steps over x, y, z: " << delta.x << " " << delta.y << " " << delta.z << std::endl;
  
  assert(nx >= XDIVS && nz >= ZDIVS);
  int gi = 0;
  int sx, sz, ex, ez;
  ex = 0;
  for(int i = 0; i < XDIVS; ++i)
  {
    sx = ex;
    ex = (int)((fptype)(nx)/(fptype)(XDIVS) * (i+1) + 0.5);
    assert(sx < ex);

    ez = 0;
    for(int j = 0; j < ZDIVS; ++j, ++gi)
    {
      sz = ez;
      ez = (int)((fptype)(nz)/(fptype)(ZDIVS) * (j+1) + 0.5);
      assert(sz < ez);

      grids[gi].sx = sx;
      grids[gi].ex = ex;
      grids[gi].sy = 0;
      grids[gi].ey = ny;
      grids[gi].sz = sz;
      grids[gi].ez = ez;
    }
  }
  assert(gi == NUM_GRIDS);

  border = new bool[numCells];
  for(int i = 0; i < NUM_GRIDS; ++i)
    for(int iz = grids[i].sz; iz < grids[i].ez; ++iz)
      for(int iy = grids[i].sy; iy < grids[i].ey; ++iy)
        for(int ix = grids[i].sx; ix < grids[i].ex; ++ix)
        {
          int index = (iz*ny + iy)*nx + ix;
          border[index] = false;
          for(int dk = -1; dk <= 1; ++dk)
	  {
            for(int dj = -1; dj <= 1; ++dj)
	    {
              for(int di = -1; di <= 1; ++di)
              {
                int ci = ix + di;
                int cj = iy + dj;
                int ck = iz + dk;

                if(ci < 0) ci = 0; else if(ci > (nx-1)) ci = nx-1;
                if(cj < 0) cj = 0; else if(cj > (ny-1)) cj = ny-1;
                if(ck < 0) ck = 0; else if(ck > (nz-1)) ck = nz-1;

                if( ci < grids[i].sx || ci >= grids[i].ex ||
                  cj < grids[i].sy || cj >= grids[i].ey ||
                  ck < grids[i].sz || ck >= grids[i].ez ) {
                      
                    border[index] = true;
		    break;
		}
              } // for(int di = -1; di <= 1; ++di)
	      if(border[index])
		break;
	    } // for(int dj = -1; dj <= 1; ++dj)
	    if(border[index])
	       break;
           } // for(int dk = -1; dk <= 1; ++dk)
        }
  
  #ifdef USE_MUTEX

  mutex = new pthread_mutex_t *[numCells];
  for (int i = 0; i < numCells; ++i)
  {
    assert(CELL_MUTEX_ID < MUTEXES_PER_CELL);
    int n = (border[i] ? MUTEXES_PER_CELL : CELL_MUTEX_ID+1);
    mutex[i] = new pthread_mutex_t[n];
    for (int j = 0; j < n; ++j)
      pthread_mutex_init(&mutex[i][j], NULL);
  }

  #endif

  //make sure Cell structure is multiple of estiamted cache line size
  assert(sizeof(Cell) % CACHELINE_SIZE == 0);
  //make sure helper Cell structure is in sync with real Cell structure
  assert(offsetof(struct Cell_aux, padding) == offsetof(struct Cell, padding));

  int rv0 = posix_memalign((void **)(&cells), CACHELINE_SIZE, sizeof(struct Cell) * numCells);
  int rv1 = posix_memalign((void **)(&cells2), CACHELINE_SIZE, sizeof(struct Cell) * numCells);
  int rv2 = posix_memalign((void **)(&cnumPars), CACHELINE_SIZE, sizeof(int) * numCells);
  int rv3 = posix_memalign((void **)(&cnumPars2), CACHELINE_SIZE, sizeof(int) * numCells);
  int rv4 = posix_memalign((void **)(&last_cells), CACHELINE_SIZE, sizeof(struct Cell *) * numCells);
  assert((rv0==0) && (rv1==0) && (rv2==0) && (rv3==0) && (rv4==0));

  // because cells and cells2 are not allocated via new
  // we construct them here
  for(int i=0; i<numCells; ++i)
  {
	  new (&cells[i]) Cell;
	  new (&cells2[i]) Cell;
  }

  memset(cnumPars, 0, numCells*sizeof(int));

  //Always use single precision float variables b/c file format uses single precision float
  int pool_id = 0;
  float px, py, pz, hvx, hvy, hvz, vx, vy, vz;
  for(int i = 0; i < numParticles; ++i)
  {
    file.read((char *)&px, FILE_SIZE_FLOAT);
    file.read((char *)&py, FILE_SIZE_FLOAT);
    file.read((char *)&pz, FILE_SIZE_FLOAT);
    file.read((char *)&hvx, FILE_SIZE_FLOAT);
    file.read((char *)&hvy, FILE_SIZE_FLOAT);
    file.read((char *)&hvz, FILE_SIZE_FLOAT);
    file.read((char *)&vx, FILE_SIZE_FLOAT);
    file.read((char *)&vy, FILE_SIZE_FLOAT);
    file.read((char *)&vz, FILE_SIZE_FLOAT);
    if(!isLittleEndian()) {
      px  = bswap_float(px);
      py  = bswap_float(py);
      pz  = bswap_float(pz);
      hvx = bswap_float(hvx);
      hvy = bswap_float(hvy);
      hvz = bswap_float(hvz);
      vx  = bswap_float(vx);
      vy  = bswap_float(vy);
      vz  = bswap_float(vz);
    }

    int ci = (int)((px - domainMin.x) / delta.x);
    int cj = (int)((py - domainMin.y) / delta.y);
    int ck = (int)((pz - domainMin.z) / delta.z);

    if(ci < 0) ci = 0; else if(ci > (nx-1)) ci = nx-1;
    if(cj < 0) cj = 0; else if(cj > (ny-1)) cj = ny-1;
    if(ck < 0) ck = 0; else if(ck > (nz-1)) ck = nz-1;

    int index = (ck*ny + cj)*nx + ci;
    Cell *cell = &cells[index];

    //go to last cell structure in list
    int np = cnumPars[index];
    while(np > PARTICLES_PER_CELL) {
      cell = cell->next;
      np = np - PARTICLES_PER_CELL;
    }
    //add another cell structure if everything full
    if( (np % PARTICLES_PER_CELL == 0) && (cnumPars[index] != 0) ) {
      //Get cells from pools in round-robin fashion to balance load during parallel phase
      cell->next = cellpool_getcell(&pools[pool_id]);
      pool_id = (pool_id+1) % NUM_GRIDS;
      cell = cell->next;
      np = np - PARTICLES_PER_CELL;
    }

    cell->p[np].x = px;
    cell->p[np].y = py;
    cell->p[np].z = pz;
    cell->hv[np].x = hvx;
    cell->hv[np].y = hvy;
    cell->hv[np].z = hvz;
    cell->v[np].x = vx;
    cell->v[np].y = vy;
    cell->v[np].z = vz;
#ifdef ENABLE_VISUALIZATION
	vMin.x = std::min(vMin.x, cell->v[np].x);
	vMax.x = std::max(vMax.x, cell->v[np].x);
	vMin.y = std::min(vMin.y, cell->v[np].y);
	vMax.y = std::max(vMax.y, cell->v[np].y);
	vMin.z = std::min(vMin.z, cell->v[np].z);
	vMax.z = std::max(vMax.z, cell->v[np].z);
#endif
    ++cnumPars[index];
  }

  std::cout << "Number of particles: " << numParticles << std::endl;
}

////////////////////////////////////////////////////////////////////////////////

void SaveFile(char const *fileName)
{
  std::cout << "Saving file \"" << fileName << "\"..." << std::endl;

  std::ofstream file(fileName, std::ios::binary);
  assert(file);

  //Always use single precision float variables b/c file format uses single precision
  if(!isLittleEndian()) {
    float restParticlesPerMeter_le;
    int   numParticles_le;

    restParticlesPerMeter_le = bswap_float((float)restParticlesPerMeter);
    numParticles_le      = bswap_int32(numParticles);
    file.write((char *)&restParticlesPerMeter_le, FILE_SIZE_FLOAT);
    file.write((char *)&numParticles_le,      FILE_SIZE_INT);
  } else {
    file.write((char *)&restParticlesPerMeter, FILE_SIZE_FLOAT);
    file.write((char *)&numParticles,      FILE_SIZE_INT);
  }

  int count = 0;
  for(int i = 0; i < numCells; ++i)
  {
    Cell *cell = &cells[i];
    int np = cnumPars[i];
    for(int j = 0; j < np; ++j)
    {
      //Always use single precision float variables b/c file format uses single precision
      float px, py, pz, hvx, hvy, hvz, vx,vy, vz;
      if(!isLittleEndian()) {
        px  = bswap_float((float)(cell->p[j % PARTICLES_PER_CELL].x));
        py  = bswap_float((float)(cell->p[j % PARTICLES_PER_CELL].y));
        pz  = bswap_float((float)(cell->p[j % PARTICLES_PER_CELL].z));
        hvx = bswap_float((float)(cell->hv[j % PARTICLES_PER_CELL].x));
        hvy = bswap_float((float)(cell->hv[j % PARTICLES_PER_CELL].y));
        hvz = bswap_float((float)(cell->hv[j % PARTICLES_PER_CELL].z));
        vx  = bswap_float((float)(cell->v[j % PARTICLES_PER_CELL].x));
        vy  = bswap_float((float)(cell->v[j % PARTICLES_PER_CELL].y));
        vz  = bswap_float((float)(cell->v[j % PARTICLES_PER_CELL].z));
      } else {
        px  = (float)(cell->p[j % PARTICLES_PER_CELL].x);
        py  = (float)(cell->p[j % PARTICLES_PER_CELL].y);
        pz  = (float)(cell->p[j % PARTICLES_PER_CELL].z);
        hvx = (float)(cell->hv[j % PARTICLES_PER_CELL].x);
        hvy = (float)(cell->hv[j % PARTICLES_PER_CELL].y);
        hvz = (float)(cell->hv[j % PARTICLES_PER_CELL].z);
        vx  = (float)(cell->v[j % PARTICLES_PER_CELL].x);
        vy  = (float)(cell->v[j % PARTICLES_PER_CELL].y);
        vz  = (float)(cell->v[j % PARTICLES_PER_CELL].z);
      }
      file.write((char *)&px,  FILE_SIZE_FLOAT);
      file.write((char *)&py,  FILE_SIZE_FLOAT);
      file.write((char *)&pz,  FILE_SIZE_FLOAT);
      file.write((char *)&hvx, FILE_SIZE_FLOAT);
      file.write((char *)&hvy, FILE_SIZE_FLOAT);
      file.write((char *)&hvz, FILE_SIZE_FLOAT);
      file.write((char *)&vx,  FILE_SIZE_FLOAT);
      file.write((char *)&vy,  FILE_SIZE_FLOAT);
      file.write((char *)&vz,  FILE_SIZE_FLOAT);
      ++count;

      //move pointer to next cell in list if end of array is reached
      if(j % PARTICLES_PER_CELL == PARTICLES_PER_CELL-1) {
        cell = cell->next;
      }

    }
  }
  assert(count == numParticles);
}

////////////////////////////////////////////////////////////////////////////////

void CleanUpSim()
{
  // first return extended cells to cell pools
  for(int i=0; i< numCells; ++i)
  {
    Cell& cell = cells[i];
	while(cell.next)
	{
		Cell *temp = cell.next;
		cell.next = temp->next;
		cellpool_returncell(&pools[0], temp);
	}
  }
  // now return cell pools
  //NOTE: Cells from cell pools can migrate to different pools during the parallel phase.
  //      This is no problem as long as all cell pools are destroyed together. Each pool
  //      uses its internal meta information to free exactly the cells which it allocated
  //      itself. This guarantees that all allocated cells will be freed but it might
  //      render other cell pools unusable so they also have to be destroyed.
  for(int i=0; i<NUM_GRIDS; i++) cellpool_destroy(&pools[i]);

  #ifdef USE_MUTEX

  for(int i = 0; i < numCells; ++i)
  {
    assert(CELL_MUTEX_ID < MUTEXES_PER_CELL);
    int n = (border[i] ? MUTEXES_PER_CELL : CELL_MUTEX_ID+1);
    for(int j = 0; j < n; ++j)
      pthread_mutex_destroy(&mutex[i][j]);
    delete[] mutex[i];
  }
  delete[] mutex;

  #endif

  delete[] border;

  free(cells);
  free(cells2);
  free(cnumPars);
  free(cnumPars2);
  free(last_cells);
  delete[] grids;
}

////////////////////////////////////////////////////////////////////////////////

SimpleAccumulatorKernel::SimpleAccumulatorKernel(int threadCount)
  : raft::kernel_all(), m_ThreadCount(threadCount)
{
  // Add our IO ports
  for (auto i = 0; i < m_ThreadCount; i++)
  {
    const char* val = std::to_string(i).c_str();
    input.addPort<int>(val);
    output.addPort<int>(val);
  }
}

raft::kstatus SimpleAccumulatorKernel::run()
{
  // Pass through the TIDs
  for (auto i = 0; i < m_ThreadCount; i++)
  {
    const char* val = std::to_string(i).c_str();
    output[val].push<int>(i);
    input[val].recycle();
  }

  return raft::proceed;
}

////////////////////////////////////////////////////////////////////////////////

SimpleProducerKernel::SimpleProducerKernel(int threadCount)
  : raft::kernel(), m_ThreadCount(threadCount)
{
  // Add our IO ports
  for (auto i = 0; i < m_ThreadCount; i++)
  {
    const char* val = std::to_string(i).c_str();
    output.addPort<int>(val);
  }
}

raft::kstatus SimpleProducerKernel::run()
{
  // Pass through the TIDs
  for (auto i = 0; i < m_ThreadCount; i++)
  {
    const char* val = std::to_string(i).c_str();
    output[val].push<int>(i);
  }

  return raft::stop;
}

////////////////////////////////////////////////////////////////////////////////

SimpleConsumerKernel::SimpleConsumerKernel(int threadCount)
  : raft::kernel_all(), m_ThreadCount(threadCount)
{
  // Add our IO ports
  for (auto i = 0; i < m_ThreadCount; i++)
  {
    const char* val = std::to_string(i).c_str();
    input.addPort<int>(val);
  }
}

raft::kstatus SimpleConsumerKernel::run()
{
  for (auto i = 0; i < m_ThreadCount; i++)
  {
    const char* val = std::to_string(i).c_str();
    input[val].recycle();
  }

  return raft::proceed;
}

////////////////////////////////////////////////////////////////////////////////

AdvancedAccumulatorKernel::AdvancedAccumulatorKernel(int threadCount)
  : raft::kernel_all(), m_ThreadCount(threadCount)
{
  // Add our worker IO ports
  for (auto i = 0; i < m_ThreadCount; i++)
  {
    const char* val = std::to_string(i).c_str();
    input.addPort<int>(val);
    output.addPort<int>(val);
  }

  // Input from our modification kernel
  input.addPort<int>("input_mod");
}

raft::kstatus AdvancedAccumulatorKernel::run()
{
  // If the modification kernel returned false, something definitely went wrong
  if (!input["input_mod"].peek<int>())
  {
    std::cerr << "ERROR: AdvancedAccumulatorKernel got false output from modification kernel!" << std::endl;
    exit(EXIT_FAILURE);
  }

  input["input_mod"].recycle();

  // Pass through the TIDs
  for (auto i = 0; i < m_ThreadCount; i++)
  {
    const char* val = std::to_string(i).c_str();
    output[val].push<int>(i);
    input[val].recycle();
  }

  return raft::proceed;
}

////////////////////////////////////////////////////////////////////////////////

void ClearParticlesMT(int tid)
{
  for(int iz = grids[tid].sz; iz < grids[tid].ez; ++iz)
    for(int iy = grids[tid].sy; iy < grids[tid].ey; ++iy)
      for(int ix = grids[tid].sx; ix < grids[tid].ex; ++ix)
      {
        int index = (iz*ny + iy)*nx + ix;
        cnumPars[index] = 0;
		    cells[index].next = NULL;
        last_cells[index] = &cells[index];
      }
}

ClearParticlesMTWorker::ClearParticlesMTWorker()
  : raft::kernel()
{
  // Create our input port (tid)
  input.addPort<int>("input");

  // Create the output port (tid)
  output.addPort<int>("output");
}

raft::kstatus ClearParticlesMTWorker::run()
{
  // Get the tid
  int tid = input["input"].peek<int>();
  
  // Perform operation
  ClearParticlesMT(tid);

  // Push output and cleanup
  output["output"].push<int>(tid);
  input["input"].recycle();

  return raft::proceed;
}

////////////////////////////////////////////////////////////////////////////////

#ifdef USE_MUTEX

RebuildGridMTWorker::RebuildGridMTWorker()
  : raft::kernel()
{
  // Create our input port (tid)
  input.addPort<int>("input");

  // Create the output port (tid)
  output.addPort<int>("output");

  // Create an output port for modifying cell values in a thread-safe way
  //output.addPort<CellModificationInfo>("output_cell");
}

raft::kstatus RebuildGridMTWorker::run()
{
  int tid = input["input"].peek<int>();

  //iterate through source cell lists
  for(int iz = grids[tid].sz; iz < grids[tid].ez; ++iz)
    for(int iy = grids[tid].sy; iy < grids[tid].ey; ++iy)
      for(int ix = grids[tid].sx; ix < grids[tid].ex; ++ix)
      {
        int index2 = (iz*ny + iy)*nx + ix;
        Cell *cell2 = &cells2[index2];
        int np2 = cnumPars2[index2];
        //iterate through source particles
        
        for(int j = 0; j < np2; ++j)
        {
          //get destination for source particle
          int ci = (int)((cell2->p[j % PARTICLES_PER_CELL].x - domainMin.x) / delta.x);
          int cj = (int)((cell2->p[j % PARTICLES_PER_CELL].y - domainMin.y) / delta.y);
          int ck = (int)((cell2->p[j % PARTICLES_PER_CELL].z - domainMin.z) / delta.z);

          if(ci < 0) ci = 0; else if(ci > (nx-1)) ci = nx-1;
          if(cj < 0) cj = 0; else if(cj > (ny-1)) cj = ny-1;
          if(ck < 0) ck = 0; else if(ck > (nz-1)) ck = nz-1;
          #ifdef ENABLE_CFL_CHECK
          //check that source cell is a neighbor of destination cell
          bool cfl_cond_satisfied=false;
          for(int di = -1; di <= 1; ++di)
            for(int dj = -1; dj <= 1; ++dj)
              for(int dk = -1; dk <= 1; ++dk)
              {
                int ii = ci + di;
                int jj = cj + dj;
                int kk = ck + dk;
                if(ii >= 0 && ii < nx && jj >= 0 && jj < ny && kk >= 0 && kk < nz)
                {
                  int index = (kk*ny + jj)*nx + ii;
                  if(index == index2)
                  {
                    cfl_cond_satisfied=true;
                    break;
                  }
                }
              }
          if(!cfl_cond_satisfied)
          {
            std::cerr << "FATAL ERROR: Courant–Friedrichs–Lewy condition not satisfied." << std::endl;
            exit(1);
          }
          #endif //ENABLE_CFL_CHECK

          int index = (ck*ny + cj)*nx + ci;
          // this assumes that particles cannot travel more than one grid cell per time step

          // Make call to modify cell in other kernel instead of here to avoid lock
          //output["output_cell"].push<CellModificationInfo>(CellModificationInfo(cell2, index, j, SynchronizeKernelData(tid, false)));

          if (border[index])
            pthread_mutex_lock(&mutex[index][CELL_MUTEX_ID]);

          Cell *cell = last_cells[index];
          int np = cnumPars[index];

          if ( (np % PARTICLES_PER_CELL == 0) && (cnumPars[index] != 0) )
          {
            cell->next = cellpool_getcell(&pools[tid]);
            cell = cell->next;
            last_cells[index] = cell;
          }

          ++cnumPars[index];

          if (border[index])
            pthread_mutex_unlock(&mutex[index][CELL_MUTEX_ID]);

          //copy source to destination particle
              
          cell->p[np % PARTICLES_PER_CELL]  = cell2->p[j % PARTICLES_PER_CELL];
          cell->hv[np % PARTICLES_PER_CELL] = cell2->hv[j % PARTICLES_PER_CELL];
          cell->v[np % PARTICLES_PER_CELL]  = cell2->v[j % PARTICLES_PER_CELL];

          //move pointer to next source cell in list if end of array is reached
          if(j % PARTICLES_PER_CELL == PARTICLES_PER_CELL-1) {
            Cell *temp = cell2;
            cell2 = cell2->next;
            //return cells to pool that are not statically allocated head of lists
            if(temp != &cells2[index2]) {
              //NOTE: This is thread-safe because temp and pool are thread-private, no need to synchronize
              cellpool_returncell(&pools[tid], temp);
            }
          }
        } // for(int j = 0; j < np2; ++j)
        //return cells to pool that are not statically allocated head of lists
        if((cell2 != NULL) && (cell2 != &cells2[index2])) 
          cellpool_returncell(&pools[tid], cell2);
      }
  // Tell the cell mod kernel that we're done with our work
  //output["output_cell"].push<CellModificationInfo>(CellModificationInfo(nullptr, -1, -1, SynchronizeKernelData(tid, true)));
  
  // Push our output and cleanup
  output["output"].push<int>(tid);
  input["input"].recycle();

  return raft::proceed;
}

#else

RebuildGridMTWorker1::RebuildGridMTWorker1()
  : raft::kernel(), iz(0), iy(0), ix(0), index2(0), np2(0), j(0), firstTime(true)
{
  // Create our input port (tid)
  input.addPort<int>("input_tid");

  input.addPort<int>("input_continue");

  output.addPort<CellModificationInfo>("output_cell");

  output.addPort<int>("output_tid");
}

raft::kstatus RebuildGridMTWorker1::run()
{
  bool firstTime = false;
  if (input["input_tid"].size() > 0)
  {
    tid = input["input_tid"].peek<int>();
    input["input_tid"].recycle();

    index2 = (iz*ny + iy)*nx + ix;
    cell2 = &cells2[index2];
    np2 = cnumPars2[index2];
    firstTime = true;
  }

  if (iz < grids[tid].ez)
  {
    if (j >= np2)
    {
      //return cells to pool that are not statically allocated head of lists
      if((cell2 != NULL) && (cell2 != &cells2[index2])) 
        cellpool_returncell(&pools[tid], cell2);

      index2 = (iz*ny + iy)*nx + ix;
      cell2 = &cells2[index2];
      np2 = cnumPars2[index2];
    }

    int ci = (int)((cell2->p[j % PARTICLES_PER_CELL].x - domainMin.x) / delta.x);
    int cj = (int)((cell2->p[j % PARTICLES_PER_CELL].y - domainMin.y) / delta.y);
    int ck = (int)((cell2->p[j % PARTICLES_PER_CELL].z - domainMin.z) / delta.z);

    if(ci < 0) ci = 0; else if(ci > (nx-1)) ci = nx-1;
    if(cj < 0) cj = 0; else if(cj > (ny-1)) cj = ny-1;
    if(ck < 0) ck = 0; else if(ck > (nz-1)) ck = nz-1;

    int index = (ck*ny + cj)*nx + ci;

    // Push output
    output["output_cell"].push<CellModificationInfo>(CellModificationInfo(cell2, index, index2, j, SynchronizeKernelData(tid, false)));

    j++;
    if (j >= np2)
    {
      ix++;
      j = 0;
    }
    if (ix >= grids[tid].ex)
    {
      iy++;
      ix = 0;
    }
    if (iy >= grids[tid].ey)
    {
      iz++;
      iy = 0;
    }

    if (!firstTime)
      input["input_continue"].recycle();

    return raft::proceed;
  }
  else
  {
    input["input_continue"].recycle();

    // Tell the cell mod kernel that we're done with our work
    output["output_cell"].push<CellModificationInfo>(CellModificationInfo(nullptr, -1, -1, -1, SynchronizeKernelData(tid, true)));

    // Continue on
    output["output_tid"].push<int>(tid);

    return raft::stop;
  }
}

CellModificationKernel::CellModificationKernel(int threadCount)
  : raft::kernel(), m_ThreadCount(threadCount)
{
  // Add IO ports
  for (auto i = 0; i < m_ThreadCount; i++)
  {
    const char* val = std::to_string(i).c_str();
    input.addPort<CellModificationInfo>(val);
    output.addPort<CellModificationInfo>(val);

  }
  m_Done = new bool[m_ThreadCount];

  for (auto i = 0; i < m_ThreadCount; i++)
    m_Done[i] = 0;
}

CellModificationKernel::~CellModificationKernel()
{
  delete[] m_Done;
}

raft::kstatus CellModificationKernel::run()
{
  // Check each port for new data
  //for (auto &port : input)
  //{
  for (auto i = 0; i < m_ThreadCount; i++)
  {
    const char* val = std::to_string(i).c_str();
    bool wasInput = false;
    CellModificationInfo data;
    // Loop will only run if port has size > 0
    for (size_t i = 0; i < input[val].size(); i++)
    {
      wasInput = true;
      CellModificationInfo inputData = input[val].peek<CellModificationInfo>();
      data.cell2 = inputData.cell2;
      data.index = inputData.index;
      data.index2 = inputData.index2;
      data.j = inputData.j;
      data.kernelData.tid = inputData.kernelData.tid;
      data.kernelData.done = inputData.kernelData.done;
      
      // If the kernel has already sent that it is finished
      if (m_Done[inputData.kernelData.tid])
      {
        std::cerr << "ERROR: RebuildGridMTWorker " << inputData.kernelData.tid << " already marked as completed!" << std::endl;
        exit(EXIT_FAILURE);
      }

      // If the kernel is sending word that it is finished
      if (inputData.kernelData.done)
      {
        m_Done[inputData.kernelData.tid] = true;
        input[val].recycle(1);
        continue;
      }
      
      // Perform the cell set operation
      Cell *cell = last_cells[inputData.index];
      int np = cnumPars[inputData.index];

      //add another cell structure if everything full
      if( (np % PARTICLES_PER_CELL == 0) && (cnumPars[inputData.index] != 0) ) {
        cell->next = cellpool_getcell(&pools[inputData.kernelData.tid]);
        cell = cell->next;
        last_cells[inputData.index] = cell;
      }
      ++cnumPars[inputData.index];

      //copy source to destination particle
          
      cell->p[np % PARTICLES_PER_CELL]  = inputData.cell2->p[inputData.j % PARTICLES_PER_CELL];
      cell->hv[np % PARTICLES_PER_CELL] = inputData.cell2->hv[inputData.j % PARTICLES_PER_CELL];
      cell->v[np % PARTICLES_PER_CELL]  = inputData.cell2->v[inputData.j % PARTICLES_PER_CELL];

      input[val].recycle(1);
    }

    if (wasInput)
      output[val].push<CellModificationInfo>(data);
  }

  bool done = true;
  for (auto i = 0; i < m_ThreadCount; i++)
    if (!(m_Done[i]))
      done = false;

  if (done)
    return raft::stop;

  return raft::proceed;
}

RebuildGridMTWorker2::RebuildGridMTWorker2()
  : raft::kernel()
{
  // Create our input port (tid)
  input.addPort<CellModificationInfo>("input");

  // Create the output port (tid)
  output.addPort<double>("output");
}

raft::kstatus RebuildGridMTWorker2::run()
{
  CellModificationInfo inputData = input["input"].peek<CellModificationInfo>();

  if (inputData.kernelData.done)
    return raft::proceed;

  //move pointer to next source cell in list if end of array is reached
  if(inputData.j % PARTICLES_PER_CELL == PARTICLES_PER_CELL-1) {
    Cell *temp = inputData.cell2;
    inputData.cell2 = inputData.cell2->next;
    //return cells to pool that are not statically allocated head of lists
    if(temp != &cells2[inputData.index2]) {
      //NOTE: This is thread-safe because temp and pool are thread-private, no need to synchronize
      cellpool_returncell(&pools[inputData.kernelData.tid], temp);
    }
  }

  input["input"].recycle();
  output["output"].push<int>(inputData.kernelData.tid);

  return raft::proceed;
}

#endif

////////////////////////////////////////////////////////////////////////////////

int InitNeighCellList(int ci, int cj, int ck, int *neighCells)
{
  int numNeighCells = 0;

  // have the nearest particles first -> help branch prediction
  int my_index = (ck*ny + cj)*nx + ci;
  neighCells[numNeighCells] = my_index;
  ++numNeighCells;
 
  for(int di = -1; di <= 1; ++di)
    for(int dj = -1; dj <= 1; ++dj)
      for(int dk = -1; dk <= 1; ++dk)
      {
        int ii = ci + di;
        int jj = cj + dj;
        int kk = ck + dk;
        if(ii >= 0 && ii < nx && jj >= 0 && jj < ny && kk >= 0 && kk < nz)
        {
          int index = (kk*ny + jj)*nx + ii;
          if((index < my_index) && (cnumPars[index] != 0))
          {
            neighCells[numNeighCells] = index;
            ++numNeighCells;
          }
        }
      }
  return numNeighCells;
}

////////////////////////////////////////////////////////////////////////////////

void InitDensitiesAndForcesMT(int tid)
{
  for(int iz = grids[tid].sz; iz < grids[tid].ez; ++iz)
    for(int iy = grids[tid].sy; iy < grids[tid].ey; ++iy)
      for(int ix = grids[tid].sx; ix < grids[tid].ex; ++ix)
      {
        int index = (iz*ny + iy)*nx + ix;
        Cell *cell = &cells[index];
        int np = cnumPars[index];
        for(int j = 0; j < np; ++j)
        {
          cell->density[j % PARTICLES_PER_CELL] = 0.0;
          cell->a[j % PARTICLES_PER_CELL] = externalAcceleration;
          //move pointer to next cell in list if end of array is reached
          if(j % PARTICLES_PER_CELL == PARTICLES_PER_CELL-1) {
            cell = cell->next;
          }
        }
      }
}

InitDensitiesAndForcesMTWorker::InitDensitiesAndForcesMTWorker()
  : raft::kernel()
{
  // Create our input port (tid)
  input.addPort<int>("input");

  // Create the output port (tid)
  output.addPort<int>("output");
}

raft::kstatus InitDensitiesAndForcesMTWorker::run()
{
  // Get the tid
  int tid = input["input"].peek<int>();
  
  // Perform operation
  InitDensitiesAndForcesMT(tid);

  // Push output and cleanup
  output["output"].push<int>(tid);
  input["input"].recycle();

  return raft::proceed;
}

////////////////////////////////////////////////////////////////////////////////

ComputeDensitiesMTWorker::ComputeDensitiesMTWorker()
  : raft::kernel()
{
  // Create our input port (tid)
  input.addPort<int>("input");

  // Create the output port (tid)
  output.addPort<int>("output_tid");

  // Create an output port for modifying density values in a thread-safe way
  output.addPort<DensityModificationInfo>("output_density");
}

raft::kstatus ComputeDensitiesMTWorker::run()
{
  int tid = input["input"].peek<int>();

  int neighCells[3*3*3];

  for(int iz = grids[tid].sz; iz < grids[tid].ez; ++iz)
    for(int iy = grids[tid].sy; iy < grids[tid].ey; ++iy)
      for(int ix = grids[tid].sx; ix < grids[tid].ex; ++ix)
      {
        int index = (iz*ny + iy)*nx + ix;
        int np = cnumPars[index];
        if(np == 0)
          continue;

        int numNeighCells = InitNeighCellList(ix, iy, iz, neighCells);

        Cell *cell = &cells[index];
        for(int ipar = 0; ipar < np; ++ipar)
        {
          for(int inc = 0; inc < numNeighCells; ++inc)
          {
            int indexNeigh = neighCells[inc];
            Cell *neigh = &cells[indexNeigh];
            int numNeighPars = cnumPars[indexNeigh];
            for(int iparNeigh = 0; iparNeigh < numNeighPars; ++iparNeigh)
            {
              //Check address to make sure densities are computed only once per pair
              if(&neigh->p[iparNeigh % PARTICLES_PER_CELL] < &cell->p[ipar % PARTICLES_PER_CELL])
              {
                fptype distSq = (cell->p[ipar % PARTICLES_PER_CELL] - neigh->p[iparNeigh % PARTICLES_PER_CELL]).GetLengthSq();
                if(distSq < hSq)
                {
                  fptype t = hSq - distSq;
                  fptype tc = t*t*t;

                  // Instead of using locks, we will use another kernel to handle all density modifications
                  output["output_density"].push<DensityModificationInfo>(DensityModificationInfo(cell, ipar % PARTICLES_PER_CELL, tc, SynchronizeKernelData(tid, false)));
                  output["output_density"].push<DensityModificationInfo>(DensityModificationInfo(neigh, iparNeigh % PARTICLES_PER_CELL, tc, SynchronizeKernelData(tid, false)));

                }
              }
              //move pointer to next cell in list if end of array is reached
              if(iparNeigh % PARTICLES_PER_CELL == PARTICLES_PER_CELL-1) {
                neigh = neigh->next;
              }
            }
          }
          //move pointer to next cell in list if end of array is reached
          if(ipar % PARTICLES_PER_CELL == PARTICLES_PER_CELL-1) {
            cell = cell->next;
          }
        }
      }

  // Tell the density mod kernel that we're done with our work
  output["output_density"].push<DensityModificationInfo>(DensityModificationInfo(nullptr, -1, 0, SynchronizeKernelData(tid, true)));
  
  // Push our output and cleanup
  output["output_tid"].push<int>(tid);
  input["input"].recycle();

  return raft::proceed;
}

DensityModificationKernel::DensityModificationKernel(int threadCount)
  : raft::kernel(), m_ThreadCount(threadCount)
{
  // The output port which will notify the next kernel that this is finished.
  output.addPort<int>("output");

  // Add input ports
  for (auto i = 0; i < m_ThreadCount; i++)
    input.addPort<DensityModificationInfo>(std::to_string(i).c_str());

  m_Done = new bool[m_ThreadCount];

  for (auto i = 0; i < m_ThreadCount; i++)
    m_Done[i] = 0;
}

DensityModificationKernel::~DensityModificationKernel()
{
  delete[] m_Done;
}

raft::kstatus DensityModificationKernel::run()
{
  // Check each port for new data
  //for (auto &port : input)
  //{
  for (auto i = 0; i < m_ThreadCount; i++)
  {
    const char* val = std::to_string(i).c_str();
    // Loop will only run if port has size > 0
    for (size_t i = 0; i < input[val].size(); i++)
    {
      DensityModificationInfo inputData = input[val].peek<DensityModificationInfo>();
      
      // If the kernel has already sent that it is finished
      if (m_Done[inputData.kernelData.tid])
      {
        std::cerr << "ERROR: ComputeDensitiesMTWorker " << inputData.kernelData.tid << " already marked as completed!" << std::endl;
        exit(EXIT_FAILURE);
      }

      // If the kernel is sending word that it is finished
      if (inputData.kernelData.done)
      {
        m_Done[inputData.kernelData.tid] = true;
        input[val].recycle(1);
        continue;
      }
      
      // Perform the density set operation
      inputData.cell->density[inputData.index] += inputData.tc;
      input[val].recycle(1);
    }
  }

  // If all the ports are marked as done, we're finished with this kernel.
  bool done = true;
  for (auto i = 0; i < m_ThreadCount; i++)
    if (!(m_Done[i]))
      done = false;

  if (done)
    output["output"].push<int>(true);

  return raft::proceed;
}

////////////////////////////////////////////////////////////////////////////////

void ComputeDensities2MT(int tid)
{
  const fptype tc = hSq*hSq*hSq;
  for(int iz = grids[tid].sz; iz < grids[tid].ez; ++iz)
    for(int iy = grids[tid].sy; iy < grids[tid].ey; ++iy)
      for(int ix = grids[tid].sx; ix < grids[tid].ex; ++ix)
      {
        int index = (iz*ny + iy)*nx + ix;
        Cell *cell = &cells[index];
        int np = cnumPars[index];
        for(int j = 0; j < np; ++j)
        {
          cell->density[j % PARTICLES_PER_CELL] += tc;
          cell->density[j % PARTICLES_PER_CELL] *= densityCoeff;
          //move pointer to next cell in list if end of array is reached
          if(j % PARTICLES_PER_CELL == PARTICLES_PER_CELL-1) {
            cell = cell->next;
          }
        }
      }
}

ComputeDensities2MTWorker::ComputeDensities2MTWorker()
  : raft::kernel()
{
  // Create our input port (tid)
  input.addPort<int>("input");

  // Create the output port (tid)
  output.addPort<int>("output");
}

raft::kstatus ComputeDensities2MTWorker::run()
{
  // Get the tid
  int tid = input["input"].peek<int>();
  
  // Perform operation
  ComputeDensities2MT(tid);

  // Push output and cleanup
  output["output"].push<int>(tid);
  input["input"].recycle();

  return raft::proceed;
}


////////////////////////////////////////////////////////////////////////////////

ComputeForcesMTWorker::ComputeForcesMTWorker()
  : raft::kernel()
{
  // Create our input port (tid)
  input.addPort<int>("input");

  // Create the output port (tid)
  output.addPort<int>("output_tid");

  // Create an output port for modifying acceleration values in a thread-safe way
  output.addPort<AccelerationModificationInfo>("output_acceleration");
}

raft::kstatus ComputeForcesMTWorker::run()
{
  int tid = input["input"].peek<int>();

  int neighCells[3*3*3];

  for(int iz = grids[tid].sz; iz < grids[tid].ez; ++iz)
    for(int iy = grids[tid].sy; iy < grids[tid].ey; ++iy)
      for(int ix = grids[tid].sx; ix < grids[tid].ex; ++ix)
      {
        int index = (iz*ny + iy)*nx + ix;
        int np = cnumPars[index];
        if(np == 0)
          continue;

        //int numNeighCells = InitNeighCellList(ix, iy, iz, neighCells);
        int numNeighCells = 0;

        Cell *cell = &cells[index];
        for(int ipar = 0; ipar < np; ++ipar)
        {
          for(int inc = 0; inc < numNeighCells; ++inc)
          {
            int indexNeigh = neighCells[inc];
            Cell *neigh = &cells[indexNeigh];
            int numNeighPars = cnumPars[indexNeigh];
            for(int iparNeigh = 0; iparNeigh < numNeighPars; ++iparNeigh)
            {
              //Check address to make sure forces are computed only once per pair
              if(&neigh->p[iparNeigh % PARTICLES_PER_CELL] < &cell->p[ipar % PARTICLES_PER_CELL])
              {
                Vec3 disp = cell->p[ipar % PARTICLES_PER_CELL] - neigh->p[iparNeigh % PARTICLES_PER_CELL];
                fptype distSq = disp.GetLengthSq();
                if(distSq < hSq)
                {
                  #ifndef ENABLE_DOUBLE_PRECISION
                  fptype dist = sqrtf(std::max(distSq, (fptype)1e-12));
                  #else
                  fptype dist = sqrt(std::max(distSq, 1e-12));
                  #endif //ENABLE_DOUBLE_PRECISION
                  fptype hmr = h - dist;

                  Vec3 acc = disp * pressureCoeff * (hmr*hmr/dist) * (cell->density[ipar % PARTICLES_PER_CELL]+neigh->density[iparNeigh % PARTICLES_PER_CELL] - doubleRestDensity);
                  acc += (neigh->v[iparNeigh % PARTICLES_PER_CELL] - cell->v[ipar % PARTICLES_PER_CELL]) * viscosityCoeff * hmr;
                  acc /= cell->density[ipar % PARTICLES_PER_CELL] * neigh->density[iparNeigh % PARTICLES_PER_CELL];

                  output["output_acceleration"].push<AccelerationModificationInfo>(AccelerationModificationInfo(cell, ipar % PARTICLES_PER_CELL, acc, SynchronizeKernelData(tid, false)));
                  output["output_acceleration"].push<AccelerationModificationInfo>(AccelerationModificationInfo(neigh, iparNeigh % PARTICLES_PER_CELL, -acc, SynchronizeKernelData(tid, false)));
                }
              }
              //move pointer to next cell in list if end of array is reached
              if(iparNeigh % PARTICLES_PER_CELL == PARTICLES_PER_CELL-1) {
                neigh = neigh->next;
              }
            }
          }
          //move pointer to next cell in list if end of array is reached
          if(ipar % PARTICLES_PER_CELL == PARTICLES_PER_CELL-1) {
            cell = cell->next;
          }
        }
      }

  // Tell the acceleration mod kernel that we're done with our work
  output["output_acceleration"].push<AccelerationModificationInfo>(AccelerationModificationInfo(nullptr, -1, Vec3(), SynchronizeKernelData(tid, true)));
  
  // Push our output and cleanup
  output["output_tid"].push<int>(tid);
  input["input"].recycle();

  return raft::proceed;
}

AccelerationModificationKernel::AccelerationModificationKernel(int threadCount)
  : raft::kernel(), m_ThreadCount(threadCount)
{
  // Add input ports
  for (auto i = 0; i < m_ThreadCount; i++)
    input.addPort<AccelerationModificationInfo>(std::to_string(i).c_str());

  // The output port which will notify the next kernel that this is finished.
  output.addPort<int>("output");

  m_Done = new bool[m_ThreadCount];

  for (auto i = 0; i < m_ThreadCount; i++)
    m_Done[i] = 0;
}

AccelerationModificationKernel::~AccelerationModificationKernel()
{
  delete[] m_Done;
}

raft::kstatus AccelerationModificationKernel::run()
{
  // Check each port for new data
  //for (auto &port : input)
  //{
  for (auto i = 0; i < m_ThreadCount; i++)
  {
    const char* val = std::to_string(i).c_str();
    // Loop will only run if port has size > 0
    for (size_t i = 0; i < input[val].size(); i++)
    {
      AccelerationModificationInfo inputData = input[val].peek<AccelerationModificationInfo>();
      
      // If the kernel has already sent that it is finished
      if (m_Done[inputData.kernelData.tid])
      {
        std::cerr << "ERROR: ComputeForcesMTWorker " << inputData.kernelData.tid << " already marked as completed!" << std::endl;
        exit(EXIT_FAILURE);
      }

      // If the kernel is sending word that it is finished
      if (inputData.kernelData.done)
      {
        m_Done[inputData.kernelData.tid] = true;
        input[val].recycle(1);
        continue;
      }
      
      // Perform the acceleration set operation
      inputData.cell->a[inputData.index] += inputData.acc;
      input[val].recycle(1);
    }
  }

  // If all the ports are marked as done, we're finished with this kernel.
  bool done = true;
  for (auto i = 0; i < m_ThreadCount; i++)
    if (!(m_Done[i]))
      done = false;

  if (done)
    output["output"].push<int>(true);

  return raft::proceed;
}


////////////////////////////////////////////////////////////////////////////////

// ProcessCollisions() with container walls
// Under the assumptions that
// a) a particle will not penetrate a wall
// b) a particle will not migrate further than once cell
// c) the parSize is smaller than a cell
// then only the particles at the perimiters may be influenced by the walls
#if 0
void ProcessCollisionsMT(int tid)
{
  for(int iz = grids[tid].sz; iz < grids[tid].ez; ++iz)
    for(int iy = grids[tid].sy; iy < grids[tid].ey; ++iy)
      for(int ix = grids[tid].sx; ix < grids[tid].ex; ++ix)
      {
        int index = (iz*ny + iy)*nx + ix;
        Cell *cell = &cells[index];
        int np = cnumPars[index];
        for(int j = 0; j < np; ++j)
        {
          Vec3 pos = cell->p[j % PARTICLES_PER_CELL] + cell->hv[j % PARTICLES_PER_CELL] * timeStep;

          fptype diff = parSize - (pos.x - domainMin.x);
          if(diff > epsilon)
            cell->a[j % PARTICLES_PER_CELL].x += stiffnessCollisions*diff - damping*cell->v[j % PARTICLES_PER_CELL].x;

          diff = parSize - (domainMax.x - pos.x);
          if(diff > epsilon)
            cell->a[j % PARTICLES_PER_CELL].x -= stiffnessCollisions*diff + damping*cell->v[j % PARTICLES_PER_CELL].x;

          diff = parSize - (pos.y - domainMin.y);
          if(diff > epsilon)
            cell->a[j % PARTICLES_PER_CELL].y += stiffnessCollisions*diff - damping*cell->v[j % PARTICLES_PER_CELL].y;

          diff = parSize - (domainMax.y - pos.y);
          if(diff > epsilon)
            cell->a[j % PARTICLES_PER_CELL].y -= stiffnessCollisions*diff + damping*cell->v[j % PARTICLES_PER_CELL].y;

          diff = parSize - (pos.z - domainMin.z);
          if(diff > epsilon)
            cell->a[j % PARTICLES_PER_CELL].z += stiffnessCollisions*diff - damping*cell->v[j % PARTICLES_PER_CELL].z;

          diff = parSize - (domainMax.z - pos.z);
          if(diff > epsilon)
            cell->a[j % PARTICLES_PER_CELL].z -= stiffnessCollisions*diff + damping*cell->v[j % PARTICLES_PER_CELL].z;

          //move pointer to next cell in list if end of array is reached
          if(j % PARTICLES_PER_CELL == PARTICLES_PER_CELL-1) {
            cell = cell->next;
          }
        }
      }
}
#else
void ProcessCollisionsMT(int tid)
{
  for(int iz = grids[tid].sz; iz < grids[tid].ez; ++iz)
  {
    for(int iy = grids[tid].sy; iy < grids[tid].ey; ++iy)
	{
      for(int ix = grids[tid].sx; ix < grids[tid].ex; ++ix)
      {
	    if(!((ix==0)||(iy==0)||(iz==0)||(ix==(nx-1))||(iy==(ny-1))==(iz==(nz-1))))
			continue;	// not on domain wall
        int index = (iz*ny + iy)*nx + ix;
        Cell *cell = &cells[index];
        int np = cnumPars[index];
        for(int j = 0; j < np; ++j)
        {
		  int ji = j % PARTICLES_PER_CELL;
          Vec3 pos = cell->p[ji] + cell->hv[ji] * timeStep;

		  if(ix==0)
		  {
            fptype diff = parSize - (pos.x - domainMin.x);
		    if(diff > epsilon)
              cell->a[ji].x += stiffnessCollisions*diff - damping*cell->v[ji].x;
		  }
		  if(ix==(nx-1))
		  {
            fptype diff = parSize - (domainMax.x - pos.x);
            if(diff > epsilon)
              cell->a[ji].x -= stiffnessCollisions*diff + damping*cell->v[ji].x;
		  }
		  if(iy==0)
		  {
            fptype diff = parSize - (pos.y - domainMin.y);
            if(diff > epsilon)
              cell->a[ji].y += stiffnessCollisions*diff - damping*cell->v[ji].y;
		  }
		  if(iy==(ny-1))
		  {
            fptype diff = parSize - (domainMax.y - pos.y);
            if(diff > epsilon)
              cell->a[ji].y -= stiffnessCollisions*diff + damping*cell->v[ji].y;
		  }
		  if(iz==0)
		  {
            fptype diff = parSize - (pos.z - domainMin.z);
            if(diff > epsilon)
              cell->a[ji].z += stiffnessCollisions*diff - damping*cell->v[ji].z;
		  }
		  if(iz==(nz-1))
		  {
            fptype diff = parSize - (domainMax.z - pos.z);
            if(diff > epsilon)
              cell->a[ji].z -= stiffnessCollisions*diff + damping*cell->v[ji].z;
		  }
          //move pointer to next cell in list if end of array is reached
          if(ji == PARTICLES_PER_CELL-1) {
            cell = cell->next;
          }
        }
      }
	}
  }
}
#endif

ProcessCollisionsMTWorker::ProcessCollisionsMTWorker()
  : raft::kernel()
{
  // Create our input port (tid)
  input.addPort<int>("input");

  // Create the output port (tid)
  output.addPort<int>("output");
}

raft::kstatus ProcessCollisionsMTWorker::run()
{
  // Get the tid
  int tid = input["input"].peek<int>();
  
  // Perform operation
  ProcessCollisionsMT(tid);

  // Push output and cleanup
  output["output"].push<int>(tid);
  input["input"].recycle();

  return raft::proceed;
}

#define USE_ImpeneratableWall
#if defined(USE_ImpeneratableWall)
void ProcessCollisions2MT(int tid)
{
  for(int iz = grids[tid].sz; iz < grids[tid].ez; ++iz)
  {
    for(int iy = grids[tid].sy; iy < grids[tid].ey; ++iy)
	{
      for(int ix = grids[tid].sx; ix < grids[tid].ex; ++ix)
      {
#if 0
// Chris, the following test should be valid
// *** provided that a particle does not migrate more than 1 cell
// *** per integration step. This does not appear to be the case
// *** in the pthreads version. Serial version it seems to be OK
	    if(!((ix==0)||(iy==0)||(iz==0)||(ix==(nx-1))||(iy==(ny-1))==(iz==(nz-1))))
			continue;	// not on domain wall
#endif
        int index = (iz*ny + iy)*nx + ix;
        Cell *cell = &cells[index];
        int np = cnumPars[index];
        for(int j = 0; j < np; ++j)
        {
		  int ji = j % PARTICLES_PER_CELL;
          Vec3 pos = cell->p[ji];

		  if(ix==0)
		  {
            fptype diff = pos.x - domainMin.x;
		    if(diff < Zero)
			{
				cell->p[ji].x = domainMin.x - diff;
				cell->v[ji].x = -cell->v[ji].x;
				cell->hv[ji].x = -cell->hv[ji].x;
			}
		  }
		  if(ix==(nx-1))
		  {
            fptype diff = domainMax.x - pos.x;
 			if(diff < Zero)
			{
				cell->p[ji].x = domainMax.x + diff;
				cell->v[ji].x = -cell->v[ji].x;
				cell->hv[ji].x = -cell->hv[ji].x;
			}
		  }
		  if(iy==0)
		  {
            fptype diff = pos.y - domainMin.y;
		    if(diff < Zero)
			{
				cell->p[ji].y = domainMin.y - diff;
				cell->v[ji].y = -cell->v[ji].y;
				cell->hv[ji].y = -cell->hv[ji].y;
			}
		  }
		  if(iy==(ny-1))
		  {
            fptype diff = domainMax.y - pos.y;
 			if(diff < Zero)
			{
				cell->p[ji].y = domainMax.y + diff;
				cell->v[ji].y = -cell->v[ji].y;
				cell->hv[ji].y = -cell->hv[ji].y;
			}
		  }
		  if(iz==0)
		  {
            fptype diff = pos.z - domainMin.z;
		    if(diff < Zero)
			{
				cell->p[ji].z = domainMin.z - diff;
				cell->v[ji].z = -cell->v[ji].z;
				cell->hv[ji].z = -cell->hv[ji].z;
			}
		  }
		  if(iz==(nz-1))
		  {
            fptype diff = domainMax.z - pos.z;
 			if(diff < Zero)
			{
				cell->p[ji].z = domainMax.z + diff;
				cell->v[ji].z = -cell->v[ji].z;
				cell->hv[ji].z = -cell->hv[ji].z;
			}
		  }
          //move pointer to next cell in list if end of array is reached
          if(ji == PARTICLES_PER_CELL-1) {
            cell = cell->next;
          }
        }
      }
	}
  }
}

ProcessCollisions2MTWorker::ProcessCollisions2MTWorker()
  : raft::kernel()
{
  // Create our input port (tid)
  input.addPort<int>("input");

  // Create the output port (tid)
  output.addPort<int>("output");
}

raft::kstatus ProcessCollisions2MTWorker::run()
{
  // Get the tid
  int tid = input["input"].peek<int>();
  
  // Perform operation
  ProcessCollisions2MT(tid);

  // Push output and cleanup
  output["output"].push<int>(tid);
  input["input"].recycle();

  return raft::proceed;
}

#endif

////////////////////////////////////////////////////////////////////////////////

void AdvanceParticlesMT(int tid)
{
  for(int iz = grids[tid].sz; iz < grids[tid].ez; ++iz)
    for(int iy = grids[tid].sy; iy < grids[tid].ey; ++iy)
      for(int ix = grids[tid].sx; ix < grids[tid].ex; ++ix)
      {
        int index = (iz*ny + iy)*nx + ix;
        Cell *cell = &cells[index];
        int np = cnumPars[index];
        for(int j = 0; j < np; ++j)
        {
          Vec3 v_half = cell->hv[j % PARTICLES_PER_CELL] + cell->a[j % PARTICLES_PER_CELL]*timeStep;
#if defined(USE_ImpeneratableWall)
		// N.B. The integration of the position can place the particle
		// outside the domain. Although we could place a test in this loop
		// we would be unnecessarily testing particles on interior cells.
		// Therefore, to reduce the amount of computations we make a later
		// pass on the perimiter cells to account for particle migration
		// beyond domain
#endif
          cell->p[j % PARTICLES_PER_CELL] += v_half * timeStep;
          cell->v[j % PARTICLES_PER_CELL] = cell->hv[j % PARTICLES_PER_CELL] + v_half;
          cell->v[j % PARTICLES_PER_CELL] *= 0.5;
          cell->hv[j % PARTICLES_PER_CELL] = v_half;
  	  
         
          //move pointer to next cell in list if end of array is reached
          if(j % PARTICLES_PER_CELL == PARTICLES_PER_CELL-1) {
            cell = cell->next;
          }
        }
      }
}

AdvanceParticlesMTWorker::AdvanceParticlesMTWorker()
  : raft::kernel()
{
  // Create our input port (tid)
  input.addPort<int>("input");

  // Create the output port (tid)
  output.addPort<int>("output");
}

raft::kstatus AdvanceParticlesMTWorker::run()
{
  // Get the tid
  int tid = input["input"].peek<int>();
  
  // Perform operation
  AdvanceParticlesMT(tid);

  // Push output and cleanup
  output["output"].push<int>(tid);
  input["input"].recycle();

  return raft::proceed;
}


////////////////////////////////////////////////////////////////////////////////

void AdvanceFrameMT(int threadnum)
{
  //std::cout << "Advancing frame" << std::endl;
  std::swap(cells, cells2);
  std::swap(cnumPars, cnumPars2);

  // Kernel Initialization
  SimpleProducerKernel simpleProducer(threadnum);
  ClearParticlesMTWorker* clearParticlesMTWorkers[MAX_THREADS];
  SimpleAccumulatorKernel simpleAccum1(threadnum);
  SimpleAccumulatorKernel simpleAccumRebuild(threadnum);
  #ifndef USE_MUTEX
  CellModificationKernel cellModificationKernel(threadnum);
  RebuildGridMTWorker1 rebuildGridMTWorker1s[MAX_THREADS];
  RebuildGridMTWorker2 rebuildGridMTWorker2s[MAX_THREADS];
  #else
  RebuildGridMTWorker* rebuildGridMTWorkers[MAX_THREADS];
  #endif
  InitDensitiesAndForcesMTWorker* initDensitiesAndForcesMTWorkers[MAX_THREADS];
  SimpleAccumulatorKernel simpleAccum2(threadnum);
  ComputeDensitiesMTWorker* computeDensitiesMTWorkers[MAX_THREADS];
  DensityModificationKernel densityModificationKernel(threadnum);
  AdvancedAccumulatorKernel advancedAccum2(threadnum);
  ComputeDensities2MTWorker* computeDensities2MTWorkers[MAX_THREADS];
  SimpleAccumulatorKernel simpleAccum3(threadnum);
  ComputeForcesMTWorker* computeForcesMTWorkers[MAX_THREADS];
  AccelerationModificationKernel accelerationModificationKernel(threadnum);
  AdvancedAccumulatorKernel advancedAccum3(threadnum);
  ProcessCollisionsMTWorker* processCollisionsMTWorkers[MAX_THREADS];
  SimpleAccumulatorKernel simpleAccum4(threadnum);
  AdvanceParticlesMTWorker* advanceParticlesMTWorkers[MAX_THREADS];
  SimpleAccumulatorKernel simpleAccum5(threadnum);
  ProcessCollisions2MTWorker* processCollisions2MTWorkers[MAX_THREADS];
  SimpleConsumerKernel simpleConsumer(threadnum);

  raft::map m;

  m += densityModificationKernel >> advancedAccum2["input_mod"];
  m += accelerationModificationKernel >> advancedAccum3["input_mod"];

  
  for (auto i = 0; i < threadnum; i++)
  {
    clearParticlesMTWorkers[i] = new ClearParticlesMTWorker();
    #ifndef USE_MUTEX
    rebuildGridMTWorker1s[i] = new RebuildGridMTWorker1();
    rebuildGridMTWorker2s[i] = new RebuildGridMTWorker2();
    #else
    rebuildGridMTWorkers[i] = new RebuildGridMTWorker();
    #endif
    initDensitiesAndForcesMTWorkers[i] = new InitDensitiesAndForcesMTWorker();
    computeDensitiesMTWorkers[i] = new ComputeDensitiesMTWorker();
    computeDensities2MTWorkers[i] = new ComputeDensities2MTWorker();
    computeForcesMTWorkers[i] = new ComputeForcesMTWorker();
    processCollisionsMTWorkers[i] = new ProcessCollisionsMTWorker();
    processCollisions2MTWorkers[i] = new ProcessCollisions2MTWorker();
    advanceParticlesMTWorkers[i] = new AdvanceParticlesMTWorker();
  }
  

  // Map construction
  for (auto i = 0; i < threadnum; i++)
  {
    const char* val = std::to_string(i).c_str();
    m += simpleProducer[val] >> *(clearParticlesMTWorkers[i]);
    m += *(clearParticlesMTWorkers[i]) >> simpleAccum1[val];
    #ifdef USE_MUTEX
    m += simpleAccum1[val] >> *(rebuildGridMTWorkers[i]);
    m += *(rebuildGridMTWorkers[i]) >> simpleAccumRebuild[val];
    #else
    m += rebuildGridMTWorker2s[i] >> rebuildGridMTWorker1s[i]["input_continue"];
    m += simpleAccum1[val] >> rebuildGridMTWorker1s[i]["input_tid"];
    m += rebuildGridMTWorker1s[i]["output_tid"] >> simpleAccumRebuild[val];
    m += rebuildGridMTWorker1s[i]["output_cell"] >> cellModificationKernel[val];
    m += cellModificationKernel[val] >> rebuildGridMTWorker2s[i];
    #endif
    m += simpleAccumRebuild[val] >> *(initDensitiesAndForcesMTWorkers[i]);
    m += *(initDensitiesAndForcesMTWorkers[i]) >> simpleAccum2[val];
    m += simpleAccum2[val] >> *(computeDensitiesMTWorkers[i]);
    m += (*(computeDensitiesMTWorkers[i]))["output_tid"] >> advancedAccum2[val];
    m += (*(computeDensitiesMTWorkers[i]))["output_density"] >> densityModificationKernel[val];
    m += advancedAccum2[val] >> *(computeDensities2MTWorkers[i]);
    m += *(computeDensities2MTWorkers[i]) >> simpleAccum3[val];
    m += simpleAccum3[val] >> *(computeForcesMTWorkers[i]);
    m += (*(computeForcesMTWorkers[i]))["output_tid"] >> advancedAccum3[val];
    m += (*(computeForcesMTWorkers[i]))["output_acceleration"] >> accelerationModificationKernel[val];
    m += advancedAccum3[val] >> *(processCollisionsMTWorkers[i]);
    m += *(processCollisionsMTWorkers[i]) >> simpleAccum4[val];
    m += simpleAccum4[val] >> *(advanceParticlesMTWorkers[i]);
    m += *(advanceParticlesMTWorkers[i]) >> simpleAccum5[val];
    m += simpleAccum5[val] >> *(processCollisions2MTWorkers[i]);
    m += *(processCollisions2MTWorkers[i]) >> simpleConsumer[val];
  }

  // Execute the kernel
  m.exe();
  
  for (auto i = 0; i < threadnum; i++)
  {
    delete clearParticlesMTWorkers[i];
    #ifndef USE_MUTEX
    delete rebuildGridMTWorker1s[i];
    delete rebuildGridMTWorker2s[i];
    #else
    delete rebuildGridMTWorkers[i];
    #endif
    delete initDensitiesAndForcesMTWorkers[i];
    delete computeDensitiesMTWorkers[i];
    delete computeDensities2MTWorkers[i];
    delete computeForcesMTWorkers[i];
    delete processCollisionsMTWorkers[i];
    delete advanceParticlesMTWorkers[i];
    delete processCollisions2MTWorkers[i];
  }
}

void AdvanceFramesMT(int framenum, int threadnum)
{
  for (auto i = 0; i < framenum; i++)
    AdvanceFrameMT(threadnum);
}

////////////////////////////////////////////////////////////////////////////////

int fluidanimate(int argc, char *argv[])
{
  if(argc < 4 || argc >= 6)
  {
    std::cout << "Usage: " << argv[0] << " <threadnum> <framenum> <.fluid input file> [.fluid output file]" << std::endl;
    return -1;
  }

  int threadnum = atoi(argv[1]);
  int framenum = atoi(argv[2]);

  //Check arguments
  if(threadnum < 1) {
    std::cerr << "<threadnum> must at least be 1" << std::endl;
    return -1;
  }
  if(framenum < 1) {
    std::cerr << "<framenum> must at least be 1" << std::endl;
    return -1;
  }

#ifdef ENABLE_CFL_CHECK
  std::cout << "WARNING: Check for Courant–Friedrichs–Lewy condition enabled. Do not use for performance measurements." << std::endl;
#endif

  InitSim(argv[3], threadnum);
#ifdef ENABLE_VISUALIZATION
  InitVisualizationMode(&argc, argv, &AdvanceFrameMT, &numCells, &cells, &cnumPars);
#endif

// *** PARALLEL PHASE *** //
#ifndef ENABLE_VISUALIZATION
  AdvanceFramesMT(framenum, threadnum);
#else
  Visualize();
#endif

  if(argc > 4)
    SaveFile(argv[4]);
  CleanUpSim();

  std::cout << "Fluidanimate complete!" << std::endl;

  return EXIT_SUCCESS;
}

////////////////////////////////////////////////////////////////////////////////
