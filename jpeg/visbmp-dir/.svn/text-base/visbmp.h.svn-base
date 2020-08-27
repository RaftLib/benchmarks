#ifndef __stdlib_h__
#include <stdlib.h>
#endif

#ifndef __stdio_h__
#include <stdio.h>
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

#ifndef SUCCESS
#define SUCCESS 1
#endif

#ifndef FAIL
#define FAIL -1
#endif

struct ap_visbmp_data {
   FILE *r;
   FILE *g;
   FILE *b;
   uint8_t init;
};

void ap_visbmp_init(struct ap_visbmp_data *block);
void ap_visbmp_destroy(struct ap_visbmp_data *block);
void ap_visbmp_push(struct ap_visbmp_data *block, int port, void *ptr, int count);
int ap_visbmp_go(struct ap_visbmp_data *block);
void ap_visbmp_push_signal(struct ap_visbmp_data *block, int port, int type, int value);

inline uint8_t r(uint8_t y, uint8_t cb, uint8_t cr);
inline uint8_t g(uint8_t y, uint8_t cb, uint8_t cr);
inline uint8_t b(uint8_t y, uint8_t cb, uint8_t cr);
