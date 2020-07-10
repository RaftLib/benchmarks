include ../../parseclibs/Makefile.parsec

CXX:=g++
CXXFLAGS = -static -Wno-pointer-arith -fpermissive `pkg-config --cflags raftlib` -I${PARSEC_INC}/openssl/include

LIB = `pkg-config --libs raftlib` -L${PARSEC_LIB}/openssl/lib -lssl -lcrypto

TARGET = dedup

all: $(TARGET)

$(TARGET): $(TARGET).cpp
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(TARGET).cpp $(LIB)  
	
clean:	
	rm -f *.o $(TARGET)

