/**
 * bitonic_utilities.cpp - 
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
#include "defs.hpp"
#include "bitonic_utilities.hpp"

void 
bitonic::utilities::printArray( bitonic::type_t *arr, const std::size_t  n) 
{
    printf("[%" PRI_T "",arr[0]);
    for( auto i( 1 ); i < n; i++)
    {
        printf(",%" PRI_T "",arr[i]);
    }
    printf("]\n");
}
