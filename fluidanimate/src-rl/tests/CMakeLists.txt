INCLUDE_DIRECTORIES( test_test_exe ${PROJECT_SOURCE_DIR})
INCLUDE_DIRECTORIES( test_test_multi_exe ${PROJECT_SOURCE_DIR})
INCLUDE_DIRECTORIES( test_simsmall_exe ${PROJECT_SOURCE_DIR})
INCLUDE_DIRECTORIES( test_simsmall_multi_exe ${PROJECT_SOURCE_DIR})
INCLUDE_DIRECTORIES( test_simmedium_exe ${PROJECT_SOURCE_DIR})
INCLUDE_DIRECTORIES( test_simmedium_multi_exe ${PROJECT_SOURCE_DIR})
INCLUDE_DIRECTORIES( test_simlarge_exe ${PROJECT_SOURCE_DIR})
INCLUDE_DIRECTORIES( test_simlarge_multi_exe ${PROJECT_SOURCE_DIR})
INCLUDE_DIRECTORIES( test_simdev_exe ${PROJECT_SOURCE_DIR})
INCLUDE_DIRECTORIES( test_simdev_multi_exe ${PROJECT_SOURCE_DIR})
INCLUDE_DIRECTORIES( test_native_exe ${PROJECT_SOURCE_DIR})
INCLUDE_DIRECTORIES( test_native_multi_exe ${PROJECT_SOURCE_DIR})

# test
##
# Set variable for where we want the test file to be
##
set( EXPECTED_TEST "${PROJECT_SOURCE_DIR}/tests/expected_test.fluid" )
set( EXPECTED_SIMSMALL "${PROJECT_SOURCE_DIR}/tests/expected_simsmall.fluid" )
set( EXPECTED_SIMMEDIUM "${PROJECT_SOURCE_DIR}/tests/expected_simmedium.fluid" )
set( EXPECTED_SIMLARGE "${PROJECT_SOURCE_DIR}/tests/expected_simlarge.fluid" )
set( EXPECTED_SIMDEV "${PROJECT_SOURCE_DIR}/tests/expected_simdev.fluid" )
set( EXPECTED_NATIVE "${PROJECT_SOURCE_DIR}/tests/expected_native.fluid" )

set( IN_5K "${PROJECT_SOURCE_DIR}/tests/in_5K.fluid" )
set( IN_15K "${PROJECT_SOURCE_DIR}/tests/in_15K.fluid" )
set( IN_35K "${PROJECT_SOURCE_DIR}/tests/in_35K.fluid" )
set( IN_100K "${PROJECT_SOURCE_DIR}/tests/in_100K.fluid" )
set( IN_300K "${PROJECT_SOURCE_DIR}/tests/in_300K.fluid" )
set( IN_500K "${PROJECT_SOURCE_DIR}/tests/in_500K.fluid" )
##
# have CMAKE replace all instances of @ in the source with variables
# from CMAKE (keep in mind it'll only use the variables that are in
# scope from this point. 
##
configure_file ("test_test_shell.cpp" "test_test.cpp" @ONLY)
configure_file ("test_test_multi_shell.cpp" "test_test_multi.cpp" @ONLY)
configure_file ("test_simsmall_shell.cpp" "test_simsmall.cpp" @ONLY)
configure_file ("test_simsmall_multi_shell.cpp" "test_simsmall_multi.cpp" @ONLY)
configure_file ("test_simmedium_shell.cpp" "test_simmedium.cpp" @ONLY)
configure_file ("test_simmedium_multi_shell.cpp" "test_simmedium_multi.cpp" @ONLY)
configure_file ("test_simlarge_shell.cpp" "test_simlarge.cpp" @ONLY)
configure_file ("test_simlarge_multi_shell.cpp" "test_simlarge_multi.cpp" @ONLY)
configure_file ("test_native_shell.cpp" "test_native.cpp" @ONLY)
configure_file ("test_native_multi_shell.cpp" "test_native_multi.cpp" @ONLY)
configure_file ("test_simdev_shell.cpp" "test_simdev.cpp" @ONLY)
configure_file ("test_simdev_multi_shell.cpp" "test_simdev_multi.cpp" @ONLY)
##
# now your exe is in the build dir ready to be compiled with the 
# name test_test.cpp vs. the prototype name of test_test_shell
##
ADD_EXECUTABLE(test_test_exe test_test.cpp)
TARGET_LINK_LIBRARIES(test_test_exe PUBLIC fluidanimate_static)
ADD_TEST(test_test test_test_exe)

