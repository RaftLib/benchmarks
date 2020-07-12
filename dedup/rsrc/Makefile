include ../../parseclibs/Makefile.parsec
NTHREADS = 1

CXX:=g++
CXXFLAGS = -static -Wno-pointer-arith -fpermissive `pkg-config --cflags raftlib` -I${PARSEC_INC}/openssl/include -DENABLE_BZIP2_COMPRESSION
LIB = `pkg-config --libs raftlib` -L${PARSEC_LIB}/openssl/lib -lssl -lcrypto -lbz2

TARGET = dedup

all: $(TARGET)

$(TARGET): $(TARGET).cpp
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(TARGET).cpp $(LIB)  
	
run:
	./$(TARGET) -c -p -v -t ${NTHREADS} -i ../inputs/hamlet.dat -o output.dat.ddp 

clean:	
	rm -f *.o $(TARGET)

