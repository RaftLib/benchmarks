block rgb2ycbcr{
   input UNSIGNED32 dim_in;
   input UNSIGNED64 red_pixels;
   input UNSIGNED64 green_pixels;
   input UNSIGNED64 blue_pixels;

   output UNSIGNED32 dim_out; //just a pass through incase, port 0
   
   output UNSIGNED64 Y; //port 1
   output UNSIGNED64 Cb; //port 2
   output UNSIGNED64 Cr; //port 3

};
platform C{
   impl rgb2ycbcr (base="rgb2ycbcr");
};
platform HDL_Brutus{
   impl rgb2ycbcr (base="rgb2ycbcr");
};
