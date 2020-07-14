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
#include <raft>




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

struct pkmedian_arg_t
{
  Points* points;
  long kmin;
  long kmax;
  long* kfinal;
  int pid;
  pthread_barrier_t* barrier;
};

struct PStreamReader_Output
{
  size_t numRead;
  size_t offset;
  unsigned int pointsIndex;

  PStreamReader_Output() : numRead(0), offset(0), pointsIndex(0) {}

  PStreamReader_Output(size_t numRead, size_t offset, unsigned int pointsIndex) : numRead(numRead), offset(offset), pointsIndex(pointsIndex) {}
};

struct LocalSearchStarter_Output
{
  size_t numRead;
  size_t offset;
  size_t blockSize;
  unsigned int pointsIndex;
  unsigned int id;

  LocalSearchStarter_Output() : numRead(0), offset(0), blockSize(0), pointsIndex(0), id(0) {}

  LocalSearchStarter_Output(size_t numRead, size_t offset, size_t blockSize, unsigned int pointsIndex, unsigned int id) 
    : numRead(numRead), offset(offset), blockSize(blockSize), pointsIndex(pointsIndex), id(id) {}
};

struct PKMedianPt1_Output
{
  size_t numRead;
  size_t offset;
  size_t blockSize;
  unsigned int pointsIndex;
  unsigned int id;
  double hiz;
  bool skip;

  PKMedianPt1_Output() : numRead(0), offset(0), blockSize(0), pointsIndex(0), id(0), hiz(0.0), skip(false) {}
  
  PKMedianPt1_Output(size_t numRead, size_t offset, size_t blockSize, unsigned int pointsIndex, unsigned int id, double hiz, bool skip = false) 
    : numRead(numRead), offset(offset), blockSize(blockSize), pointsIndex(pointsIndex), id(id), hiz(hiz), skip(skip) {}
};

struct PKMedianPt2_Output
{
  size_t numRead;
  size_t offset;
  size_t blockSize;
  unsigned int pointsIndex;
  unsigned int id;
  bool* openCenters;
  double z;
  bool skip;

  PKMedianPt2_Output() : numRead(0), offset(0), blockSize(0), pointsIndex(0), id(0), openCenters(nullptr), z(0.0), skip(false) {}

  PKMedianPt2_Output(size_t numRead, size_t offset, size_t blockSize, unsigned int pointsIndex, unsigned int id, bool* openCenters, double z, bool skip = false) 
    : numRead(numRead), offset(offset), blockSize(blockSize), pointsIndex(pointsIndex), id(id), openCenters(openCenters), skip(skip), z(z) {}
};

struct PSpeedyKernel_Output
{
  size_t numRead;
  size_t offset;
  size_t blockSize;
  unsigned int pointsIndex;
  bool* openCenters;
  double z;
  double cost;
  bool skip;

  PSpeedyKernel_Output() : numRead(0), offset(0), blockSize(0), pointsIndex(0), openCenters(nullptr), z(0.0), cost(0.0), skip(false) {}

  PSpeedyKernel_Output(size_t numRead, size_t offset, size_t blockSize, unsigned int pointsIndex, bool* openCenters, double z, double cost, bool skip = false) 
    : numRead(numRead), offset(offset), blockSize(blockSize), pointsIndex(pointsIndex), openCenters(openCenters), z(z), cost(cost), skip(skip) {}
};

struct PSpeedySum_Output
{
  size_t numRead;
  size_t offset;
  size_t blockSize;
  unsigned int pointsIndex;
  double z;
  double cost;
  bool skip;

  PSpeedySum_Output() : numRead(0), offset(0), blockSize(0), z(0.0), pointsIndex(0), cost(0.0), skip(false) {}

  PSpeedySum_Output(size_t numRead, size_t offset, size_t blockSize, unsigned int pointsIndex, double z, double cost, bool skip = false) 
    : numRead(numRead), offset(offset), blockSize(blockSize), pointsIndex(pointsIndex), z(z), cost(cost), skip(skip) {}
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

class PStreamReader : public raft::kernel
{
private:
  PStream* m_Stream;
  int m_Dim;
  long m_ChunkSize;
  float** m_Block;
  size_t m_Offset;

  unsigned int m_Index;
public:
  PStreamReader(PStream* stream, float** block, int dim, long chunkSize) 
    : raft::kernel(), m_Stream(stream), m_Block(block), m_Dim(dim), m_ChunkSize(chunkSize), m_Offset(0), m_Index(0)
  {
    // Create our output port
    output.addPort<PStreamReader_Output>("out");
  }

