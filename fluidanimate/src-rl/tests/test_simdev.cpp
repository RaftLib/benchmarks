#include "../raftlib_src.hpp"
#include "../fluidcmp.hpp"

// This test uses the "simdev" runconfig
// This is equivalent to calling ./fluidanimate 1 3 in_15K.fluid output_simdev.fluid
int main()
{
    char* argv[] = {"./fluidanimate", "1", "3", "../../tests/in_15K.fluid", "output_simdev.fluid"};
    fluidanimate(5, argv);

    char* argv2[] = {"./fluidcmp", "output_simdev.fluid", "../../tests/expected_simdev.fluid"};
    int result = fluidcmp(3, argv2);

    if (result != 0)
        return EXIT_FAILURE;
    
    return EXIT_SUCCESS;
}
