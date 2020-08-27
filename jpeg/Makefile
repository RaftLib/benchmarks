#x mapping goes here
XCODE=jpegmap1.x

FLAGS = -O0 -ggdb -march=native -mtune=native -msse4.1
#FLAGS = -O0 -ggdb -march=opteron -mtune=opteron -msse2

USER_CFLAGS=$(FLAGS)
USER_CXXFLAGS=$(FLAGS)
C_BLOCKS=readbmp rgb2ycbcr dct_jpeg
FPGA_BLOCKS=
LOCAL_C_BLOCKS=visbmp
LOCAL_FPGA_BLOCKS=
include ../makefiles/main.makefile