  virtual raft::kstatus run()
  {
    // Get the number of points to operate on
    size_t numRead = m_Stream->read(m_Block[m_Index], m_Dim, m_ChunkSize);
    
    // Error checking
    if (m_Stream->ferror() || numRead < (unsigned int) m_ChunkSize && !m_Stream->feof())
    {
      std::cerr << "Error reading data!" << std::endl;
      exit(EXIT_FAILURE);
    }

    // Push our output data
    output["out"].push(PStreamReader_Output(numRead, m_Offset, m_Index++));
    m_Offset += numRead;

    // If we have reached the end of the stream, stop
    if (m_Stream->feof())
      return raft::stop;

    return raft::proceed;
  }
};

class LocalSearchStarter : public raft::kernel
{
private:
  Points** m_Points;
  unsigned int m_ThreadCount;
public:
  LocalSearchStarter(Points** points, unsigned int threadCount) 
    : raft::kernel(), m_Points(points), m_ThreadCount(threadCount)
  {
    // Create our input port
    input.addPort<PStreamReader_Output>("in");

    char buffer[128];

    // Create our output ports based on the number of desired threads
    for (auto i = 0; i < m_ThreadCount; i++)
    {
      sprintf(buffer, "out%u", i);
      output.addPort<LocalSearchStarter_Output>(buffer);
    }
  }

  virtual raft::kstatus run()
  {
    // Get our input data
    PStreamReader_Output inputData = input["in"].peek<PStreamReader_Output>();

    // Calculate the blockSize for each "thread"
    size_t blockSize = inputData.numRead / (size_t) m_ThreadCount;

    // Thread Index
    unsigned int i = 0;
    for (auto &port : output)
    {
      // Push the data for each port
      port.push<LocalSearchStarter_Output>(LocalSearchStarter_Output(inputData.numRead, inputData.offset, blockSize, inputData.pointsIndex, i++));
    }

    // Cleanup
    input["in"].recycle();

    return raft::proceed;
  }
};

class PKMedianPt1 : public raft::kernel
{
private:
  Points** m_Points;
  size_t m_kMax;
  size_t* m_kCenters;
  size_t* m_kFinal;
public:
  PKMedianPt1(Points** points, size_t* kCenters, size_t kmax, size_t* kFinal)
    : raft::kernel(), m_Points(points), m_kCenters(kCenters), m_kMax(kmax), m_kFinal(kFinal)
  {
    input.addPort<LocalSearchStarter_Output>("in");
    output.addPort<PKMedianPt1_Output>("out");
  }

  virtual raft::kstatus run()
  {
    // Get input data
    LocalSearchStarter_Output inputData = input["in"].peek<LocalSearchStarter_Output>();
    
    // Calculate bounds for iteration
    size_t k1 = inputData.blockSize * inputData.id;
    size_t k2 = k1 + inputData.blockSize;
    if (k2 > inputData.numRead) k2 = inputData.numRead;

    double hiz = 0.0;
    unsigned int pointsIndex = inputData.pointsIndex;

    if (inputData.numRead <= m_kMax)
    {
      for (auto i = k1; i < k2; i++)
      {
        m_Points[pointsIndex]->p[i].assign = i;
        m_Points[pointsIndex]->p[i].cost = 0;
      }

      // Early exit when more centers than points
      *m_kFinal = m_kCenters[pointsIndex];
      output["out"].push<PKMedianPt1_Output>(PKMedianPt1_Output(inputData.numRead, inputData.offset, inputData.blockSize, inputData.pointsIndex, inputData.id, 0.0, true));
      input["in"].recycle();
      return raft::proceed;
    }

    for (auto i = k1; i < k2; i++)
      hiz += dist(m_Points[pointsIndex]->p[i], m_Points[pointsIndex]->p[0], m_Points[pointsIndex]->dim) * m_Points[pointsIndex]->p[i].weight;
    
    // Push result to output
    output["out"].push<PKMedianPt1_Output>(PKMedianPt1_Output(inputData.numRead, inputData.offset, inputData.blockSize, inputData.pointsIndex, inputData.id, hiz));

    // Cleanup
    input["in"].recycle();

    return raft::proceed;
  }
};

class PKMedianPt2 : public raft::kernel_all
{
private:
  Points** m_Points;
  unsigned int m_ThreadCount;
  size_t* m_kCenters;
  size_t m_kMin;
  unsigned int m_SP;
public:
  PKMedianPt2(Points** points, size_t* kCenters, unsigned int threadCount, size_t kMin unsigned int SP)
    : raft::kernel_all(), m_Points(points), m_kCenters(kCenters), m_ThreadCount(threadCount), m_kMin(kMin), m_SP(SP)
  {
    char buffer[128];

    // Create our input and output ports based on the number of desired threads
    for (auto i = 0; i < m_ThreadCount; i++)
    {
      sprintf(buffer, "in%u", i);
      input.addPort<LocalSearchStarter_Output>(buffer);
      sprintf(buffer, "out%u", i);
      output.addPort<PKMedianPt2_Output>(buffer);
    }
    
  }

