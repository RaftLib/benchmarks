#include "streamcluster.hpp"

// This test uses the "native" runconfig
// This is equivalent to calling ./streamcluster 10 20 128 1000000 200000 5000 none output.txt 1

// Random seed value
constexpr static std::uint8_t SEED = 1;

int main()
{
    // Set the random seed
    srand48(SEED);

    // Create the stream
    PStream* stream = new SimStream(1000000);

    // Set the filename (to avoid issues with const char* conversion)
    char filename[18];
    strcpy(filename, "output_native.txt");
    filename[17] = '\0';

    // Perform streamCluster, will output to the given filename
    streamCluster(stream, 10, 20, 128, 200000, 5000, filename, 1);

    // Delete the stream
    delete stream;

    // Compare the actual output to the expected output
    std::ifstream actualStream("output_native.txt");
    std::ifstream expectedStream("@EXPECTED_NATIVE@");

    if (actualStream && expectedStream)
    {
        std::vector<std::string> actualLines;
        for (std::string line; getline(actualStream, line);)
            actualLines.push_back(line);

        std::vector<std::string> expectedLines;
        for (std::string line; getline(expectedStream, line);)
            expectedLines.push_back(line);

        if (actualLines.size() != expectedLines.size())
        {
            std::cout << "Number of lines in each file does not match!" << std::endl;
        }

        for (long unsigned int i = 0; i < actualLines.size(); i++)
            if (actualLines[i].compare(expectedLines[i]) != 0)
                return EXIT_FAILURE;
    }   
    else
    {
        std::cerr << "Failed to open output file!" << std::endl;
        return EXIT_FAILURE;
    }
    
    return EXIT_SUCCESS;
}