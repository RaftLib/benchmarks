/**
 * Code mostly following example from here:
 * https://www.cs.rutgers.edu/~venugopa/parallel_summer2012/bitonic_overview.html
 */
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include "bitonic_seq.hpp"
#include "bitonic_swap.hpp"

void 
bitonic::sequential::merge_up( bitonic::type_t * const arr, const bitonic::type_t n )  noexcept
{
  bitonic::type_t step( n >> 1 );
  while (step > 0) 
  {
    for( auto i( 0 ); i < n; i+= (step << 1) ) 
    {
      for( auto j( i ), k( 0 ); k < step; j++, k++ ) 
      {
        if( std::isgreater( arr[ j ], arr[ j+step ] ) ) 
        {
            // swap
            bitonic::swap( arr[ j ], arr[j + step] );
        }
      }
    }
    step = (step >> 1);
  }
}

void 
bitonic::sequential::merge_down( bitonic::type_t * const arr, const bitonic::type_t  n) noexcept
{
    bitonic::type_t step( n >> 1 );

    while( step > 0 ) 
    {
        for( auto i( 0 ); i < n; i += (step << 1 ) ) 
        {
            for( auto j( i ), k( 0 ); k < step; j++,k++) 
            {
                if( std::isless( arr[ j ], arr[ j+step ] ) ) 
                {
                    // swap
                    bitonic::swap( arr[ j ], arr[ j + step ] );
                }
            }
        }
        step = (step >> 1 );
    }
}

