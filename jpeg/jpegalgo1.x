// add x block map includes here
#include "readbmp.x"
#include "rgb2ycbcr.x"
//#include "dct_jpeg.x"
#include "visbmp.x"

block top {
   readbmp bmp(image_file="/tmp/tree.bmp");
   rgb2ycbcr ycbcr;
   visbmp vis;

   e0: bmp.dimensions -> ycbcr.dim_in;
   e1: bmp.red_pixels -> ycbcr.red_pixels;
   e2: bmp.green_pixels -> ycbcr.green_pixels;
   e3: bmp.blue_pixels -> ycbcr.blue_pixels;
   e4: ycbcr.dim_out ->vis.dimensions;
   e5: ycbcr.Y -> vis.red_pixels;
   e6: ycbcr.Cb -> vis.green_pixels;
   e7: ycbcr.Cr -> vis.blue_pixels;
};

use top app;
