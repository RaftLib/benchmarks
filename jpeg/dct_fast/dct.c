#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <stdint.h>
#include <time.h>

#if (__SSE4_1__ == 1)
#include <xmmintrin.h>
#else
#include <math.h>
#define alpha_zero 1/(M_SQRT2 * 2)
#endif

#include "dct.h"

#if (__SSE4_1__ == 0 && OPTIMIZE == 0)
inline void dct_naive(float a[][8], float b[][8]){
   register uint8_t x,y;
   const uint8_t height = 8, width = 8;
   for(x = 0; x < width; x++){
      for(y = 0; y < height; y++){                  
         b[x][y] = compute_dct(x,y,a);      
      }
   }
   for(x = 0; x< width; x++){
      for(y = 0; y < height; y++){
         a[x][y] = b[x][y];
      }
   }
}

inline float compute_dct(const uint8_t u,const uint8_t v, float a[][8]){
   register uint8_t x,y;
   const double pi_div_8 = M_PI/8.0;
   const uint8_t dim = 8;
   float out = 0;
   for(x = 0; x < dim; x++){
      for(y = 0; y < dim; y++){
         out += a[x][y] * cos(pi_div_8*((double)x+.5)*(double)u) * cos(pi_div_8*((double)y+.5)*(double)v);
      }
   }
   out = out * alpha(u) * alpha(v);
   return out;
}
#endif

void inline dct_fast(float a[][8]){
   float b[8][8]; 

#if (__SSE4_1__ == 1)
   const float t[8][8] = 
   {
      {.3536,  .3536,  .3536,  .3536,  .3536,  .3536, .3536 ,  .3536}, 
      {.4904,  .4157,  .2778,  .0975, -.0975, -.2778, -.4157, -.4904},
      {.4619,  .1913, -.1913, -.4619, -.4619, -.1913,  .1913,  .4619},
      {.4157,  -.975, -.4904, -.2778,  .2778,  .4904,  .0975, -.4157},
      {.3536, -.3536, -.3536,  .3536,  .3536, -.3536, -.3536,  .3536},
      {.2778, -.4904, -.0975,  .4157, -.4157, -.0975,  .4904, -.2778},
      {.1913, -.4619,  .4619, -.1913, -.1913,  .4619, -.4619,  .1913},
      {.0975, -.2778,  .4157, -.4904,  .4904, -.4157,  .2778, -.0975}
   };
  uint8_t x,y;
  for(x = 0; x < 4; x++){
      for(y = 0; y < 8; y++){
         b[x][y] = dpps_v8sf(a[x],t[y]);   
      }
  }
  _MM_TRANSPOSE4_PS(*((__v4sf*)b[0]) , *((__v4sf*)b[1]) , *((__v4sf*)b[2]) , *((__v4sf*)b[3]));
  _MM_TRANSPOSE4_PS(*((__v4sf*)(b[0]+4)) , *((__v4sf*)(b[1]+4)) , *((__v4sf*)(b[2]+4)) , *((__v4sf*)(b[3]+4)));
  uint8_t i,j;
  for(i = 4; i < 8; i++){
      for(j = 0; j < 8; j++){
         b[i][j] = dpps_v8sf(a[i],t[j]);   
      }
  }
  _MM_TRANSPOSE4_PS(*((__v4sf*)b[4]) , *((__v4sf*)b[5]) , *((__v4sf*)b[6]) , *((__v4sf*)b[7]));
  _MM_TRANSPOSE4_PS(*((__v4sf*)(b[4]+4)) , *((__v4sf*)(b[5]+4)) , *((__v4sf*)(b[6]+4)) , *((__v4sf*)(b[7]+4)));
  row_swap((__v4sf*)(b[0]+4),(__v4sf*)(b[4]));
  row_swap((__v4sf*)(b[1]+4),(__v4sf*)(b[5]));
  row_swap((__v4sf*)(b[2]+4),(__v4sf*)(b[6]));
  row_swap((__v4sf*)(b[3]+4),(__v4sf*)(b[7]));
  uint8_t k,m;
  for(k = 0; k < 8; k++){
      for(m = 0; m < 8; m++){
         a[k][m] = dpps_v8sf(b[k],t[m]);
      }
  }
#else

#if (FP == 0)
   dct_aan(a,b);
#endif

#if (FP == 1)
   dct_naive(a,b);
#endif

#endif
}
#if (__SSE4_1__ == 1)
inline float dpps_v8sf(const float a[8],const float b[8]){
   const __v4sf a_low = *((__v4sf*)a);
   const __v4sf a_high = *((__v4sf*) (a+4));
   const __v4sf b_low = *((__v4sf*)b);
   const __v4sf b_high = *((__v4sf*)(b+4));
   __v4sf low = __builtin_ia32_dpps(a_low,b_low,255);
   __v4sf high = __builtin_ia32_dpps(a_high,b_high,255);
   //extract index 0, add two dot products and return sum
   return (__builtin_ia32_vec_ext_v4sf(low,1) + __builtin_ia32_vec_ext_v4sf(high,1));
}
inline void row_swap(__v4sf *a, __v4sf *b){
   const __v4sf tmp = *a;
   *a = *b;
   *b = tmp;
}
#endif

