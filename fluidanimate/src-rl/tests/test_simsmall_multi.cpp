#include "../raftlib_src.hpp"
#include "../fluidcmp.hpp"

// This test uses the "simsmall" runconfig
// This is equivalent to calling ./fluidanimate 4 5 in_35K.fluid output_simsmall.fluid
int main()
{
    char* argv[] = {"./fluidanimate", "4", "5", "../../tests/in_35K.fluid", "output_simsmall.fluid"};
    fluidanimate(5, argv);

    char* argv2[] = {"./fluidcmp", "output_simsmall.fluid", "../../tests/expected_simsmall.fluid"};
    int result = fluidcmp(3, argv2);

    if (result != 0)
        return EXIT_FAILURE;
    
    return EXIT_SUCCESS;
}
