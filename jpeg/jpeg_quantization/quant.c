#include <stdio.h>
#include <stdlib.h>

#if (__SSE__ == 1 && __AVX__ == 0)
#include <xmmintrin.h>
#endif

#if (__AVX__ == 1)
#include <immintrin.h>
#endif

#if (__SSE__ == 1 && __AVX__ == 0)
inline __v4si quant(const __v4sf numerator, const __v4sf quant_denominator){
   const __v4sf temp =  __builtin_ia32_divps(quant_denominator,numerator);
   return __builtin_ia32_cvtps2dq(temp);
}
#endif

#if (__AVX__ == 1)
inline __v8si quant(const __v8sf numerator, const __v8sf quant_denominator){
   const __v8sf temp = __builtin_ia32_divps256(quant_denominator,numerator);
   return __builtin_ia32_cvtps2dq256(temp);
}
#endif

#if (__AVX__ == 0 && __SSE__ == 0)
inline int32_t quant(const float numerator, const float quant_denominator){
   return (int32_t)(numerator/quant_denominator);
}
#endif