  virtual raft::kstatus run()
  {
    // Save the input data so we can recycle after reading once
    double hiz = 0.0;
    unsigned int pointsIndex = 0;
    size_t numRead = 0;
    size_t offset = 0;
    size_t blockSize = 0;
    bool skip = false;

    // Read the input data
    for (auto &port : input)
    {
      PKMedianPt1_Output inputData = port.peek<PKMedianPt1_Output>();
      pointsIndex = inputData.pointsIndex;
      numRead = inputData.numRead;
      offset = inputData.offset;
      blockSize = inputData.blockSize;
      if (inputData.skip)
        skip = true; 
      hiz += inputData.hiz;
      port.recycle();
    }

    // If we can skip this entire section, do so
    if (skip)
    {
      unsigned int i = 0;
      for (auto &port : output)
        port.push<PKMedianPt2_Output>(PKMedianPt2_Output(numRead, offset, blockSize, pointsIndex, i++, nullptr, 0.0, true));

      return raft::proceed;
    }
    
    // Shuffle the points
    shuffle(m_Points[pointsIndex]);

    // Choose which centers will be opened
    // TODO: Not convinced that this will work because the costs are modified between iterations...
    // Temp / maybe permanent fix: perform the cost change operation for the singular point here, and 
    // mark the ones for the next kernel to skip...

    // I don't think this method can work realistically, because the points have to be updated every iteration
    // when a center is chosen, master would end up doing all of the work

    bool* openCenters = new bool[numRead];
    
    double z = hiz / 2.0;

    for (auto i = 1; i < numRead; i++)
    {
      if (((float) lrand48() / (float) INT_MAX) < (m_Points[pointsIndex]->p[i].cost / z))
      {
        openCenters[i] = 1;
        m_kCenters[pointsIndex]++;

        // Perform cost change update for the point here, mark it for skip as well
        float distance = dist(m_Points[pointsIndex]->p[i], m_Points[pointsIndex]->p[0], m_Points[pointsIndex]->dim);
        if (distance * m_Points[pointsIndex]->p[i].weight < m_Points[pointsIndex]->p[i].weight)
        {
          m_Points[pointsIndex]->p[i].cost = distance * m_Points[pointsIndex]->p[i].weight;
          m_Points[pointsIndex]->p[i].assign = i;
        }

        // In order to mark a point for a skip, we need to record the iteration 


      }
      else 
        openCenters[i] = 0;
    }   

    // Create and push our output data
    unsigned int i = 0;
    for (auto &port : output)
      port.push<PKMedianPt2_Output>(PKMedianPt2_Output(numRead, offset, blockSize, pointsIndex, i++, openCenters, z));

    return raft::proceed;
  }
};

class PSpeedyKernel : public raft::kernel
{
private:
  Points** m_Points;
  unsigned int m_Iterations;
  unsigned int m_SP;
public:
  PSpeedyKernel(Points** points, unsigned int SP) 
    : raft::kernel(), m_Points(points), m_Iterations(0), m_SP(SP)
  {
    input.addPort<PKMedianPt2_Output>("in");
    output.addPort<PSpeedyKernel_Output>("out");
  }

