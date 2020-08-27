/**
 * matrixop.tcc - 
 * @author: Jonathan Beard
 * @version: Thu May 15 10:33:27 2014
 * 
 * Copyright 2014 Jonathan Beard
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
#ifndef _MATRIXOP_TCC_
#define _MATRIXOP_TCC_  1

#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <cassert>
#include <utility>
#include <sstream>
#include <typeinfo>
#include <fstream>
#include <vector>
#include <random>
#include <functional>
#include "ringbuffer.tcc"
#include "ParallelMatrixMult.tcc"
#include "ParallelAdd.tcc"
#include "Matrix.tcc"
#include "systeminfo.hpp"
#include "fifo.hpp"

/** for system info **/
using namespace si;

/** 
 * sets chunk copy size for matrix add 
 */
#define CHUNKSIZE    64

template < typename Type > struct  OutputValue
{
   OutputValue() : index( 0 ),
                   value( 0 )
   {
   }

   OutputValue( const OutputValue &other )
   {
      index   = other.index;
      value   = other.value;
   }

   void operator = ( const OutputValue &other )
   {
      index   = other.index;
      value   = other.value;
   }

   size_t   index;
   Type     value;
};


template< typename T, size_t THREADS = 1 > class MatrixOp {
public:
   MatrixOp() = delete;
   virtual ~MatrixOp() = delete;
#if MONITOR == 1
   typedef RingBuffer< ParallelMatrixMult< T >, 
                       Type::Heap, 
                       true >                               PBuffer;
   
   typedef RingBuffer< OutputValue< T >,
                       Type::Heap,
                       true >                               OutputBuffer;
   
   typedef RingBuffer< ParallelAddStruct< T, CHUNKSIZE >, 
                       Type::Heap, 
                       true >                               PBufferAdd;
   typedef RingBuffer< ParallelAddOutputStruct< T, CHUNKSIZE >,
                       Type::Heap,
                       true >                               OutputBufferAdd;
#else   
   typedef RingBuffer< ParallelMatrixMult< T > >            PBuffer;
   typedef RingBuffer< OutputValue< T > >                   OutputBuffer;
   typedef RingBuffer< ParallelAddStruct< T, CHUNKSIZE > >        PBufferAdd;
   typedef RingBuffer< ParallelAddOutputStruct< T, CHUNKSIZE > >  OutputBufferAdd;
#endif
   
   /**
    * multiply - takes in matrices a and b, stores the output
    * in matrix "output."  Uses the number of threads specified
    * in the class template parameter when referencing this static
    * function.  The current implementation uses a relatively 
    * naive dot product / blocking implementation, however this will
    * slowly change once the transition to the Raft framework is 
    * complete.
    * @param   a, Matrix< T >*
    * @param   b, Matrix< T >*
    * @param   output, Matrix< T >* - must be of the correct dimensions
    */
   static void multiply(   Matrix< T > *a, 
                           Matrix< T > *b,
                           Matrix< T > *output,
                           const size_t buffer_size ) 
                                 
   {
      assert( a != nullptr );
      assert( b != nullptr );
      assert( output != nullptr );
      if( a->width != b->height )
      {
         //TODO make some proper exceptions
         std::cerr << "Matrix a's width must equal matrix b's height.\n";
         return;
      }
      
      std::array< std::thread*, THREADS + 1 /* consumer thread */ > thread_pool;
      std::array< PBuffer*,      THREADS >    buffer_list;
      std::array< OutputBuffer*, THREADS >    output_list;
      for( size_t i( 0 ); i < THREADS; i++ )
      {
         buffer_list[ i ] = new PBuffer(        buffer_size );
         output_list[ i ] = new OutputBuffer(   buffer_size );
      }
      for( size_t i( 0 ); i < THREADS; i++ )
      {
         thread_pool[ i ] = new std::thread( mult_thread_worker,
                                             buffer_list[ i ],
                                             output_list[ i ] );
      }
      thread_pool[ THREADS ] = new std::thread( mult_thread_consumer,
                                                    std::ref( output_list ),
                                                    output );
      

      Matrix< T > *b_rotated = b->rotate();
#ifdef TIMEMATRIXOP      
      const auto start_time( system_clock->getTime() );
#endif
      int64_t stop_index( b->height * b->width );
      uint32_t index( 0 );
      for( size_t b_row_index( 0 ); 
            b_row_index < b_rotated->height; b_row_index++ )
      {
         size_t output_index( b_row_index );
         for( size_t a_row_index( 0 ); a_row_index < a->height; a_row_index++ )
         {
            index = (index + 1 ) % THREADS ;
            auto &mem( buffer_list[ index ]->template allocate<ParallelMatrixMult< T > >() );
            mem.a            = a;
            mem.a_start      = a_row_index * a->width;
            mem.a_end        = (a_row_index * a->width ) + a->width;
            mem.b            = b_rotated;
            mem.b_start      = b_row_index * b_rotated->width;
            mem.b_end        = (b_row_index * b_rotated->width ) + a->width;
            mem.output       = output;
            mem.output_index = output_index;
            if( stop_index-- > THREADS )
            {
               buffer_list[ index ]->push();
            }
            else
            {
               /** go ahead and tell the threads we used to shutdown **/
               buffer_list[ index ]->push( RBSignal::RBEOF );
            }
            output_index += b->width;
         }
      }
      
      /** join threads **/
      for( auto *thread : thread_pool )
      {
         thread->join();
      }
#ifdef TIMEMATRIXOP      
      const auto end_time( system_clock->getTime() );
      std::cout << "{" << buffer_size << "," << ( end_time - start_time ) << "}";
#endif     
     /** get info **/
      for( auto *thread : thread_pool )
      {
         delete( thread );
         thread = nullptr;
      }
#if MONITOR
      std::stringstream ss;
      ss << "/project/mercury/svardata/";
      std::string filehead( SystemInfo::getSystemProperty( Trait::NodeName ) );
      ss << filehead << "_mmult_" << QUEUETYPE << "_" << THREADS << ".csv";
      std::string filename( ss.str() );
      std::ofstream monitorfile( filename, std::fstream::app | std::fstream::out );
      if( ! monitorfile.is_open() )
      {
         std::cerr << "Failed  to open file!\n";
         exit( EXIT_FAILURE );
      }
      //std::string traits;
      //{
      //   std::stringstream trait_stream;
      //   const auto num_traits( SystemInfo::getNumTraits() );
      //   for( auto index( 0 ); index < num_traits; index++ )
      //   {
      //      trait_stream << SystemInfo::getSystemProperty( (Trait) index ) << ",";
      //   }
      //   traits = trait_stream.str();
      //}
#endif
      for( auto *buffer : buffer_list )
      {
#if MONITOR         
         //monitorfile << traits;
         buffer->printQueueData( monitorfile ) << "\n";
#endif         
         delete( buffer );
         buffer = nullptr;
      }
      
      for( auto *buffer : output_list )
      {
#if MONITOR         
      //   monitorfile << traits;
         buffer->printQueueData( monitorfile ) << "\n";
#endif         
         delete( buffer );
         buffer = nullptr;
      }
      delete( b_rotated );
#if MONITOR      
      monitorfile.close();
#endif      
   }


   static Matrix< T >* multiply( Matrix< T > &a, T val )
   {
      Matrix< T > *output = new Matrix< T >( a.height, a.width );
      if( val == 0 )
      {
         return( output );
      }
      const auto shift( count_one_bits( val ) );
      if( 
          ( typeid( T ) == typeid( uint64_t ) || 
            typeid( T ) == typeid( uint32_t ) ||
            typeid( T ) == typeid( uint16_t ) ||
            typeid( T ) == typeid( uint8_t  ) ) 
          && shift.first == 1  )
      {
         for( size_t i( 0 ); i < ( a.height * a.width ); i++ )
         {
            output->matrix[ i ] = 
            (*reinterpret_cast< uint64_t* >(&a.matrix[ i ])) << shift.second ;
         }
      }
      else
      {
         for( size_t i( 0 ); i < ( a.height * a.width ); i++ )
         {
            output->matrix[ i ] = a.matrix[ i ] * val;
         }
      }
      return( output );
   }
      
   static Matrix< T >* add_scalar( Matrix< T > &a, T val )
   {
      Matrix< T > *output( new Matrix< T >( a.height, a.width ) );
      for( size_t i( 0 ); i < ( a.height * a.width ); i++ )
      {
         output->matrix[ i ] = a.matrix[ i ] + val;
      }
      return( output );
   }


   static void add( Matrix< T > *a, 
                    Matrix< T > *b, 
                    Matrix< T > *output, 
                    const size_t buffer_size )
   {
      if( a->height != b->height )
      {
         //TODO, make some exceptions
         std::cerr << "Matrices must have the same height!\n";
         return;
      }
      if( a->width != b->width )
      {
         //TODO, throw proper exception
         std::cerr << "Matricies must have the same width!\n";
         return;
      }
      
      //setup parallel workers
      std::array< std::thread*,  THREADS + 1 /* consumer thread */ > thread_pool;
      std::array< PBufferAdd*,      THREADS >    buffer_list;
      std::array< OutputBufferAdd*, THREADS >    output_list;

      for( size_t i( 0 ); i < THREADS; i++ )
      {
         buffer_list[ i ] = new PBufferAdd(        buffer_size );
         output_list[ i ] = new OutputBufferAdd(   buffer_size );
      }
      for( size_t i( 0 ); i < THREADS; i++ )
      {
         thread_pool[ i ] = new std::thread( add_thread_worker,
                                             buffer_list[ i ],
                                             output_list[ i ] );
      }
      thread_pool[ THREADS ] = new std::thread(    add_thread_consumer,
                                                   std::ref( output_list ),
                                                   output );
      const auto start_time( system_clock->getTime() );

      /** lets add! **/
      const uint16_t chunksize( CHUNKSIZE /** TODO, rethink where this is chosen **/ );
      int64_t buffer_index( 0 );
      const auto end_index( a->height * a->width );
      for( size_t index( 0 ); index < end_index; index += chunksize )
      {
         auto &data( 
            buffer_list[ buffer_index ]-> template allocate< 
                                             ParallelAddStruct< T, 
                                                                CHUNKSIZE > >() );
         data.start_index = index;
         data.length      = 
            ( (end_index - index) > chunksize ? chunksize : (end_index - index));
         
         /** copy data, future automagically decide if we can do pass by reference **/
         for( size_t data_index( index ); data_index < data.length; data_index++ )
         {
            data.a[ data_index ] = a->matrix[ data_index ];
            data.b[ data_index ] = b->matrix[ data_index ];
         }
         buffer_list[ buffer_index ]->push();
         buffer_index = (buffer_index + 1 ) % THREADS;
      }

      const auto end_time( system_clock->getTime() );
      std::cout << "{" << buffer_size << "," << ( end_time - start_time ) << "}";

      //shutdown parallel workers
      /** send all dummy message **/
      for( size_t i( 0 ); i < THREADS; i++ )
      {
         auto &dummy( 
            buffer_list[ i ]-> template allocate< ParallelAddStruct< T, 
                                                                     CHUNKSIZE > >() );
         /** keep it from being compiled out by an overly aggressive compiler **/
         dummy.length = 0;
         buffer_list[ i ]->push( RBSignal::RBEOF );
      }
      /** join threads **/
      for( auto *thread : thread_pool )
      {
         thread->join();
         delete( thread );
         thread = nullptr;
      }
      /** get info **/
#if MONITOR
      std::stringstream ss;
      ss << "/project/mercury/svardata/";
      std::string filehead( SystemInfo::getSystemProperty( Trait::NodeName ) );
      ss << filehead << "_madd_" << QUEUETYPE << "_" << THREADS << ".csv";
      std::string filename( ss.str() );
      std::ofstream monitorfile( filename, std::fstream::app | std::fstream::out );
      if( ! monitorfile.is_open() )
      {
         std::cerr << "Failed  to open file!\n";
         exit( EXIT_FAILURE );
      }
      //std::string traits;
      //{
      //   std::stringstream trait_stream;
      //   const auto num_traits( SystemInfo::getNumTraits() );
      //   for( auto index( 0 ); index < num_traits; index++ )
      //   {
      //      trait_stream << SystemInfo::getSystemProperty( (Trait) index ) << ",";
      //   }
      //   traits = trait_stream.str();
      //}
#endif
      for( auto *buffer : buffer_list )
      {
#if MONITOR         
         auto &monitor_data( buffer->getQueueData() );
         //monitorfile << traits;
         buffer->printQueueData( monitorfile ) << "\n";
#endif         
         delete( buffer );
         buffer = nullptr;
      }
      
      for( auto *buffer : output_list )
      {
#if MONITOR         
         //monitorfile << traits;
         buffer->printQueueData( monitorfile ) << "\n";
#endif         
         delete( buffer );
         buffer = nullptr;
      }
#if MONITOR      
      monitorfile.close();
#endif      
   }

protected:
   static std::pair< int, 
                     int > count_one_bits( T val )
   {
      const uint64_t newval( (uint64_t) val );
      int pop_count(   __builtin_popcountll( newval ) );
      int trail_zeros( __builtin_ctzll( newval ) );
      return( std::make_pair( pop_count, 
                              trail_zeros ) );
   }
   

   static void mult_thread_worker( PBuffer *buffer, OutputBuffer *output )
   {
      assert( buffer != nullptr );
      assert( output != nullptr );
      ParallelMatrixMult< T > val;
      RBSignal sig( RBSignal::NONE );
      while( sig != RBSignal::RBEOF )
      {
         /** consume data **/
         buffer->pop( val, &sig );

         auto &scratch( output-> template allocate< OutputValue< T > >() );
         scratch.index = val.output_index;

         for( size_t a_index( val.a_start ), b_index( val.b_start );
               a_index < val.a_end && b_index < val.b_end;
                  a_index++, b_index++ )
         {
            scratch.value +=
               val.a->matrix[ a_index ] *
                  val.b->matrix[ b_index ];
         }
         output->push( sig );
      }
      return;
   }

   static void mult_thread_consumer( std::array< OutputBuffer*, THREADS > &buffer,
                                     Matrix< T > *output )
   {
      int sig_count( 0 );
      OutputValue< T > data;
      RBSignal sig( RBSignal::NONE );
      /** TODO, change THREADS to used threads so that buffers
       *  that aren't used will still be terminated 
       */
      while( sig_count <  THREADS )
      {
         for( auto it( buffer.begin() ); it != buffer.end(); ++it )
         {
            if((*it)->size() > 0 )
            {
               (*it)->pop( data, &sig );
               output->matrix[ data.index ] = data.value;
               if( sig == RBSignal::RBEOF )
               {
                  sig_count++;
               }
            }
         }
      }
      return;
   }

   static void add_thread_worker( PBufferAdd *buffer, OutputBufferAdd *output )
   {
      assert( buffer != nullptr );
      assert( output != nullptr );
      ParallelAddStruct< T, CHUNKSIZE > data;
      RBSignal sig( RBSignal::NONE );
      while( true )
      {
         buffer->pop( data, &sig );
         ParallelAddOutputStruct< T, CHUNKSIZE > &scratch( 
            output-> template allocate< ParallelAddOutputStruct< T, CHUNKSIZE > >() );
         if( sig == RBSignal::RBEOF )
         {
            output->push( sig );
            return;
         }
         /* copy housekeeping info */
         scratch.start_index = data.start_index;
         scratch.length      = data.length;
         if( scratch.length > 0 )
         {
            /* do the adding */
            for( size_t index( 0 ); index < CHUNKSIZE; index++ )
            {
               scratch.output[ index ] = data.a[ index ] + data.b[ index ];
            }
         }
         output->push( sig );
      }
      return;
   }

   static void add_thread_consumer( std::array< OutputBufferAdd*, THREADS > &buffer,
                                    Matrix< T > *output )
   {
      int sig_count( 0 );
      ParallelAddOutputStruct< T , CHUNKSIZE > data;
      RBSignal sig( RBSignal::NONE );
      while( sig_count < THREADS )
      {
         for( auto it( buffer.begin() ); it != buffer.end(); ++it )
         {
            if( (*it)->size() > 0 )
            {
               (*it)->pop( data, &sig );
               if( sig == RBSignal::RBEOF )
               {
                  sig_count++;
               }
               else
               {
                  for( size_t index( data.start_index ); index < data.length; index++ )
                  {
                     output->matrix[ index ] = data.output[ index - data.start_index ];
                  }
               }
            }
         }
      }
   }
};
#endif /* END _MATRIXOP_TCC_ */
