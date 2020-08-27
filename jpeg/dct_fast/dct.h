#ifndef __inttypes_h__
#include <inttypes.h>
#endif

#define FP 1

#if (__SSE4_1__ == 1)
#include <xmmintrin.h>
#endif

#if (__SSE4_1__ == 1)
inline float dpps_v8sf(const float a[8],const float b[8]);

inline void row_swap(__v4sf *a, __v4sf *b);
#else

#if(FP == 1)
inline void dct_naive(float a[][8], float b[][8]);
inline float alpha(const uint8_t alpha);
inline float compute_dct(const uint8_t u, const uint8_t v, float a[][8]);
#endif

#if(FP == 0)
inline void dct_aan(float a[][8],float b[][8]);
#endif

#endif


void inline dct_fast(float a[][8]);
