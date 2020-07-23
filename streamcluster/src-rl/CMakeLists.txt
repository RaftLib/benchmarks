# Needs to be changed appropriately
CMAKE_MINIMUM_REQUIRED (VERSION 3.10 FATAL_ERROR)

SET(MULTI_TESTS 0 CACHE BOOL "If set, builds the multi-threaded tests.")
SET(NATIVE_TESTS 0 CACHE BOOL "If set, builds the native input set tests.")

PROJECT(streamcluster CXX)

SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W -Wall -Wextra -Wpedantic -std=gnu++17")

FIND_PACKAGE(PkgConfig REQUIRED)

PKG_CHECK_MODULES(RAFTLIB REQUIRED IMPORTED_TARGET raftlib)

ADD_LIBRARY(streamcluster_static STATIC streamcluster.cpp kernels.cpp)
TARGET_LINK_LIBRARIES(streamcluster_static PUBLIC PkgConfig::RAFTLIB)

ADD_EXECUTABLE(streamcluster main.cpp)
TARGET_LINK_LIBRARIES(streamcluster PUBLIC streamcluster_static)

ENABLE_TESTING()
ADD_SUBDIRECTORY(tests)