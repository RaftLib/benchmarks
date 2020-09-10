#include <cstdio>
#include <cstdlib>
#include <unistd.h>
#include <cmd>

int main( int argc, char **argv, char **envp )
{
     
    CmdArgs cmdargs( argv[ 0 ] /** prog name  **/,
                     std::cout /** std stream **/,
                     std::cerr /** err stream **/ );
    
    bool help( false );
    cmdargs.addOption( new Option< bool >( help,
                                           "-h",
                                           "print this message" ) );
    
    std::string appname( "none");
    cmdargs.addOption( new Option< std::string >( appname,
                                          "-app",
                                          "set this to the app name",
                                          true ) );
    
    std::string arguments( "none" );
    cmdargs.addOption( new Option< std::string >( arguments,
                                                  "-args",
                                                  "set this to be the arguments to pass in, format is -args \"argument strings just like you'd pass on cmd line\"",
                                                  false /** required **/ ) );


    std::string envparams( "none" );
    cmdargs.addOption( new Option< std::string >( envparams,
                                                  "-env",
                                                  "set this for the env params to exec",
                                                  false /** required **/ ) );
    /** process args **/
    cmdargs.processArgs( argc, argv );
    if( help || ! cmdargs.allMandatorySet() )
    {
        cmdargs.printArgs();
        exit( EXIT_SUCCESS );
    }
   
    
    const char * const args[] = { "foobar" , nullptr };

    //now run app
    execve( appname.c_str(), args, envp );
    return( EXIT_SUCCESS );
}
