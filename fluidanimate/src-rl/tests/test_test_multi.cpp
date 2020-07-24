#include "../raftlib_src.hpp"
#include "../fluidcmp.hpp"

// This test uses the "test" runconfig
// This is equivalent to calling ./fluidanimate 4 1 in_5K.fluid output_test.fluid
int main()
{
    char* argv[] = {"./fluidanimate", "4", "1", "../../tests/in_5K.fluid", "output_test.fluid"};
    fluidanimate(5, argv);

    char* argv2[] = {"./fluidcmp", "output_test.fluid", "../../tests/expected_test.fluid"};
    int result = fluidcmp(3, argv2);

    if (result != 0)
        return EXIT_FAILURE;
    
    return EXIT_SUCCESS;
}
