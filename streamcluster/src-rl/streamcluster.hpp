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

  PStreamReader_Output(size_t numRead, size_t offset) : numRead(numRead), offset(offset) {}
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
  long m_CenterSize;
  float* m_Block;
  float* m_CenterBlock;
  Points* m_Points;
  Points* m_Centers;
  size_t m_Offset;
public:
  PStreamReader(PStream* stream, int dim, long chunkSize, long centerSize) : raft::kernel()
  {
    m_Stream = stream;
    m_Dim = dim;
    m_ChunkSize = chunkSize;
    m_CenterSize = centerSize;
    m_Block = (float*) malloc(chunkSize * dim * sizeof(float));
    m_CenterBlock = (float*) malloc(centerSize * dim * sizeof(float));
    m_Offset = 0;

    if (m_Block == nullptr)
    {
      std::cerr << "Not enough memory for a chunk!" << std::endl;
      exit(EXIT_FAILURE);
    }

    m_Points = new Points(chunkSize, dim, chunkSize);
    for (auto i = 0; i < chunkSize; i++)
      m_Points->p[i].coord = &m_Block[i * dim];

    m_Centers = new Points(0, dim, centerSize);
    for (auto i = 0; i < centerSize; i++)
      m_Centers->p[i].coord = &m_CenterBlock[i * dim];

    output.addPort<PStreamReader_Output>("out");
  }

  ~PStreamReader()
  {
    free(m_Block);
    free(m_CenterBlock);
    delete m_Points;
    delete m_Centers;
  }

  virtual raft::kstatus run()
  {
    size_t numRead = m_Stream->read(m_Block, m_Dim, m_ChunkSize);
    if (m_Stream->ferror() || numRead < (unsigned int) m_ChunkSize && !m_Stream->feof())
    {
      std::cerr << "Error reading data!" << std::endl;
      exit(EXIT_FAILURE);
    }

    PStreamReader_Output outputData(numRead, m_Offset);

    output["out"].push(outputData);
    m_Offset += numRead;

    if (m_Stream->feof())
      return(raft::stop);

    return(raft::proceed);
  }
};

class PKMedianPt1 : public raft::kernel
{
private:
  Points* m_Points;

public:
  PKMedianPt1(Points* points) : raft::kernel(), m_Points(points)
  {
    input.addPort<PStreamReader_Output>("in");
    output.addPort<double>("out");
    output.addPort<PStreamReader_Output>("stream_output");
  }

  virtual raft::kstatus run()
  {
    PStreamReader_Output inputData = input["in"].peek<PStreamReader_Output>();
    double myHiz = 0.0;
    for (auto k = 0; k < inputData.numRead; k++)
      myHiz += dist(m_Points->p[k], m_Points->p[0], m_Points->dim) * m_Points->p[k].weight;
    output["out"].push<double>(myHiz);
    output["stream_output"].push<PStreamReader_Output>(inputData);
    input["in"].recycle();
    return raft::proceed;
  }
};

class PKMedianPt2 : public raft::kernel
{
private:
  Points* m_Points;
  size_t m_kMax;
  double m_Cost;
  size_t* m_kFinal;
public:
  PKMedianPt2(Points* points, size_t kmax, size_t* kfinal) : raft::kernel(), m_Points(points), m_kMax(kmax), m_Cost(0.0), m_kFinal(kfinal)
  {
    input.addPort<double>("in");
    input.addPort<PStreamReader_Output>("stream_input");
    output.addPort<double>("out");
  }

  virtual raft::kstatus run()
  {
    double z = input["in"].peek<double>() / 2.0;
    PStreamReader_Output inputData = input["stream_input"].peek<PStreamReader_Output>();
    
    if (inputData.numRead <= m_kMax)
    {
      for (auto k = 0; k < inputData.numRead; k++)
      {
        m_Points->p[k].assign = k;
        m_Points->p[k].cost = 0;
      }
      m_Cost = 0.0;
      *m_kFinal = 0.0;
      output["out"].push<double>(m_Cost);
      input["in"].recycle();
      input["stream_input"].recycle();
      return raft::proceed;
    }

    shuffle(m_Points);

  }
};


#endif