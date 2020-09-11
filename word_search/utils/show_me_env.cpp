#include <cstdlib>
#include <cstdio>
#include <iostream>

int main( int argc, char **argv, char **envp )
{
    while( *envp != nullptr )
    {
        std::cout << *envp << "\n";
        envp++;
    }
    return( EXIT_SUCCESS );
}
