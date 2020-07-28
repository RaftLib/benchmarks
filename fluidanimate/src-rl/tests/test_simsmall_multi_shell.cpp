#include "raftlib_src.hpp"
#include "fluidcmp.hpp"

// This test uses the "simsmall" runconfig
// This is equivalent to calling ./fluidanimate 4 5 in_35K.fluid output_simsmall.fluid
int main()
{
    char* argv[] = {strdup("./fluidanimate"), strdup("4"), strdup("5"), strdup("@IN_35K@"), strdup("output_simsmall.fluid")};
    fluidanimate(5, argv);

    char* argv2[] = {strdup("./fluidcmp"), strdup("output_simsmall.fluid"), strdup("@EXPECTED_SIMSMALL@")};
    int result = fluidcmp(3, argv2);

    if (result != 0)
        return EXIT_FAILURE;
    
    return EXIT_SUCCESS;
}
