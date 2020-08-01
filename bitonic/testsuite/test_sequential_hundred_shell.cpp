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
#include <cstring>
#include <iostream>
#include "defs.hpp"
#include "bitonic_seq.hpp"
#include "bitonic_utilities.hpp"

int main() 
{
    bitonic::type_t     n( 0 ), 
                        *arr( nullptr );

    bitonic::type_t answer[] = {
        205826338,230576913,243953357,268030210,354764919,481163676,
        598995250,630823287,781162524,799631898,807345262,831670507,
        947316058,953650476,1250360403,1304412697,1388250469,1438459771,
        1476327771,1656725076,1794738059,1809254700,1834534273,1851945714,
        1888883274,1900549843,1930451400,2007301958,2043208701,2074183795,
        2087400369,2255233622,2276370069,2317761231,2359985714,2383784471,
        2502778490,2719236555,2728616291,2735551976,2826471891,2833960703,
        2875594080,2941014264,2942244603,3026457901,3340990796,3406824339,
        3442627700,3490458327,3493999924,3714097443,3743058814,3771842746,
        3840724844,3870074226,3949764375,4015798567,4068024007,4172440172,
        4183407158,4229162738,4240744593,4256797144,4175363867,4118824424,
        4031475315,3494639086,3449257607,3429227413,3239249010,3059575831,
        3017817433,2989655235,2895996691,2754997742,2675729078,2528837042,
        2296035598,2282128639,2260969824,1875046068,1777630105,1436056366,
        1217172505,1179861519,1136176472,964480267,961696352,830066622,
        775935342,775783154,766826566,622635242,612949625,592211215,357794415,
        257748855,132119601,122199753 };

    std::cout << "testing with file: \"@TEST_HUNDRED@\"\n";
    FILE *fp = std::fopen( "@TEST_HUNDRED@" ,"r" );

    if( fp == nullptr ) 
    {
      std::fprintf(stderr,"file not found\n");
      std::exit( EXIT_FAILURE );
    }
    // first line gives number of numbers to be sorted 
    std::fscanf( fp, "%" PRI_T "", &n );

    // allocate space and read all the numbers 
    const auto size_bytes( n * sizeof( bitonic::type_t ) );
    arr  = (bitonic::type_t*) malloc( size_bytes );
    for( auto i( 0 ); i < n; i++ ) 
    {
        std::fscanf(fp,"%" PRI_T "", &arr[ i ]);
    }
    


    // do merges
    for( auto s( 2 ); s <= n; s*=2 ) 
    {
        for( auto i( 0 ); i < n; i+= s*2 ) 
        {
            bitonic::sequential::merge_up((     arr+i),     s);
            bitonic::sequential::merge_down((   arr+i+s),   s);
        }
    }
    if( std::memcmp( arr, answer, size_bytes ) == 0 )
    {
        std::cout << "success\n";
        free( arr  );
        return( EXIT_SUCCESS );
    }
    std::cout << "failure\n";
    free( arr  );
    return( EXIT_FAILURE );
}
