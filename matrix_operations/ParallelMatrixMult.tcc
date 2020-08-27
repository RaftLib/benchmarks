/**
 * ParallelMatrixMult.tcc - 
 * @author: Jonathan Beard
 * @version: Thu Jun 19 10:18:55 2014
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
#ifndef _PARALLELMATRIXMULT_TCC_
#define _PARALLELMATRIXMULT_TCC_  1
#include "Matrix.tcc"

template< typename Type > struct ParallelMatrixMult 
{
   ParallelMatrixMult(  Matrix< Type >  *a, 
                       const size_t a_start,
                       const size_t a_end,
                       Matrix< Type >  *b,
                       const size_t b_start,
                       const size_t b_end,
                       Matrix< Type >  *output,
                       const size_t output_index ) : a( a ),
                                              a_start( a_start ),
                                              a_end( a_end ),
                                              b( b ),
                                              b_start( b_start ),
                                              b_end( b_end ),
                                              output( output ),
                                              output_index( output_index )
   {
      /** nothing to do here **/
   }

   ParallelMatrixMult( )           : a( nullptr ),
                                     a_start( 0 ),
                                     a_end( 0 ),
                                     b( nullptr ),
                                     b_start( 0 ),
                                     b_end( 0 ),
                                     output( nullptr ),
                                     output_index( 0 )
   {
   }

   ParallelMatrixMult( const ParallelMatrixMult<Type> &other ) :
      a              ( other.a ),
      a_start        ( other.a_start ),
      a_end          ( other.a_end ),
      b              ( other.b ),
      b_start        ( other.b_start ),
      b_end          ( other.b_end ),
      output         ( other.output ),
      output_index   ( other.output_index )
   {}

   ParallelMatrixMult< Type >&
      operator =( const ParallelMatrixMult< Type > &other )
   {
      a              = other.a ;
      a_start        = other.a_start ;
      a_end          = other.a_end ;
      b              = other.b ;
      b_start        = other.b_start ;
      b_end          = other.b_end ;
      output         = other.output ;
      output_index   = other.output_index ;
      return( *this ); 
   }
   
   Matrix< Type > *a;
   size_t a_start;
   size_t a_end;
   Matrix< Type > *b;
   size_t b_start;
   size_t b_end;
   Matrix< Type >  *output;
   size_t output_index;
};
#endif /* END _PARALLELMATRIXMULT_TCC_ */
