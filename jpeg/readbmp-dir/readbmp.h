#ifndef __stdint_h__
#include <stdint.h>
#endif

#ifndef __X_h__
#include "X.h"
#endif

#ifndef GOMORE
#define GOMORE 0
#endif

#ifndef GOSTOP
#define GOSTOP 1
#endif

#ifndef FAIL
#define FAIL -1
#endif

#ifndef SUCCESS
#define SUCCESS 0
#endif

struct ap_readbmp_data {
   //internal vars
   uint16_t *width;
   uint16_t *height;
 
   //file memory address pointer, once set don't change you need this
   uint8_t *red;
   uint8_t *green;
   uint8_t *blue;

   uint8_t *red_tail;
   uint8_t *blue_tail;
   uint8_t *green_tail;

   uint64_t red_offset;
   uint64_t green_offset;
   uint64_t blue_offset;

   uint32_t buffer_size;

   //config
   STRING image_file;
};

void ap_readbmp_init(struct ap_readbmp_data *block);

void ap_readbmp_destroy(struct ap_readbmp_data *block);

void ap_readbmp_push(struct ap_readbmp_data *block, int port, void *ptr, int count);

int ap_readbmp_go(struct ap_readbmp_data *block);

void ap_readbmp_push_signal(struct ap_readbmp_data *block, int port, int type, int value);

void get_red(struct ap_readbmp_data *block,void *file_buffer);

void get_green(struct ap_readbmp_data *block,void *file_buffer);

void get_blue(struct ap_readbmp_data *block, void *file_buffer);
