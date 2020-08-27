// add x block map includes here
#include "readbmp.x"
#include "visbmp.x"

block top {
   readbmp bmp(image_file="tree.bmp");
   visbmp vis;

   e0: bmp.dimensions -> vis.dimensions;
   e1: bmp.red_pixels -> vis.red_pixels;
   e2: bmp.green_pixels -> vis.green_pixels;
   e3: bmp.blue_pixels -> vis.blue_pixels;
};

use top app;
