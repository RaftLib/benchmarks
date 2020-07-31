/**
 * bitonic_seq.hpp - 
 * @author: Jonathan Beard
 * @version: Fri Jul 31 12:21:11 2020
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
#ifndef BITONIC_SEQ_HPP
#define BITONIC_SEQ_HPP  1

namespace bitonic
{


struct sequential
{

static void merge_up( bitonic::type_t *arr, const bitonic::type_t n );

static void merge_down( type_t *arr, const bitonic::type_t n );

    

};

} /** end namespace bitonic **/

#endif /* END BITONIC_SEQ_HPP */
