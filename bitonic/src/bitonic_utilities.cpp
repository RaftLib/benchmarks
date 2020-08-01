/**
 * bitonic_utilities.cpp - just things that'll 
 * be used by all the various versions of the 
 * bitonic sort benchmark. If possible these will 
 * all be relatively generic, meaning that many
 * will just be templates, non-template stuff
 * of course goes here. 
 * 
 * @author: Jonathan Beard
 * @version: Fri Jul 31 12:36:24 2020
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
#include <cstdio>
#include "defs.hpp"
#include "bitonic_utilities.hpp"

void 
bitonic::utilities::printArray( bitonic::type_t *arr, const std::size_t  n) 
{
    std::printf("[%" PRI_T "",arr[0]);
    for( std::size_t i( 1 ); i < n; i++)
    {
        std::printf(",%" PRI_T "",arr[i]);
    }
    std::printf("]\n");
}
