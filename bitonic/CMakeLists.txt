# Needs to be changed appropriately
CMAKE_MINIMUM_REQUIRED (VERSION 3.10 FATAL_ERROR)

SET(MULTI_TESTS 0 CACHE BOOL "If set, builds the multi-threaded tests.")
SET(NATIVE_TESTS 0 CACHE BOOL "If set, builds the native input set tests.")

PROJECT(bitonic CXX)

SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W -Wall -Wextra -Wpedantic -std=gnu++17")

FIND_PACKAGE(PkgConfig REQUIRED)

PKG_CHECK_MODULES(RAFTLIB REQUIRED IMPORTED_TARGET raftlib )
PKG_CHECK_MODULES(CMDARGS REQUIRED IMPORTED_TARGET cmdargs )

add_subdirectory( src )

enable_testing()
add_subdirectory(testsuite)
