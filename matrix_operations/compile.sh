#!/usr/bin/env bash

g++ -std=gnu++17 `pkg-config --cflags raftlib` -O0 -g main.cpp -o mmult `pkg-config --libs raftlib`
