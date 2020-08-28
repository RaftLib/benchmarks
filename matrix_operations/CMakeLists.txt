# Needs to be changed appropriately
CMAKE_MINIMUM_REQUIRED (VERSION 3.10 FATAL_ERROR)

SET(MULTI_TESTS  0 CACHE BOOL "If set, builds the multi-threaded tests.")
SET(NATIVE_TESTS 0 CACHE BOOL "If set, builds the native input set tests.")

PROJECT(mm CXX)

SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W -Wall -Wextra -Wpedantic -std=gnu++17")

FIND_PACKAGE(PkgConfig REQUIRED)

PKG_CHECK_MODULES(RAFTLIB REQUIRED IMPORTED_TARGET raftlib)

include_directories( include )
add_subdirectory( src )

#ENABLE_TESTING()
#ADD_SUBDIRECTORY(testsuite)
