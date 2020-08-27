CC = gcc
CFLAGS ?= -Wall -O3 -msse4.2 -lm

all: main.c
	$(CC) $(CFLAGS) $(INC) -o zigzag main.c zigzag.c

clean:
	rm -f zigzag
