#include "raftlib_src.hpp"
#include "fluidcmp.hpp"

// This test uses the "native" runconfig
// This is equivalent to calling ./fluidanimate 1 500 in_500K.fluid output_native.fluid
int main()
{
    (void) timeStep;
    char* argv[] = {strdup("./fluidanimate"), strdup("1"), strdup("500"), strdup("@IN_500K@"), strdup("output_native.fluid")};
    fluidanimate(5, argv);

    char* argv2[] = {strdup("./fluidcmp"), strdup("output_native.fluid"), strdup("@EXPECTED_NATIVE@")};
    int result = fluidcmp(3, argv2);

    if (result != 0)
        return EXIT_FAILURE;
    
    return EXIT_SUCCESS;
}
