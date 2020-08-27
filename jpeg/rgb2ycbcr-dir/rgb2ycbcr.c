/**
 * @Author: Jonathan Beard
 * @Version: Last Modified 11 Jan 2012
 * @E-mail: jonathan.c.beard@gmail.com
 */

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <string.h>
#include <alloca.h>

#include "rgb2ycbcr.h"

#ifndef DEBUG
#define DEBUG 0
#endif

/*forward decl*/
#if (__SSE4_1__)
typedef float VECTORFLOAT __attribute__((vector_size(16)));
#elif (__SSE2__)
typedef float VECTORFLOAT __attribute__((vector_size(16)));
#else
typedef float VECTORFLOAT;
#endif
//converts to one pixel of y,cb,cr from rgb
inline float convertpixel(VECTORFLOAT rgb_vector, VECTORFLOAT constants);
#if (__SSE4_1__)
inline float convertpixel(VECTORFLOAT rgb_vector, VECTORFLOAT constants)
{
   float out = 0.0f;
   __asm__ volatile("\
      movdqa      %[input_xmm0], %%xmm0            \n\
      movdqa      %[input_xmm1], %%xmm1            \n\
      dpps        $255, %%xmm1, %%xmm0             \n\
      extractps   $1, %%xmm0, %[output_float]"
      :
      [output_float] "=r" (out) /*output value*/
      :
      [input_xmm0] "m" (rgb_vector),
      [input_xmm1] "m" (constants)
      :"xmm0","xmm1" /*clobbered regs*/
   );
   return out;
}
#elif (__SSE2__)
inline float convertpixel(VECTORFLOAT rgb_vector, VECTORFLOAT constants)
{
   /* man it'd be nice if amd thought about an extract instruction */
   float out = 0.0f;
   VECTORFLOAT outputxmm0 = (VECTORFLOAT){0.0,0.0,0.0,0.0}; 
   __asm__ volatile("\
      movdqa   %[input_xmm0], %%xmm0               \n\
      movdqa   %[input_xmm1], %%xmm1               \n\
      mulps    %%xmm0, %%xmm1                      \n\
      movdqa   %%xmm1, %[output_xmm0]"
      :
      [output_xmm0] "=m" (outputxmm0) /*array of floats*/
      :
      [input_xmm0] "m" (rgb_vector),
      [input_xmm1] "m" (constants)
      :
      "xmm0","xmm1"
   );
   int i;
   for(i = 0; i < 4; i++)
      out += *(((float*)&outputxmm0) + i);
   return out;
}
#else
/* do without vectors */
inline float convertpixel(VECTORFLOAT rgb_vector, VECTORFLOAT constants)
{
   float out = 0.0f;
   float *a = &rgb_vector;
   float *b = &constants;
   int i;
   for(i = 0; i < 4; i++)
   {
      out += *(a+i) * *(b+i);
   }
   return out;
}
#endif


void ap_rgb2ycbcr_init(struct ap_rgb2ycbcr_data *block)
{
   int64_t zero = open("/dev/zero",O_RDWR);
   if(zero == FAIL){
      fprintf(stderr,"Couldn't open dev zero!!");
      exit(FAIL);
   }
  
   block->addr_r = block->buffer_r = mmap(NULL,BUFFERBYTELENGTH,(PROT_READ | PROT_WRITE), (MAP_PRIVATE | MAP_LOCKED), zero, 0);
   if(block->buffer_r == MAP_FAILED){
      const char *err = "failed to initialize buffer_r!!\n";
      perror(err);
      exit(FAIL);
   }

   block->addr_g = block->buffer_g = mmap(NULL,BUFFERBYTELENGTH,(PROT_READ | PROT_WRITE), (MAP_PRIVATE | MAP_LOCKED), zero, 0);
   if(block->buffer_g == MAP_FAILED){
      const char *err = "failed to initialize buffer_g!!\n";
      perror(err);
      exit(FAIL);
   }

   
   //do level shift here
   float y[4] = {.299,.587,.144,-128};
   float cb[4] = {-.1687,-.3313,.5,0};
   float cr[4] = {.5,-.4187,-.0813,0};
   float store[4] = {[3] = 1};

   uint8_t i;
   for(i = 0; i<4; i++){
      block->constant.Y.a[i] = y[i];
      block->constant.Cb.a[i] = cb[i];
      block->constant.Cr.a[i] = cr[i];
      block->store.a[i] = store[i];
   }

   block->addr_b = block->buffer_b = mmap(NULL,BUFFERBYTELENGTH,(PROT_READ | PROT_WRITE), (MAP_PRIVATE | MAP_LOCKED), zero, 0);
   if(block->buffer_b == MAP_FAILED){
      const char *err = "failed to initialize buffer_b!!\n";
      perror(err);
      exit(FAIL);
   }

   if(close(zero) == FAIL){
      const char *err = "failed to close /dev/zero\n";
      perror(err);
      exit(FAIL);
   }

   block->init = 0;

};

void ap_rgb2ycbcr_destroy(struct ap_rgb2ycbcr_data *block)
{
   //unmap buffers
   if(munmap(block->addr_r,BUFFERBYTELENGTH) == FAIL){
      const char *err = "failed to unmap addr_r!!\n";
      perror(err);
      exit(FAIL);
   }
   if(munmap(block->addr_g,BUFFERBYTELENGTH) == FAIL){
      const char *err = "failed to unmap addr_g!!\n";
      perror(err);
      exit(FAIL);
   }
   if(munmap(block->addr_b,BUFFERBYTELENGTH) == FAIL){
      const char *err = "failed to unmap addr_b!!\n";
      perror(err);
      exit(FAIL);
   }
};

