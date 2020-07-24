#include "../raftlib_src.hpp"
#include "../fluidcmp.hpp"

// This test uses the "simmedium" runconfig
// This is equivalent to calling ./fluidanimate 4 5 in_100K.fluid output_simmedium.fluid
int main()
{
    char* argv[] = {"./fluidanimate", "4", "5", "../../tests/in_100K.fluid", "output_simmedium.fluid"};
    fluidanimate(5, argv);

    char* argv2[] = {"./fluidcmp", "output_simmedium.fluid", "../../tests/expected_simmedium.fluid"};
    int result = fluidcmp(3, argv2);

    if (result != 0)
        return EXIT_FAILURE;
    
    return EXIT_SUCCESS;
}
