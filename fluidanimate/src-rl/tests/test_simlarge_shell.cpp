#include "raftlib_src.hpp"
#include "fluidcmp.hpp"

// This test uses the "simlarge" runconfig
// This is equivalent to calling ./fluidanimate 1 5 in_300K.fluid output_simlarge.fluid
int main()
{
    char* argv[] = {strdup("./fluidanimate"), strdup("1"), strdup("5"), strdup("@IN_300K@"), strdup("output_simlarge.fluid")};
    fluidanimate(5, argv);

    char* argv2[] = {strdup("./fluidcmp"), strdup("output_simlarge.fluid"), strdup("@EXPECTED_SIMLARGE@")};
    int result = fluidcmp(3, argv2);

    if (result != 0)
        return EXIT_FAILURE;
    
    return EXIT_SUCCESS;
}