void ap_rgb2ycbcr_push(struct ap_rgb2ycbcr_data *block, int port, void *ptr, int count)
{
   if(block->init == 0){ 
      UNSIGNED32 *dim = (UNSIGNED32*) ap_get_input_data(block,DIM_IN);
      if(dim != NULL){
         UNSIGNED32 *out_dim = (UNSIGNED32*) ap_allocate(block,DIM_OUT,1);
         *out_dim = *dim;
         ap_release(block,DIM_IN,1);
         ap_send(block,DIM_OUT,1);
         block->init = 1;
      }
   }
   if(block->init == 1){
   void *red_in = ap_get_input_data(block,R_IN);
   void *green_in = ap_get_input_data(block,G_IN);
   void *blue_in = ap_get_input_data(block,B_IN);
   if(red_in != NULL && green_in != NULL && blue_in != NULL){
      int32_t max_in_red = ap_get_input_count(block,R_IN) * sizeof(UNSIGNED64);
      int32_t max_in_green = ap_get_input_count(block,G_IN) * sizeof(UNSIGNED64);
      int32_t max_in_blue = ap_get_input_count(block,B_IN) * sizeof(UNSIGNED64);

      size_t transfer_size = BUFFERBYTELENGTH;
      if(max_in_red < transfer_size)
         transfer_size = max_in_red;
      if(max_in_green < transfer_size)
         transfer_size = max_in_green;
      if(max_in_blue < transfer_size)
         transfer_size = max_in_blue;

      //allocate output ports, lets only take in as much as we can spit out
      int32_t max_out_y = ap_get_max_send(block,Y_OUT) * sizeof(UNSIGNED64);
      int32_t max_out_cb = ap_get_max_send(block,CB_OUT) * sizeof(UNSIGNED64);
      int32_t max_out_cr = ap_get_max_send(block,CR_OUT) * sizeof(UNSIGNED64);

      
      if(max_out_y < transfer_size)
         transfer_size = max_out_y;
      if(max_out_cb < transfer_size)
         transfer_size = max_out_cb;
      if(max_out_cr < transfer_size)
         transfer_size = max_out_cr;

      uint32_t count_transfer_size = ceil((transfer_size) / sizeof(UNSIGNED64));

      //allocate output ports
      UNSIGNED8 *Y = (UNSIGNED8*) ap_allocate(block,Y_OUT,count_transfer_size);
      UNSIGNED8 *Cb = (UNSIGNED8*) ap_allocate(block,CB_OUT, count_transfer_size);
      UNSIGNED8 *Cr = (UNSIGNED8*) ap_allocate(block,CR_OUT, count_transfer_size);
   
      //buffers are now ready to go 
      memcpy(block->buffer_r,red_in,transfer_size);
      memcpy(block->buffer_g,green_in,transfer_size);
      memcpy(block->buffer_b,blue_in,transfer_size);
   
      ap_release(block,R_IN,count_transfer_size);
      ap_release(block,G_IN,count_transfer_size);
      ap_release(block,B_IN,count_transfer_size);

      
      uint32_t transfer_index;
      
      __builtin_prefetch(&(block->constant.Y),0,3);
      __builtin_prefetch(&(block->constant.Cb),0,3);
      __builtin_prefetch(&(block->constant.Cr),0,3);
      __builtin_prefetch(((buffer_length*)block->buffer_r),0,3);
      __builtin_prefetch(((buffer_length*)block->buffer_g),0,3);
      __builtin_prefetch(((buffer_length*)block->buffer_b),0,3);
      __builtin_prefetch(((buffer_length*)Y),1,3);
      __builtin_prefetch(((buffer_length*)Cb),1,3);
      __builtin_prefetch(((buffer_length*)Cr),1,3);
      
      for(transfer_index = 0; transfer_index < transfer_size; transfer_index++){
         //load aligned sequence
         __builtin_prefetch(&(block->store),1,3);
         block->store.a[0] = (float) *((uint8_t*)block->buffer_r);
         block->store.a[1] = (float) *((uint8_t*)block->buffer_g);
         block->store.a[2] = (float) *((uint8_t*)block->buffer_b);
         __builtin_prefetch(&(block->store),0,3);
         *((uint8_t*) Y) = (uint8_t) convertpixel(block->store.v,block->constant.Y.v); 
         *((uint8_t*) Cb) = (uint8_t) convertpixel(block->store.v, block->constant.Cb.v);
         *((uint8_t*) Cr) = (uint8_t) convertpixel(block->store.v, block->constant.Cr.v);
         
         ++(block->buffer_r);
         ++(block->buffer_g);
         ++(block->buffer_b);
         Y = Y + 1;
         Cb = Cb + 1;
         Cr = Cr + 1;
      }

      ap_send(block,Y_OUT,count_transfer_size);
      ap_send(block,CB_OUT, count_transfer_size);
      ap_send(block,CR_OUT, count_transfer_size);
      block->buffer_r = block->addr_r;
      block->buffer_g = block->addr_g;
      block->buffer_b = block->addr_b;
   }
   }
};

int ap_rgb2ycbcr_go(struct ap_rgb2ycbcr_data *block)
{
   return (GOSTOP);
};

void ap_rgb2ycbcr_push_signal(struct ap_rgb2ycbcr_data *block, int port, int type, int value)
{
   
};


