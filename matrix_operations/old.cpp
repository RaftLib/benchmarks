/**
 * main.cpp - 
 * @author: Jonathan Beard
 * @version: Thu May 15 10:32:07 2014
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
#include <iostream>
#include <cstdlib>

#define MONITOR   1
#define QUEUETYPE "heap"


#include "matrixop.tcc"

#include "randomstring.tcc"
#include "SystemClock.tcc"
#include <cassert>

#define MULT 1

using thetype_t = float;

int
main( int argc, char **argv )
{
   
    
   const std::string filename( "randomarray.csv" );
   //const std::string filename( "/project/mercury/svardata/10000_10000_float.csv" );
   //const std::string filename( "intmatrix100_100.csv" );
   //const std::string filename( "supersmall.csv" );
   
   auto *A = Matrix< thetype_t >::initFromFile( filename );
   assert( A != nullptr );
   //same matrix, avoid reading from disk again 
   auto *x      = new Matrix< thetype_t >( *A );
   
   /** to test queues we don't need to re-allocate the starting matrices **/
   std::ofstream nullstream( "/dev/null" );
   std::cout.setf( std::ios::fixed );
   std::cout << std::setprecision( 30 );
   const std::size_t buff_size( 200 );
   //for( const size_t buff_size : sizes )
   //{
      int runs( 5 );
      while( runs-- )
      {
         std::cerr << "starting: " << buff_size << " items - " << runs << "\n";
         auto *output = new Matrix< thetype_t >( A->height, x->width );
#ifdef MULT
         MatrixOp< thetype_t, 8 >::multiply( A, x, output, buff_size );
         std::cout << ",";
#elif defined ADD      
         MatrixOp< thetype_t, 4 >::add( A, x, output );
#else
#warning No operation defined!
#endif
         output->print( nullstream , Format::CSV );
         delete( output );
      }
   //}

   delete( A );
   delete( x );

   return( EXIT_SUCCESS );
}
