#include "raftlib_src.hpp"
#include "fluidcmp.hpp"

// This test uses the "simmedium" runconfig
// This is equivalent to calling ./fluidanimate 1 5 in_100K.fluid output_simmedium.fluid
int main()
{
    char* argv[] = {strdup("./fluidanimate"), strdup("1"), strdup("5"), strdup("@IN_100K@"), strdup("output_simmedium.fluid")};
    fluidanimate(5, argv);

    char* argv2[] = {strdup("./fluidcmp"), strdup("output_simmedium.fluid"), strdup("@EXPECTED_SIMMEDIUM@")};
    int result = fluidcmp(3, argv2);

    if (result != 0)
        return EXIT_FAILURE;
    
    return EXIT_SUCCESS;
}
