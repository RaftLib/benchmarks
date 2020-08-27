#include <stdint.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <string.h>
#include <unistd.h>
#include <math.h>

#ifndef __X_h__
#include "X.h"
#endif

#ifndef GOMORE
#define GOMORE 0
#endif

#ifndef GOSTOP
#define GOSTOP 1
#endif

#ifndef SUCCESS
#define SUCCESS 0
#endif

#ifndef FAIL
#define FAIL -1
#endif

#define DIM_OUT 0
#define Y_OUT 1
#define CB_OUT 2
#define CR_OUT 3

#define DIM_IN 0
#define R_IN 1
#define G_IN 2
#define B_IN 3

#define BUFFERBYTELENGTH 2048

typedef float v4sf __attribute__ ((vector_size(16)));

typedef char buffer_length __attribute ((vector_size(BUFFERBYTELENGTH)));

typedef union{
   v4sf v;
   float a[4];
}vector_f4;

typedef struct{
   vector_f4 Y;
   vector_f4 Cb;
   vector_f4 Cr;
}conversion_constants;

struct ap_rgb2ycbcr_data {
   vector_f4 store;

   uint8_t init;

   conversion_constants constant;

   //****all these guys get allocated
   //****to 2KB buffers
   uint8_t *buffer_r;
   uint8_t *buffer_g;
   uint8_t *buffer_b;

   uint8_t *addr_r;
   uint8_t *addr_g;
   uint8_t *addr_b;
};


void ap_rgb2ycbcr_init(struct ap_rgb2ycbcr_data *block);
void ap_rgb2ycbcr_destroy(struct ap_rgb2ycbcr_data *block);
void ap_rgb2ycbcr_push(struct ap_rgb2ycbcr_data *block, int port, void *ptr, int count);
int ap_rgb2ycbcr_go(struct ap_rgb2ycbcr_data *block);
void ap_rgb2ycbcr_push_signal(struct ap_rgb2ycbcr_data *block, int port, int type, int value);

