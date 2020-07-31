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
#include <cstdint>
#include "bitonic_seq.hpp"

int main(int argc, char **argv) 
{
  bitonic::type_t n( 0 ), *arr( nullptr ), i( 0 ), s( 0 );

  FILE *fp = std::fopen( argv[1],"r" );

  if( fp == nullptr ) 
  {
    std::fprintf(stderr,"file not found\n");
    std::exit( EXIT_FAILURE );
  }
  // first line gives number of numbers to be sorted 
  std::fscanf( fp, "%" PRI_T "", &n );
  // allocate space and read all the numbers 
  arr = (bitonic::type_t*) malloc( n * sizeof(bitonic::type_t) );
  for (i=0; i < n; i++) {
    fscanf(fp,"%" PRI_T "",(arr+i));
  }
  // print array before 
  bitonic::sequential::printArray( arr, n );

  // do merges
    for (s=2; s <= n; s*=2) 
    {
        for (i=0; i < n;) 
        {
            merge_up((arr+i),s);
            merge_down((arr+i+s),s);
            i += s*2;
        }
    }

    bitonic::sequential::printArray(arr,n);
}
