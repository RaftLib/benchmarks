block readbmp{
   output UNSIGNED32 dimensions;

   output UNSIGNED64 red_pixels;
   output UNSIGNED64 green_pixels;
   output UNSIGNED64 blue_pixels;

   config STRING image_file;
};
platform C{
   impl readbmp (base="readbmp");
};

/*
platform VHDLSim{
};
platform HDL_Brutus{
};
*/
