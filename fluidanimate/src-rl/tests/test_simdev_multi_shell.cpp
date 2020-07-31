#include <cstring>
#include <cstdlib>
#include "raftlib_src.hpp"
#include "fluidcmp.hpp"

// This test uses the "simdev" runconfig
// This is equivalent to calling ./fluidanimate 4 3 in_15K.fluid output_simdev.fluid
int main()
{
    (void) timeStep;
    char* argv[] = {strdup("./fluidanimate"), strdup("4"), strdup("3"), strdup("@IN_15K@"), strdup("output_simdev.fluid")};
    fluidanimate(5, argv);

    char* argv2[] = {strdup("./fluidcmp"), strdup("output_simdev.fluid"), strdup("@EXPECTED_SIMDEV@")};
    int result = fluidcmp(3, argv2);

    if (result != 0)
        return EXIT_FAILURE;
    
    return EXIT_SUCCESS;
}
