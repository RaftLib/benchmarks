/**
 * test_swap.cpp - 
 * @author: Jonathan Beard
 * @version: Sat Aug  1 15:39:35 2020
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

#include <iostream>
#include "bitonic_swap.hpp"


int main()
{

    int a = 97;
    int b = 98;

    bitonic::swap( a, b );
    std::cout << "a is now: " << (char)a << "\n";
    std::cout << "b is now: " << (char)b << "\n";
    if( (char)a == 'b' && (char)b == 'a' )
    {
        return( EXIT_SUCCESS );
    }
    return( EXIT_FAILURE );
}
