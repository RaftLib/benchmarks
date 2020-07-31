/**
 * Code mostly following example from here:
 * https://www.cs.rutgers.edu/~venugopa/parallel_summer2012/bitonic_overview.html
 */
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cinttypes>
#include "bitonic_seq.hpp"


void 
bitonic::sequential::merge_up( bitonic::type_t *arr, const bitonic::type_t n ) 
{
  bitonic::type_t step( n/2) , i(0), j(0), k(0), temp(0);
  while (step > 0) 
  {
    for( i=0; i < n; i+=step*2 ) 
    {
      for( j=i,k=0;k < step;j++, k++ ) 
      {
        if( arr[j] > arr[j+step]) 
        {
            // swap
            temp        =   arr[j];
            arr[j]      =   arr[j+step];
            arr[j+step] =   temp;
        }
      }
    }
    step /= 2;
  }
}

void 
bitonic::sequential::merge_down( bitonic::type_t *arr, const bitonic::type_t  n) 
{
    bitonic::type_t step=n/2,i,j,k,temp( 0 );
    while (step > 0) {
      for (i=0; i < n; i+=step*2) {
        for (j=i,k=0;k < step;j++,k++) {
      if (arr[j] < arr[j+step]) {
        // swap
        temp = arr[j];
        arr[j]=arr[j+step];
        arr[j+step]=temp;
      }
        }
      }
      step /= 2;
    }
}

