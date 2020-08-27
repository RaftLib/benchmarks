CC = gcc
CFLAGS ?= -Wall -O3 -msse4.2 -lm

dct: main.c
	$(CC) $(CFLAGS) $(INC) -o dct main.c dct.c

dct_ass: main.c 
	$(CC) $(CFLAGS) -S -o dct.s main.c dct.c

clean:
	rm -f dct
