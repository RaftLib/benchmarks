#ifndef __X_h__
#include "X.h"
#endif
#ifndef APMORE
#define APMORE 0
#endif

#ifndef APSTOP
#define APSTOP 1
#endif

struct ap_dct_jpeg_data {
};
void ap_dct_jpeg_init(struct ap_dct_jpeg_data *block);
void ap_dct_jpeg_destroy(struct ap_dct_jpeg_data *block);
void ap_dct_jpeg_push(struct ap_dct_jpeg_data *block, int port, void *ptr, int count);
int ap_dct_jpeg_go(struct ap_dct_jpeg_data *block);
void ap_dct_jpeg_push_signal(struct ap_dct_jpeg_data *block, int port, int type, int value);
