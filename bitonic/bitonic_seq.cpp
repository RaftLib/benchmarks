/**
 * Code mostly following example from here:
 * https://www.cs.rutgers.edu/~venugopa/parallel_summer2012/bitonic_overview.html
 */
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cinttypes>

using   type_t = std::int64_t;
#define PRI_T PRIi64


void merge_up( type_t *arr, const type_t n ) 
{
  type_t step( n/2) , i(0), j(0), k(0), temp(0);
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

void merge_down( type_t *arr, int n) 
{
    type_t step=n/2,i,j,k,temp( 0 );
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

void printArray( type_t *arr, const type_t n) 
{
    printf("[%" PRI_T "",arr[0]);
    for( auto i( 1 ); i < n; i++)
    {
        printf(",%" PRI_T "",arr[i]);
    }
    printf("]\n");
}

int main(int argc, char **argv) 
{
  type_t n( 0 ), *arr( nullptr ), i( 0 ), s( 0 );

  FILE *fp = std::fopen( argv[1],"r" );

  if( fp == nullptr ) 
  {
    std::fprintf(stderr,"file not found\n");
    std::exit( EXIT_FAILURE );
  }
  // first line gives number of numbers to be sorted 
  std::fscanf( fp, "%" PRI_T "", &n );
  // allocate space and read all the numbers 
  arr = (type_t*) malloc( n * sizeof(type_t) );
  for (i=0; i < n; i++) {
    fscanf(fp,"%" PRI_T "",(arr+i));
  }
  // print array before 
  printArray(arr,n);

  // do merges
  for (s=2; s <= n; s*=2) {
    for (i=0; i < n;) {
      merge_up((arr+i),s);
      merge_down((arr+i+s),s);
      i += s*2;
    }
  }

  printArray(arr,n);
}
