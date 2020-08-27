/**
 * ParallelAdd.tcc - 
 * @author: Jonathan Beard
 * @version: Sun Jul 20 08:27:54 2014
 * 
 * Copyright 2014 Jonathan Beard
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
#ifndef _PARALLELADD_TCC_
#define _PARALLELADD_TCC_  1
#include <array>

template< typename T, size_t SIZE > struct ParallelAddStruct
{
   size_t                start_index;
   size_t                length;
   std::array< T, SIZE > a;
   std::array< T, SIZE > b;
};

template< typename T, size_t SIZE > struct ParallelAddOutputStruct
{
   size_t                start_index;
   size_t                length;
   std::array< T, SIZE > output;
};

#endif /* END _PARALLELADD_TCC_ */
