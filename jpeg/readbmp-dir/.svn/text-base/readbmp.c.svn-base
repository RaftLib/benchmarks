#define DEBUG 0

#ifndef __stdio_h__
#include <stdio.h>
#endif

#ifndef __stdlib_h__
#include <stdlib.h>
#endif

#ifndef __stdint_h__
#include <stdint.h>
#endif

#ifndef __mman_h__
#include <sys/mman.h>
#endif

#ifndef __string_h__
#include <string.h>
#endif

#ifndef __fcntl_h__
#include <fcntl.h>
#endif

#ifndef __types_h__
#include <sys/types.h>
#endif

#ifndef __stat_h__
#include <sys/stat.h>
#endif

#ifndef __unistd_h__
#include <unistd.h>
#endif

#ifndef __inttypes_h__
#include <inttypes.h>
#endif

#ifndef __errno_h__
#include <errno.h>
#endif

#ifndef __math_h__
#include <math.h>
#endif

#ifndef __readbmp_h__
#include "readbmp.h"
#endif

#define RED 1
#define GREEN 2
#define BLUE 3

void ap_readbmp_init(struct ap_readbmp_data *block)
{
   //stat file, get size & check file type
   struct stat st;
   
   uint64_t fd = open(block->image_file,O_RDONLY);
   
   if(fd == FAIL){
      const char* message = "Error!! Couldn't open file.\n";
      perror(message);
      exit(FAIL);
   }

   if(fstat(fd,&st) != SUCCESS){
      const char *err = "ERROR, could not stat file!!\n";
      perror(err);
      exit(FAIL);
   }else{
      if(!S_ISREG(st.st_mode)){
         fprintf(stderr,"File isn't regular...please check, exiting!!\n");
         exit(FAIL);
      }
   }

   //get file descriptor, add head to unsigned 8 bit pointer
   uint8_t *file_address = (uint8_t*) malloc(sizeof(uint8_t));
   file_address = mmap(NULL,st.st_size,PROT_READ,MAP_PRIVATE,fd,0);

   if(file_address == MAP_FAILED){
      const char *message = "ERROR, couldn't map input file!!\n";
      perror(message);
      exit(FAIL);
   }
   close(fd);

   //allocate height * width
   block->height = (uint16_t*) malloc(sizeof(uint16_t));
   block->width = (uint16_t*) malloc(sizeof(uint16_t));
   if(block->height == NULL || block->width == NULL){
      fprintf(stderr,"Error allocating height or width!!\n");
      exit(FAIL);
   }
   //check and see if bmp is in fact a bmp, we don't care about keeping these characters
   if(*((char*)file_address) != 'B'){ 
      fprintf(stderr,"File isn't a correctly formatted BMP!!\n");
      exit(FAIL);
   }
   if(*((char*)(file_address + 1)) != 'M'){
      fprintf(stderr,"File isn't a properly formatted BMP!!\n");
      exit(FAIL);
   }
#if (DEBUG == 1)
   fprintf(stderr,"file size: %"PRIu32"\n",*((uint32_t*) (file_address + 2)));
   fprintf(stderr,"pixel location: %"PRIu32"\n",*((uint32_t*)(file_address + 10)));
   fprintf(stderr,"header size: %"PRIu32"\n",*((uint32_t*)(file_address + 14)));
#endif
   //lets get the width, the next 16 bits
   *block->width = *((uint16_t*)(file_address + 18));
#if (DEBUG == 1)
   fprintf(stderr,"read width: %"PRIx16"\n",*block->width);
#endif
   *block->height = *((uint16_t*)(file_address + 22));
#if (DEBUG == 1)
   fprintf(stderr,"read height: %"PRIx16"\n",*block->height);
#endif
#if (DEBUG == 1)
   fprintf(stderr,"colors: %"PRIu16"\n",*((uint16_t*)(file_address + 25)));
   fprintf(stderr,"bits per pixel %"PRIu16"\n",*((uint16_t*)(file_address + 28)));
   fprintf(stderr,"first pixel %x\n",*((uint8_t*) (file_address + *((uint32_t*)(file_address+10)))));
#endif


   block->buffer_size = (*block->height * *block->width) + 3;
   block->red = mmap(NULL,block->buffer_size,(PROT_READ | PROT_WRITE),(MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS),-1,0);
   if(block->red == MAP_FAILED){
      const char *message = "ERROR, couldn't map red buffer!!\n";
      perror(message);
      exit(FAIL);
   }
   block->green = mmap(NULL,block->buffer_size,(PROT_READ | PROT_WRITE),(MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS),-1,0);
   if(block->green == MAP_FAILED){
      const char *message = "ERROR, couldn't map green buffer!!\n";
      perror(message);
      exit(FAIL);
   }
   block->blue = mmap(NULL,block->buffer_size,(PROT_READ | PROT_WRITE),(MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS),-1,0);
   if(block->blue == MAP_FAILED){
      const char *message = "ERROR, couldn't map blue buffer!!\n";
      perror(message);
      exit(FAIL);
   }

   //****************seperate RGB channels **************
   block->red_offset = 0;
   block->green_offset = 0;
   block->blue_offset = 0;
   void (**channel_function)(struct ap_readbmp_data*,void*) = (void*) malloc(3 * sizeof(void));
   uint8_t *channelstate = (uint8_t*) alloca(sizeof(uint8_t));
   *channelstate = 0;
   uint64_t *pixel_count = (uint64_t*) alloca(sizeof(uint64_t));
   *pixel_count = *block->height * *block->width * 3;
   channel_function[0] = &get_blue;
   channel_function[1] = &get_green;
   channel_function[2] = &get_red;
   uint8_t *file_tail = (uint8_t *) malloc(sizeof(uint8_t));
   file_tail = (file_address + *((uint32_t*)(file_address + 10)));
   while(*pixel_count > 0)
   {
      channel_function[*channelstate](block,file_tail);
      file_tail = file_tail + 1;
      *channelstate = (*channelstate + 1) % 3;
      --(*pixel_count);
   }
   free(channel_function);

   //get rid of file buffer
   if(munmap(file_address,st.st_size)){
      fprintf(stderr,"Failed to unmap file buffer!!\n");
      exit(FAIL);
   }

   //****************start timer here********************
   UNSIGNED32 *dim = (UNSIGNED32*) ap_allocate(block,0,1);
   if(dim == NULL){
      fprintf(stderr,"dim not allocated!!\n");
      ap_readbmp_destroy(block);
      exit(FAIL);
   } 
   *dim+=*block->width;
   *dim = *dim << 16;
   *dim += *block->height;
   ap_send(block,0,1);

   block->red_offset = block->buffer_size;
   block->green_offset = block->buffer_size;
   block->blue_offset = block->buffer_size;

   block->red_tail = (uint8_t*) malloc(sizeof(uint8_t));
   block->green_tail = (uint8_t*) malloc(sizeof(uint8_t));
   block->blue_tail = (uint8_t*) malloc(sizeof(uint8_t));

   block->red_tail = block->red;
   block->blue_tail = block->blue;
   block->green_tail = block->green;
};

