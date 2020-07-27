INCLUDE_DIRECTORIES( test_test_exe ${PROJECT_SOURCE_DIR})

# test
##
# Set variable for where we want the test file to be
##
set( EXPECTED_TEST "${PROJECT_SOURCE_DIR}/tests/expected_test.txt" )
##
# have CMAKE replace all insstances of @ in the source with variables
# from CMAKE (keep in mind it'll only use the variables that are in
# scope from this point. 
##
configure_file ("test_test_shell.cpp" "test_test.cpp" @ONLY)
##
# now your exe is in the build dir ready to be compiled with the 
# name test_test.cpp vs. the prototype name of test_test_shell
##
ADD_EXECUTABLE(test_test_exe test_test.cpp)
TARGET_LINK_LIBRARIES(test_test_exe PUBLIC streamcluster_static)
ADD_TEST(test_test test_test_exe)

IF (MULTI_TESTS)
ADD_EXECUTABLE(test_test_multi_exe test_test_multi.cpp)
TARGET_LINK_LIBRARIES(test_test_multi_exe PUBLIC streamcluster_static)
ADD_TEST(test_test_multi test_test_multi_exe)
ENDIF ()

#simsmall
ADD_EXECUTABLE(test_simsmall_exe test_simsmall.cpp)
TARGET_LINK_LIBRARIES(test_simsmall_exe PUBLIC streamcluster_static)
ADD_TEST(test_simsmall test_simsmall_exe)

IF (MULTI_TESTS)
ADD_EXECUTABLE(test_simsmall_multi_exe test_simsmall_multi.cpp)
TARGET_LINK_LIBRARIES(test_simsmall_multi_exe PUBLIC streamcluster_static)
ADD_TEST(test_simsmall_multi test_simsmall_multi_exe)
ENDIF ()

#simmedium
ADD_EXECUTABLE(test_simmedium_exe test_simmedium.cpp)
TARGET_LINK_LIBRARIES(test_simmedium_exe PUBLIC streamcluster_static)
ADD_TEST(test_simmedium test_simmedium_exe)

IF (MULTI_TESTS)
ADD_EXECUTABLE(test_simmedium_multi_exe test_simmedium_multi.cpp)
TARGET_LINK_LIBRARIES(test_simmedium_multi_exe PUBLIC streamcluster_static)
ADD_TEST(test_simmedium_multi test_simmedium_multi_exe)
ENDIF ()

#simlarge
ADD_EXECUTABLE(test_simlarge_exe test_simlarge.cpp)
TARGET_LINK_LIBRARIES(test_simlarge_exe PUBLIC streamcluster_static)
ADD_TEST(test_simlarge test_simlarge_exe)

IF (MULTI_TESTS)
ADD_EXECUTABLE(test_simlarge_multi_exe test_simlarge_multi.cpp)
TARGET_LINK_LIBRARIES(test_simlarge_multi_exe PUBLIC streamcluster_static)
ADD_TEST(test_simlarge_multi test_simlarge_multi_exe)
ENDIF ()

#simdev
ADD_EXECUTABLE(test_simdev_exe test_simdev.cpp)
TARGET_LINK_LIBRARIES(test_simdev_exe PUBLIC streamcluster_static)
ADD_TEST(test_simdev test_simdev_exe)

IF (MULTI_TESTS)
ADD_EXECUTABLE(test_simdev_multi_exe test_simdev_multi.cpp)
TARGET_LINK_LIBRARIES(test_simdev_multi_exe PUBLIC streamcluster_static)
ADD_TEST(test_simdev_multi test_simdev_multi_exe)
ENDIF ()

IF (NATIVE_TESTS)
    #native
    ADD_EXECUTABLE(test_native_exe test_native.cpp)
    TARGET_LINK_LIBRARIES(test_native_exe PUBLIC streamcluster_static)
    ADD_TEST(test_native test_native_exe)

    IF (MULTI_TESTS)
    ADD_EXECUTABLE(test_native_multi_exe test_native_multi.cpp)
    TARGET_LINK_LIBRARIES(test_native_multi_exe PUBLIC streamcluster_static)
    ADD_TEST(test_native_multi test_native_multi_exe)
    ENDIF ()

ENDIF ()
