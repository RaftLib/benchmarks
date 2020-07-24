#include "../raftlib_src.hpp"
#include "../fluidcmp.hpp"

// This test uses the "test" runconfig
// This is equivalent to calling ./fluidanimate 1 1 in_5K.fluid output_test.fluid
int main()
{
    std::cout << "Made it this far" << std::endl;

    char* argv[] = {strdup("./fluidanimate"), strdup("1"), strdup("1"), strdup("../../tests/in_5K.fluid"), strdup("output_test.fluid")};
    fluidanimate(5, argv);

    char* argv2[] = {strdup("./fluidcmp"), strdup("output_test.fluid"), strdup("../../tests/expected_test.fluid")};
    int result = fluidcmp(3, argv2);

    if (result != 0)
        return EXIT_FAILURE;
    
    return EXIT_SUCCESS;
}
