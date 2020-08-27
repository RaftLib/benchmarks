CC ?= gcc
JCC ?= javac
JAR ?= jar
FLAGS ?= -Wall -O2
JFLAGS ?= -g
JARFLAGS ?= -cfe
vis: ./bmpvis/VisMain.java
	$(JCC) $(JFLAGS) ./bmpvis/VisMain.java $(LIBS)
	$(JAR) $(JARFLAGS) bmpvis.jar bmpvis.VisMain bmpvis

clean:
	rm -f ./bmpvis/*.class bmpvis.jar
