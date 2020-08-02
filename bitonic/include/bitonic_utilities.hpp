/**
 * bitonic_utilities.hpp - 
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
#ifndef BITONIC_UTILITIES_HPP
#define BITONIC_UTILITIES_HPP  1
#include <cstddef>

namespace bitonic
{

struct utilities
{
    /**
     * printArray - simple help function to print the array. 
     * @param   arr - bitonic::type_t*, array of type_t
     * @param   n   - length of arr.
     */
    static void print_array( bitonic::type_t *arr, const std::size_t n);
   
    static std::size_t get_length( FILE *fp );
};

} /** end namespace bitonic **/
#endif /* END BITONIC_UTILITIES_HPP */
