#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <stdint.h>
#include <inttypes.h>
#include <endian.h>
#include <string.h>
#include "visbmp.h"

#define DEBUG 0
#define FILEDUMP 1

#define RED 1
#define GREEN 2
#define BLUE 3

void ap_visbmp_init(struct ap_visbmp_data *block) 
{
   block->b = fopen("/tmp/blue.dat","w");
   if(block->b == NULL){
      fprintf(stderr,"blue err!!\n");
      exit(-1);
   }
   block->r = fopen("/tmp/red.dat","w");
   if(block->r == NULL){
      fprintf(stderr,"red err\n");
      exit(-1);
   }
   block->g = fopen("/tmp/green.dat","w");
   if(block->g == NULL){
      fprintf(stderr,"green err\n");
      exit(-1);
   }
   block->init = 0;
}

void ap_visbmp_destroy(struct ap_visbmp_data *block) 
{
   fflush(block->r);
   fflush(block->g);
   fflush(block->b);
   fclose(block->r);
   fclose(block->g);
   fclose(block->b);
}

void ap_visbmp_push(struct ap_visbmp_data *block,int port, void *ptr,int count) 
{
   
   void *blue = ap_get_input_data(block,BLUE);
   void *green = ap_get_input_data(block,GREEN);
   UNSIGNED32 *dimensions = (UNSIGNED32*) ap_get_input_data(block,0);
   void *red = ap_get_input_data(block,RED);
   if(dimensions != NULL && block->init == 0){
      block->init = 1;
      ap_release(block,0,1);
   }
   
   if(red != NULL && block->init == 1){
      const int max_red = ap_get_input_count(block,1);
      fwrite(red,8,max_red,block->r);
      fflush(block->r);
      ap_release(block,RED,max_red);
   }
   if(green != NULL && block->init == 1){
      const int max_green = ap_get_input_count(block,2);
      fwrite(green,8,max_green,block->g);
      fflush(block->g);
      ap_release(block,GREEN,max_green);
   }
   if(blue != NULL && block->init == 1){
      const int max_blue = ap_get_input_count(block,3);
      fwrite(blue,8,max_blue,block->b);
      fflush(block->b);
      ap_release(block,BLUE,max_blue);
   }

}

int ap_visbmp_go(struct ap_visbmp_data *block)
{
   return (GOSTOP); //nothing to gen here
}

void ap_visbmp_push_signal(struct ap_visbmp_data *block, int port, int type, int value)
{
}

inline uint8_t r(uint8_t y, uint8_t cb, uint8_t cr){
   return y+ 1.402 * (cr-128);
}

inline uint8_t g(uint8_t y, uint8_t cb, uint8_t cr){
   return y - (.34414 * (cb - 128)) - (.71414 * (cr - 128));
}

inline uint8_t b(uint8_t y, uint8_t cb, uint8_t cr){
   return y + 1.772 * (cb - 128);
}
