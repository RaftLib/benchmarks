/**
 * main.cpp - 
 * @author: Jonathan Beard
 * @version: Thu Aug 20 10:02:39 2020
 * 
 * Copyright 2020 Jonathan Beard
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <raft>
#include <cstdlib>
#include <cmd>
#include <string>

#include "matrix.tcc"

using thetype_t = float;

int main( int argc, char **argv )
{   
    CmdArgs cmdargs( argv[ 0 ] /** prog name  **/,
                     std::cout /** std stream **/,
                     std::cerr /** err stream **/ );

    bool help( false );
    /** set options **/
    cmdargs.addOption( new Option< bool >( help,
                                           "-h",
                                           "print this message" ) );
    std::string filename( "none" );
    cmdargs.addOption( new Option< std::string >( filename, 
                                                  "-f",
                                                  "filename with matrix, will always be MxM" ) );
    bool print_matrices( false );
    cmdargs.addOption( new Option< bool >( print_matrices,
                                           "-pmatrix",
                                           "print the input matrices" ) );
    
    /** process args **/
    cmdargs.processArgs( argc, argv );
    if( help || ! cmdargs.allMandatorySet() )
    {
        cmdargs.printArgs();
        exit( EXIT_SUCCESS );
    }
    
    auto *A( matrix< thetype_t >::initFromFile( filename ) );
    auto *B( matrix< thetype_t >::initFromFile( filename ) );
    //actual app goes here
    if( print_matrices )
    {
        A->print( std::cout, Format::SPACE ) << "\n\tx\n\n";
        B->print( std::cout, Format::SPACE ) << "\n";
    }
    
    delete( A );
    return( EXIT_SUCCESS );       
}