void ap_readbmp_destroy(struct ap_readbmp_data *block)
{
   free(block->width);
   free(block->height);
   if(munmap(block->red,block->buffer_size)){
      fprintf(stderr,"Error unmapping red buffer!!\n");
   }
   if(munmap(block->green,block->buffer_size)){
      fprintf(stderr,"Error unmapping green buffer!!\n");
   }
   if(munmap(block->blue,block->buffer_size)){
      fprintf(stderr,"Error unmapping blue buffer!!\n");
   }
   
};

void ap_readbmp_push(struct ap_readbmp_data *block, int port, void *ptr, int count)
{
};

int ap_readbmp_go(struct ap_readbmp_data *block)
{
   if(block->red_offset > 0)
   {
      int max_red = ap_get_max_send(block,RED) * sizeof(UNSIGNED64);
      if(max_red > 0){
         if(block->red_offset < max_red)
            max_red = block->red_offset;
         const int ap_red_size = ceil(max_red / sizeof(UNSIGNED64));
         void *red_ptr = ap_allocate(block,RED,ap_red_size);
         memcpy(red_ptr, block->red_tail,max_red);
         ap_send(block,RED,ap_red_size);
         block->red_tail = block->red_tail + max_red;
         block->red_offset -= max_red;
      }
   }
   if(block->green_offset > 0)
   {
      int max_green = ap_get_max_send(block,GREEN) * sizeof(UNSIGNED64);
      if(max_green > 0){
         if(block->green_offset < max_green)
            max_green = block->green_offset;
         const int ap_green_size = ceil(max_green / sizeof(UNSIGNED64));
         void *green_ptr = ap_allocate(block,GREEN,ap_green_size);
         memcpy(green_ptr,block->green_tail,max_green);
         ap_send(block,GREEN, ap_green_size);
         block->green_tail = block->green_tail + max_green;
         block->green_offset -= max_green;
      }
   }
   if(block->blue_offset > 0)
   {
      int max_blue = ap_get_max_send(block,BLUE) * sizeof(UNSIGNED64);
      if(max_blue > 0){
         if(block->blue_offset < max_blue)
            max_blue = block->blue_offset;
         const int ap_blue_size = ceil(max_blue / sizeof(UNSIGNED64));
         void *blue_ptr = ap_allocate(block,BLUE,ap_blue_size);
         memcpy(blue_ptr,block->blue_tail,max_blue);
         ap_send(block,BLUE,ap_blue_size);
         block->blue_tail = block->blue_tail + max_blue;
         block->blue_offset -= max_blue;
      }
    } 
    if(block->blue_offset == 0 && block->green_offset == 0 && block->red_offset == 0)
    {
      return (GOSTOP);
    }
    else
    {
#if (DEBUG == 1)
      fprintf(stderr,"r: %"PRIu64" g: %"PRIu64" b: %"PRIu64"\n",block->red_offset, block->green_offset, block->blue_offset);
#endif
      return (GOMORE);
    }
};

void ap_readbmp_push_signal(struct ap_readbmp_data *block, int port, int type, int value)
{
};

void get_red(struct ap_readbmp_data *block, void *file_buffer)
{
   *((uint8_t*)(block->red + block->red_offset)) = *((uint8_t*)file_buffer);
   block->red_offset += 1;
};

void get_green(struct ap_readbmp_data *block, void *file_buffer)
{
   *((uint8_t*)(block->green + block->green_offset)) = *((uint8_t*)file_buffer);
   block->green_offset += 1;
};

void get_blue(struct ap_readbmp_data *block, void *file_buffer)
{
   *((uint8_t*)(block->blue + block->blue_offset)) = *((uint8_t*)file_buffer);
   block->blue_offset += 1;
};
