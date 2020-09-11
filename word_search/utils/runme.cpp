#include <cstdio>
#include <cstdlib>
#include <unistd.h>
#include <cmd>
#include <climits>
#include <cassert>
#include <sstream>

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
   
    std::vector< const char* >  args_new;
    args_new.push_back( appname.c_str() );
    if( arguments.compare( "none" ) != 0 )
    {
        args_new.push_back( arguments.c_str() );
    }
    args_new.push_back( nullptr );
    args_new.shrink_to_fit();


    auto *cwd( getcwd( nullptr, 0 ) );
    assert( cwd != nullptr );
    std::stringstream ss;
    ss << cwd << "/" << appname;
    //FIXME, we should check to make sure the file exists. 
    
    std::vector< const char* >  envp_new;

    while( *envp != nullptr )
    {
        
        envp_new.push_back( *envp );
        envp++;
    }
    if( envparams.compare( "none" ) != 0 )
    {
        envparams.shrink_to_fit();
        envp_new.push_back( envparams.c_str() );
    }
    envp_new.push_back( nullptr );
    envp_new.shrink_to_fit();

    envp = nullptr;

    //now run app
    execve( ss.str().c_str(), 
            const_cast< char * const *>( args_new.data() ), 
            const_cast< char * const *>( envp_new.data() ) );
    return( EXIT_SUCCESS );
}
