CC = gcc
CFLAGS ?= -Wall -O3 -msse4.2 -lm

all: main.c
	$(CC) $(CFLAGS) $(INC) -o quant main.c quant.c

clean:
	rm -f quant
