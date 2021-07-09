#!/usr/bin/env bash



TOP=`pwd`

echo "Building OpenSSL"
cd ${TOP}/openssl-src
echo "in `pwd`"
./Configure --prefix=${TOP}/openssl
make clean && make -j && make install
cd ..
