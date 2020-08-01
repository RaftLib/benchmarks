# Needs to be changed appropriately
cmake_minimum_required (VERSION 3.10 FATAL_ERROR)

set(MULTI_TESTS 0 CACHE BOOL "If set, builds the multi-threaded tests.")
set(NATIVE_TESTS 0 CACHE BOOL "If set, builds the native input set tests.")

project(bitonic CXX)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W -Wall -Wextra -Wpedantic -std=gnu++17")

find_package(PkgConfig REQUIRED)

PKG_CHECK_MODULES(RAFTLIB REQUIRED IMPORTED_TARGET raftlib )
PKG_CHECK_MODULES(CMDARGS REQUIRED IMPORTED_TARGET cmdargs )

include_directories( include )
add_subdirectory( src )

enable_testing()
add_subdirectory(testsuite)
