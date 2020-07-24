#include "../raftlib_src.hpp"
#include "../fluidcmp.hpp"

// This test uses the "native" runconfig
// This is equivalent to calling ./fluidanimate 1 500 in_500K.fluid output_native.fluid
int main()
{
    char* argv[] = {"./fluidanimate", "1", "500", "../../tests/in_500K.fluid", "output_native.fluid"};
    fluidanimate(5, argv);

    char* argv2[] = {"./fluidcmp", "output_native.fluid", "../../tests/expected_native.fluid"};
    int result = fluidcmp(3, argv2);

    if (result != 0)
        return EXIT_FAILURE;
    
    return EXIT_SUCCESS;
}
