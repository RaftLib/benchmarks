#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <stdint.h>
#include <time.h>

#include "dct.h"

float array_A[8][8] = 
{
  {-76.0, -73.0, -67.0, -62.0, -58.0, -67.0, -64.0, -55.0},
  {-65.0, -69.0, -73.0, -38.0, -19.0, -43.0, -59.0, -56.0},
  {-66.0, -69.0, -60.0, -15.0,  16.0, -24.0, -62.0, -55.0},
  {-65.0, -70.0, -57.0, -6.0 ,  26.0, -22.0, -58.0, -59.0},
  {-61.0, -67.0, -60.0, -24.0,  -2.0, -40.0, -60.0, -58.0},
  {-49.0, -63.0, -68.0, -58.0, -51.0, -60.0, -70.0, -53.0},
  {-43.0, -57.0, -64.0, -69.0, -73.0, -67.0, -63.0, -45.0},
  {-41.0, -49.0, -59.0, -60.0, -63.0, -52.0, -50.0, -34.0}
};

float array_temp[8][8] = 
{
  {-76.0, -73.0, -67.0, -62.0, -58.0, -67.0, -64.0, -55.0},
  {-65.0, -69.0, -73.0, -38.0, -19.0, -43.0, -59.0, -56.0},
  {-66.0, -69.0, -60.0, -15.0,  16.0, -24.0, -62.0, -55.0},
  {-65.0, -70.0, -57.0, -6.0 ,  26.0, -22.0, -58.0, -59.0},
  {-61.0, -67.0, -60.0, -24.0,  -2.0, -40.0, -60.0, -58.0},
  {-49.0, -63.0, -68.0, -58.0, -51.0, -60.0, -70.0, -53.0},
  {-43.0, -57.0, -64.0, -69.0, -73.0, -67.0, -63.0, -45.0},
  {-41.0, -49.0, -59.0, -60.0, -63.0, -52.0, -50.0, -34.0}
};

inline void arrayCopy(float a[][8], float b[][8]){
   uint8_t i,j;
   for(i = 0; i < 8; i++){
      for( j = 0; j < 8; j++){
         a[i][j] = b[i][j];
      }
   }
}

/**
 * Print Array, takes in an 8 x 8 matrix and prints it
 */
inline void printArray(float a[][8]){
   uint8_t x,y;
   for(x = 0; x< 8; x++){
      for(y = 0; y< 8; y++){
         fprintf(stdout,"%9.3f",a[x][y]);
      }
      fprintf(stdout,"\n");
   }
   fprintf(stdout,"\n");
}

int main(const int argc, const char **argv){

   printArray(array_A);
   uint32_t count = 0;
   clock_t start,end;
   const uint32_t iterations = 100000;
   double accum = 0.0;

   for(count = 0; count < iterations; count++){
      start = clock();
      dct_fast(array_A);
      end = clock();
      accum += (end - start);   
      printArray(array_A);
      arrayCopy(array_A,array_temp);
   }

   //double totalTime = ((double)(accum)/(double)iterations)/CLOCKS_PER_SEC;
   double totalTime = accum / iterations;
   fprintf(stderr,"TIME: %f\n",totalTime);
   return 0;
}
