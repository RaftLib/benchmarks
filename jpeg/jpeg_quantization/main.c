#include <stdio.h>
#include <stdlib.h>
#include <immintrin.h>
#include <xmmintrin.h>
#include <inttypes.h>
#include <stdint.h>

#include "quant.h"

typedef union{
   __v4sf v;
   float a[4];
}vector;

typedef union{
   __v4si v;
   int a[4];
}vector_i;

int main(){
   vector a;
   vector_i c;
   uint8_t i;
   for( i = 0; i< 4; i++){
      a.a[i] = 6.6;
   }
   
   c.v = quant(a.v, *((__v4sf*)luminance[0]));
   //c.v = __builtin_ia32_divps256(a.v,b.v);
   for(i = 0; i< 4; i++)
      fprintf(stdout, "%d\n",c.a[i]);
   return 0;
};
