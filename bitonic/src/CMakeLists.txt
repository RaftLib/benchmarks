set( CMAKE_INCLUDE_CURRENT_DIR ON )


add_library( bitonicdyn bitonic_seq.cpp )

target_link_libraries( bitonicdyn PUBLIC PkgConfig::RAFTLIB )

add_executable( bitonic main.cpp )
target_link_libraries( bitonic PUBLIC bitonicdyn )

