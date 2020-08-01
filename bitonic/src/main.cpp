/**
 * main.cpp - 
 * @author: Jonathan Beard
 * @version: Fri Jul 31 11:49:31 2020
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

#include <cstdlib>
#include <cstdio>
#include <cstdint>
#include <cmd>

#include "defs.hpp"
#include "bitonic_seq.hpp"
#include "bitonic_utilities.hpp"

int main(int argc, char **argv) 
{
    CmdArgs  cmd( argv[ 0 ],
                  std::cout,
                  std::cerr );

    bool help( false );
    cmd.addOption( new Option< bool >( help,
                                       "-h",
                                       "Print this message",
                                       false ) );


    std::string filename( "none" );
    cmd.addOption( new Option< std::string >( filename,
                                              "-f",
                                              "Set the input file name",
                                              true /** make this arg mandatory **/ ) );

    
    /** give object command line **/
    cmd.processArgs( argc, argv );
    
    /** handle the user needing help **/
    if( help )
    {
       cmd.printArgs();
       exit( EXIT_SUCCESS );
    }
    /** 
     * to check and see if all mandatory args are set, add this code
     * which will print all mandatory args that are missing.
     */
    if( ! cmd.allMandatorySet() )
    { 
       exit( EXIT_FAILURE );
    }
    

    FILE *fp = std::fopen( filename.c_str(), "r" );
    if( fp == nullptr ) 
    {
      std::fprintf(stderr,"file not found\n");
      std::exit( EXIT_FAILURE );
    }
    bitonic::type_t n( 0 );
    // first line gives number of numbers to be sorted 
    std::fscanf( fp, "%" PRI_T "", &n );
    // allocate space and read all the numbers 
    auto *arr = (bitonic::type_t*) malloc( n * sizeof(bitonic::type_t) );
    for( auto i( 0 ); i < n; i++) 
    {
        std::fscanf( fp,"%" PRI_T "", &arr[ i ] );
    }
    // print array before 

    bitonic::utilities::printArray( arr, n );

    // do merges
    for( auto s( 2 ); s <= n; s*=2 ) 
    {
        for( auto i( 0 ); i < n; i += s*2 ) 
        {
            bitonic::sequential::merge_up((     arr+i),     s);
            bitonic::sequential::merge_down((   arr+i+s),   s);
        }
    }

    bitonic::utilities::printArray(arr,n);
}