  virtual raft::kstatus run()
  {
    PKMedianPt2_Output inputData = input["in"].peek<PKMedianPt2_Output>();
    if (inputData.skip)
    {
      output["out"].push<PSpeedyKernel_Output>(PSpeedyKernel_Output(inputData.numRead, inputData.offset, inputData.blockSize, inputData.pointsIndex, inputData.openCenters, 0.0, 0.0, true));
      input["in"].recycle();
      return raft::proceed;
    }

    double cost = 0.0;

    // Calculate bounds for iteration
    size_t k1 = inputData.blockSize * inputData.id;
    size_t k2 = k1 + inputData.blockSize;
    if (k2 > inputData.numRead) k2 = inputData.numRead;

    unsigned int pointsIndex = inputData.pointsIndex;

    // Create center at first point, send it to itself
    for (auto k = k1; k < k2; k++)
    {
      float distance = dist(m_Points[pointsIndex]->p[k], m_Points[pointsIndex]->p[0], m_Points[pointsIndex]->dim);
      m_Points[pointsIndex]->p[k].cost = distance * m_Points[pointsIndex]->p[k].weight;
      m_Points[pointsIndex]->p[k].assign = 0;
    }

    // If a center was opened on this iteration, update the weights if necessary
    for (auto i = 1; i < inputData.numRead; i++)
    {
      if (inputData.openCenters[i])
      {
        for (auto k = k1; k < k2; k++)
        {
          float distance = dist(m_Points[pointsIndex]->p[k], m_Points[pointsIndex]->p[0], m_Points[pointsIndex]->dim);
          if (distance * m_Points[pointsIndex]->p[k].weight < m_Points[pointsIndex]->p[k].weight)
          {
            m_Points[pointsIndex]->p[k].cost = distance * m_Points[pointsIndex]->p[k].weight;
            m_Points[pointsIndex]->p[k].assign = i;
          }
        }

      }
    }

    for (auto i = k1; i < k2; i++)
      cost += m_Points[pointsIndex]->p[i].cost;

    output["out"].push<PSpeedyKernel_Output>(PSpeedyKernel_Output(inputData.numRead, inputData.offset, inputData.blockSize, inputData.pointsIndex, inputData.openCenters, inputData.z, cost));

    input["in"].recycle();

    return raft::proceed;

  }
};

class PSpeedySum : public raft::kernel_all
{
private:
  Points** m_Points;
  PSpeedySum_Output* m_Outputs;
  unsigned int m_ThreadCount;
  size_t* m_kCenters;
public:
  PSpeedySum(Points** m_Points, PSpeedySum_Output* outputs, unsigned int threadCount, size_t* kCenters)
    : raft::kernel_all(), m_Outputs(outputs), m_ThreadCount(threadCount), m_kCenters(kCenters)
  {
    char buffer[128];

    // Create our input ports based on the number of desired threads
    for (auto i = 0; i < m_ThreadCount; i++)
    {
      sprintf(buffer, "in%u", i);
      input.addPort<LocalSearchStarter_Output>(buffer);
    }
  }

  virtual raft::kstatus run()
  {
    // Save the input data so we can recycle after reading once
    double cost = 0.0;
    unsigned int pointsIndex = 0;
    size_t numRead = 0;
    size_t offset = 0;
    size_t blockSize = 0;
    double z = 0.0;
    bool skip = false;

    for (auto &port : input)
    {
      // Read the input data
      PSpeedyKernel_Output inputData = port.peek<PSpeedyKernel_Output>();
      pointsIndex = inputData.pointsIndex;
      numRead = inputData.numRead;
      offset = inputData.offset;
      blockSize = inputData.blockSize;
      z = inputData.z;
      if (inputData.skip)
        skip = true; 
      cost += inputData.cost;
      port.recycle();
    }

    if (skip)
    {
      m_Outputs[pointsIndex].numRead = numRead;
      m_Outputs[pointsIndex].offset = offset;
      m_Outputs[pointsIndex].blockSize = blockSize;
      m_Outputs[pointsIndex].cost = 0.0;
      m_Outputs[pointsIndex].z = z;
      m_Outputs[pointsIndex].pointsIndex = pointsIndex;
      m_Outputs[pointsIndex].skip = true;

      return raft::proceed;
    }

    cost += z * m_kCenters[pointsIndex];

    m_Outputs[pointsIndex].numRead = numRead;
    m_Outputs[pointsIndex].offset = offset;
    m_Outputs[pointsIndex].blockSize = blockSize;
    m_Outputs[pointsIndex].cost = cost;
    m_Outputs[pointsIndex].z = z;
    m_Outputs[pointsIndex].pointsIndex = pointsIndex;
    m_Outputs[pointsIndex].skip = false;

    return raft::proceed;
  }
};


#endif