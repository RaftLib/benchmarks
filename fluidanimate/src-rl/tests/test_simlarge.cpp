#include "../raftlib_src.hpp"
#include "../fluidcmp.hpp"

// This test uses the "simlarge" runconfig
// This is equivalent to calling ./fluidanimate 1 5 in_300K.fluid output_simlarge.fluid
int main()
{
    char* argv[] = {"./fluidanimate", "1", "5", "../../tests/in_300K.fluid", "output_simlarge.fluid"};
    fluidanimate(5, argv);

    char* argv2[] = {"./fluidcmp", "output_simlarge.fluid", "../../tests/expected_simlarge.fluid"};
    int result = fluidcmp(3, argv2);

    if (result != 0)
        return EXIT_FAILURE;
    
    return EXIT_SUCCESS;
}
