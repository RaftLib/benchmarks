#include <stdio.h>
#include <stdlib.h>
#include <immintrin.h>
#include <xmmintrin.h>
#include <inttypes.h>
#include <stdint.h>

#include "zigzag.h"


int main(){
   uint8_t x,y;
   short test[8][8];
   for(x = 1; x < 9; x++)
      for(y = 1; y < 9; y++)
         test[x-1][y-1] = ((x-1) * 8) + y;

   zigzag_array(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7]);
   
   for (x = 0; x < 8; x++){
      for (y = 0; y < 8; y++){
         fprintf(stdout,"%4hi",test[x][y]);
      }
      fprintf(stdout,"\n");
   }
   return 0;
};
