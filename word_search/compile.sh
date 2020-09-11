#!/usr/bin/env bash

g++ -std=gnu++17 `pkg-config --cflags raftlib` -O3 -mtune=native $1.cpp -o $1 `pkg-config --libs raftlib`