#if (__OPTIMIZE__ == 1 && __SSE4_1__ == 0)
/*
 * Fast DCT algorithm due to Arai, Agui, Nakajima
 */
inline void dct_aan(float a[][8],float b[][8]){
   uint8_t i;
   int x0,x1,x2,x3,x4,x5,x6,x7,x8;
   const int c1 = 1004, s1 = 200, c3 = 851, s3 = 569, r2c6 = 554, r2s6 = 1337, r2 = 181;
   for(i = 0; i < 8; i++){
      x0 = a[i][0];
      x1 = a[i][1];
      x2 = a[i][2];
      x3 = a[i][3];
      x4 = a[i][4];
      x5 = a[i][5];
      x6 = a[i][6];
      x7 = a[i][7];

      /* Stage 1 */
      x8 = x7 + x0;
      x0 -= x7;
      x7 = x1 + x6;
      x1 -= x6;
      x6 = x2 + x5;
      x2 -= x5;
      x5 = x3 + x4;
      x3 -= x4;

      /* Stage 2 */
      x4=x8+x5;
      x8-=x5;
      x5=x7+x6;
      x7-=x6;
      x6=c1*(x1+x2);
      x2=(-s1-c1)*x2+x6;
      x1=(s1-c1)*x1+x6;
      x6=c3*(x0+x3);
      x3=(-s3-c3)*x3+x6;
      x0=(s3-c3)*x0+x6;
     /* Stage 3 */
      x6=x4+x5;
      x4-=x5;
      x5=r2c6*(x7+x8);
      x7=(-r2s6-r2c6)*x7+x5;
      x8=(r2s6-r2c6)*x8+x5;
      x5=x0+x2;
      x0-=x2;
      x2=x3+x1;
      x3-=x1;

      /*Stage 4*/
      b[i][0] = x6;
      b[i][4] = x4;
      b[i][2] = x8 >> 10;
      b[i][6] = x7 >> 10;
      b[i][7] = (x2 -x5) >> 10;
      b[i][1] = (x2 + x5) >> 10;
      b[i][3] = (x3 * r2) >> 17;
      b[i][5] = (x0 * r2) >> 17;
   }
   
   for(i = 0; i < 8; i++){
      x0 = b[0][i];
      x1 = b[1][i];
      x2 = b[2][i];
      x3 = b[3][i];
      x4 = b[4][i];
      x5 = b[5][i];
      x6 = b[6][i];
      x7 = b[7][i];

      /*Stage 1*/
      x8 = x7 + x0;
      x0 -= x7;
      x7 = x1 + x6;
      x1 -= x6;
      x6 = x2 + x5;
      x2 -= x5;
      x5 = x3 + x4;
      x3 -= x4;

      /*Stage 2*/
      x4 = x8 + x5;
      x8 -= x5;
      x5 = x7 + x6;
      x7 -= x6;
      x6 = c1 * (x1 + x2);
      x2 = (-s1 - c1)*x2 + x6;
      x1 = (s1 - c1) * x1 + x6;
      x6 = c3 * (x0 + x3);
      x3 = (-s3 - c3) * x3 + x6;
      x0 = (s3 - c3) * x0  + x6;
      
      /*Stage 3*/
      x6 = x4 + x5;
      x4 -= x5;
      x5 = r2c6 * (x7 + x8);
      x7 = (-r2s6 - r2c6) * x7 + x5;
      x8 = (r2s6 - r2c6) * x8 + x5;
      x5 = x0 + x2;
      x0 -= x2;
      x2 = x3 + x1;
      x3 -= x1;

      a[0][i] = (x6 + 16) >> 3;
      a[4][i] = (x4 + 16) >> 3;
      a[2][i] = (x8 + 16384) >> 13;
      a[6][i] = (x7 + 16384) >> 13;
      a[7][i] = (x2 - x5 + 16384) >> 13;
      a[1][i] = (x2 + x5 + 16384) >> 13;
      a[3][i] = ((x3 >> 8) * r2 + 8192) >> 12;
      a[5][i] = ((x0 >> 8) * r2 + 8192) >> 12;

   }
}
#endif

#if (__SSE4_1__ == 0)
inline float alpha(const uint8_t x){
   return (x > 0?.5:alpha_zero);
}
#endif




