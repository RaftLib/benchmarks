LIBDIR=/home/local/bumblebee/masri/RaftLib/build/raft/lib
INCLUDEDIR=/home/local/bumblebee/masri/RaftLib/build/raft/include  
SHMINC = /home/local/bumblebee/masri/RaftLib/git-dep/shm/include
SSLLIB=  /home/local/bumblebee/masri/parsec-benchmark/pkgs/libs/lib
SSLINC=  /home/local/bumblebee/masri/parsec-benchmark/pkgs/libs/include

CC = g++
CFLAGS = -std=c++14 -fpermissive -DL1D_CACHE_LINE_SIZE=64 -DPLATFORM_HAS_NUMA=0 -I${INCLUDEDIR} -I${SHMINC} -I${SSLINC}
LIB = -L${LIBDIR} -lraft -lshm -laffinity -ldemangle -lpthread -lrt -L${SSLLIB} -lssl

TARGET = dedup

all: $(TARGET)

$(TARGET): $(TARGET).cpp
	$(CC) $(CFLAGS) -o $(TARGET) $(TARGET).cpp $(LIB)  
	
clean:	
	rm $(TARGET)