IF (MULTI_TESTS)
ADD_EXECUTABLE(test_test_multi_exe test_test_multi.cpp)
TARGET_LINK_LIBRARIES(test_test_multi_exe PUBLIC fluidanimate_static)
ADD_TEST(test_test_multi test_test_multi_exe)
ENDIF ()

#simsmall
ADD_EXECUTABLE(test_simsmall_exe test_simsmall.cpp)
TARGET_LINK_LIBRARIES(test_simsmall_exe PUBLIC fluidanimate_static)
ADD_TEST(test_simsmall test_simsmall_exe)

IF (MULTI_TESTS)
ADD_EXECUTABLE(test_simsmall_multi_exe test_simsmall_multi.cpp)
TARGET_LINK_LIBRARIES(test_simsmall_multi_exe PUBLIC fluidanimate_static)
ADD_TEST(test_simsmall_multi test_simsmall_multi_exe)
ENDIF ()

#simmedium
ADD_EXECUTABLE(test_simmedium_exe test_simmedium.cpp)
TARGET_LINK_LIBRARIES(test_simmedium_exe PUBLIC fluidanimate_static)
ADD_TEST(test_simmedium test_simmedium_exe)

IF (MULTI_TESTS)
ADD_EXECUTABLE(test_simmedium_multi_exe test_simmedium_multi.cpp)
TARGET_LINK_LIBRARIES(test_simmedium_multi_exe PUBLIC fluidanimate_static)
ADD_TEST(test_simmedium_multi test_simmedium_multi_exe)
ENDIF ()

#simlarge
ADD_EXECUTABLE(test_simlarge_exe test_simlarge.cpp)
TARGET_LINK_LIBRARIES(test_simlarge_exe PUBLIC fluidanimate_static)
ADD_TEST(test_simlarge test_simlarge_exe)

IF (MULTI_TESTS)
ADD_EXECUTABLE(test_simlarge_multi_exe test_simlarge_multi.cpp)
TARGET_LINK_LIBRARIES(test_simlarge_multi_exe PUBLIC fluidanimate_static)
ADD_TEST(test_simlarge_multi test_simlarge_multi_exe)
ENDIF ()

#simdev
ADD_EXECUTABLE(test_simdev_exe test_simdev.cpp)
TARGET_LINK_LIBRARIES(test_simdev_exe PUBLIC fluidanimate_static)
ADD_TEST(test_simdev test_simdev_exe)

IF (MULTI_TESTS)
ADD_EXECUTABLE(test_simdev_multi_exe test_simdev_multi.cpp)
TARGET_LINK_LIBRARIES(test_simdev_multi_exe PUBLIC fluidanimate_static)
ADD_TEST(test_simdev_multi test_simdev_multi_exe)
ENDIF ()

IF (NATIVE_TESTS)
    #native
    ADD_EXECUTABLE(test_native_exe test_native.cpp)
    TARGET_LINK_LIBRARIES(test_native_exe PUBLIC fluidanimate_static)
    ADD_TEST(test_native test_native_exe)

    IF (MULTI_TESTS)
    ADD_EXECUTABLE(test_native_multi_exe test_native_multi.cpp)
    TARGET_LINK_LIBRARIES(test_native_multi_exe PUBLIC fluidanimate_static)
    ADD_TEST(test_native_multi test_native_multi_exe)
    ENDIF ()

ENDIF ()