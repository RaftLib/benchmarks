# Needs to be changed appropriately
CMAKE_MINIMUM_REQUIRED (VERSION 3.10 FATAL_ERROR)

PROJECT(streamcluster CXX)

SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W -Wall -Wextra -Wpedantic -std=gnu++17")

FIND_PACKAGE(PkgConfig REQUIRED)

PKG_CHECK_MODULES(RAFTLIB REQUIRED IMPORTED_TARGET raftlib)

ADD_EXECUTABLE(streamcluster streamcluster.cpp kernels.cpp)

TARGET_LINK_LIBRARIES(streamcluster PUBLIC PkgConfig::RAFTLIB)