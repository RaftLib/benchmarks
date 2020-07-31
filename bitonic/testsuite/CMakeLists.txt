#INCLUDE_DIRECTORIES( test_test_exe ${PROJECT_SOURCE_DIR})

# test
##
# Set variable for where we want the test file to be
##
#set( EXPECTED_TEST "${PROJECT_SOURCE_DIR}/tests/expected_test.txt" )
##
# have CMAKE replace all instances of @ in the source with variables
# from CMAKE (keep in mind it'll only use the variables that are in
# scope from this point. 
##
#configure_file ("test_test_shell.cpp" "test_test.cpp" @ONLY)
##
# now your exe is in the build dir ready to be compiled with the 
# name test_test.cpp vs. the prototype name of test_test_shell
##
#ADD_EXECUTABLE(test_test_exe test_test.cpp)
#TARGET_LINK_LIBRARIES(test_test_exe PUBLIC streamcluster_static)
#ADD_TEST(test_test test_test_exe)
#
#IF (MULTI_TESTS)
#ADD_EXECUTABLE(test_test_multi_exe test_test_multi.cpp)
#TARGET_LINK_LIBRARIES(test_test_multi_exe PUBLIC streamcluster_static)
#ADD_TEST(test_test_multi test_test_multi_exe)
#ENDIF ()

