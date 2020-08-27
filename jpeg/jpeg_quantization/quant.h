#ifndef __xmmintrin_h__
#if (__SSE__ == 1 && __AVX__ == 0)
#include <xmmintrin.h>
#endif
#endif

#ifndef __immintrin_h__
#if (__SSE__ == 1 && __AVX__ == 1)
#include <immintrin.h>
#endif
#endif

#ifndef __stdint_h__
#include <stdint.h>
#endif

const float luminance[8][8] = 
{
   {16.0, 11.0, 10.0, 16.0, 124.0, 140.0, 151.0, 161.0},
   {12.0, 12.0, 14.0, 19.0, 126.0, 158.0, 160.0, 155.0},
   {14.0, 13.0, 16.0, 24.0, 140.0, 157.0, 169.0, 156.0},
   {14.0, 17.0, 22.0, 29.0, 151.0, 187.0, 180.0, 162.0},
   {18.0, 22.0, 37.0, 56.0, 168.0, 109.0, 103.0, 177.0},
   {24.0, 35.0, 55.0, 64.0, 181.0, 104.0, 113.0, 192.0},
   {49.0, 64.0, 78.0, 87.0, 103.0, 121.0, 120.0, 101.0},
   {72.0, 92.0, 95.0, 98.0, 112.0, 100.0, 103.0, 199.0}
};

const float chrominance[8][8] = 
{
   {17.0, 18.0, 24.0, 47.0, 99.0, 99.0, 99.0, 99.0},
   {18.0, 21.0, 26.0, 66.0, 99.0, 99.0, 99.0, 99.0},
   {24.0, 26.0, 56.0, 99.0, 99.0, 99.0, 99.0, 99.0},
   {47.0, 66.0, 99.0, 99.0, 99.0, 99.0, 99.0, 99.0},
   {99.0, 99.0, 99.0, 99.0, 99.0, 99.0, 99.0, 99.0},
   {99.0, 99.0, 99.0, 99.0, 99.0, 99.0, 99.0, 99.0},
   {99.0, 99.0, 99.0, 99.0, 99.0, 99.0, 99.0, 99.0},
   {99.0, 99.0, 99.0, 99.0, 99.0, 99.0, 99.0, 100.0}
};

/*
 * Max input range of these functions should be around (+/-)2040 (assuming 24 bit pixel representation),
 * max output should be between (+)128 and (-128)
 */

#if (__SSE__ == 1 && __AVX__ == 0)
inline __v4si quant(const __v4sf numerator, const __v4sf quant_denominator);
#endif

#if (__AVX__ == 1)
inline __v8si quant(const __v8sf numerator, const __v8sf quant_denominator);
#endif

#if (__AVX__ == 0 && __SSE__ == 0)
inline int32_t quant(const float numerator, const float quant_denominator);
#endif

