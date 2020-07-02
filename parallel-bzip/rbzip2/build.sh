#!/usr/bin/env bash

CLEANCMD="rm -rf *.o rbzip2"

if [ "$1" == clean ]; then
    echo "Cleaning"
    eval $CLEANCMD
    exit
elif [ "$1" != build ]; then
    echo "Invalid option, should be clean or build"
    exit
fi

LBZ2=$(apt list --installed | grep -o libbz2-dev )
CXXFLAGS="`pkg-config --cflags raftlib` -O3 -mtune=native"
LIBS=`pkg-config --libs raftlib`
CXX=g++
BUILDCMD="$CXX $CXXFLAGS rbzip2.cpp -o rbzip2 $LIBS -lbz2"

if [ "$LBZ2" != libbz2-dev ]; then
    echo "Plesase install libbz2-dev"
    `sudo apt install libbz2-dev`
fi


eval $BUILDCMD
exit
