/**
 * bmh.cpp - 
 * @author: Jonathan Beard
 * @version: Sat Oct 17 10:36:03 2015
 * 
 * Copyright 2015 Jonathan Beard
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
#define VERSION2 1
#include <raft>
#include <raftio>
#include <cstdlib>
#include <cstdint>
#include <string>
#include <iterator>
#include <algorithm>
#include <chrono> 
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <sys/mman.h>
#include <fcntl.h>

template < class T > class search : public raft::kernel
{
public:
   search( const std::string && term ) : raft::kernel(),
                                         term_length( term.length() ),
                                         term( term )
   {
      input.addPort<  T >( "0" );
      output.addPort< std::size_t >( "0" );
   }
   
   search( const std::string &term ) : raft::kernel(),
                                       term_length( term.length() ),
                                       term( term )
   {
      input.addPort<  T >( "0" );
      output.addPort< std::size_t >( "0" );
   }

   virtual ~search() = default;

   virtual raft::kstatus run() override
   {
      auto &chunk( input[ "0" ].template peek< T >() );
      auto it( chunk.begin() );
      do
      {
         it = std::search( it, chunk.end(),
                           term.begin(), term.end() );
         if( it != chunk.end() )
         {
            output[ "0" ].push( it.location() );
            it += 1;
         }
         else
         {
            break;
         }
      }
      while( true );
      input[ "0" ].unpeek();
      input[ "0" ].recycle( );
      return( raft::proceed );
   }
private:
   const std::size_t term_length;
   const std::string term;
};

class search_v2 : public raft::kernel
{
public:
    search_v2( const std::string && term ) : raft::kernel(),
                                          term_length( term.length() ),
                                          term( term )
    {
        input.addPort< char >( "0" );
        output.addPort< std::size_t >( "0" );
    }
    
    search_v2( const std::string &term ) : raft::kernel(),
                                           term_length( term.length() ),
                                           term( term )
    {
        input.addPort< char >( "0" );
        output.addPort< std::size_t >( "0" );
    }

   virtual ~search_v2() = default;

    virtual raft::kstatus run() override
    {
        auto &in_port = input[ "0" ];
        const auto str_length = in_port.size();
        std::cerr << str_length << "\n";
        auto &data = in_port.template peek< char >();
        const auto str( std::string( reinterpret_cast< const char *>(&data), 
                                     str_length ) );
        auto it( str.begin() );
        const auto it_begin( str.begin() );
        auto contin( true );
        while( contin )
        {
           it = std::search( it, str.end(),
                             term.begin(), term.end() );
           if( contin = (it != str.end()) )
           {
              const auto dist( std::distance( it_begin, it ) );
              output[ "0" ].push( dist );
              it += 1;
           }
        }
        input[ "0" ].unpeek();
        input[ "0" ].recycle( str_length );
        return( raft::proceed );
    }
private:
   const std::size_t term_length;
   const std::string term;
};

int
main( int argc, char **argv )
{
#ifdef VERSION1
    using chunk = raft::filechunk< 30 /** 48B data, 12B meta == 60B payload **/ >;
    std::cerr << "chunk size: " << sizeof( chunk ) << "\n";
    using fr    = raft::filereader< chunk, false >;
    using search = search< chunk >;
    using print = raft::print< std::size_t, '\n'>;
    
    const std::string term( argv[ 2 ] );
    raft::map m;
    if( argc < 2 )
    {
        std::cerr << "must have at least one argument to run the search example\n";
        exit( EXIT_FAILURE );
    }

    const auto kernel_count( atoi( argv[ 3 ] ) );
    fr   read( argv[ 1 ], (fr::offset_type) term.length(), kernel_count );

    print p( kernel_count );
    for( auto i( 0 ); i < kernel_count; i++ )
    {
        m += read[ std::to_string( i ) ] >> 
                raft::kernel::make< search >( term ) >> p[ std::to_string( i ) ];
    }


#else   
    const auto fd = open( argv[ 1 ], O_RDONLY );
    if( fd == -1 )
    {
        std::cerr << "failed to open the file \"" << argv[ 1 ] << "\"\n";
        exit( EXIT_FAILURE );
    }
    //else
    struct  stat st;
    std::memset( &st, 0x0, sizeof( struct stat ) );
    if( fstat( fd, &st ) != 0 )
    {
        std::cerr << "couldn't stat the file, exiting\n";
        close( fd ); //ignore ret
        exit( EXIT_FAILURE );
    }
    auto *file_ptr = (char*) mmap( nullptr /** addr **/,
                                   st.st_size /**bytes of file **/,
                                   (PROT_READ),
                                   MAP_PRIVATE /** only used by this proc **/,
                                   fd, 
                                   0 /** no offset **/ );
    if( file_ptr == MAP_FAILED )
    {
        std::cerr << "failed to mmap file, closing and exiting!\n";
        close( fd );
        exit( EXIT_FAILURE );
    }
    //else we're good
    close( fd ); //don't need this anymore
    //application goes here. 


    using print = raft::print< std::size_t, '\n'>;
    
    if( argc < 3 )
    {
        std::cerr << "must have at least three  arguments to run the search example\n";
        exit( EXIT_FAILURE );
    }
    
    const std::string term( argv[ 2 ] );
    const auto kernel_count( atoi( argv[ 3 ] ) );
    
    raft::map m;

    
    raft::for_each< char > reader( file_ptr, st.st_size, kernel_count );
    print p( kernel_count );

    for( auto i( 0 ); i < kernel_count; i++ )
    {
        m += reader[ std::to_string( i ) ] >> 
                raft::kernel::make< search_v2 >( term ) >> p[ std::to_string( i ) ];
    }



                                    
#endif

    //start timing
    const auto start( std::chrono::high_resolution_clock::now() );
    m.exe< partition_dummy, simple_schedule, stdalloc, no_parallel >();
    const auto end( std::chrono::high_resolution_clock::now() );
    ////end timing 

    const std::chrono::duration<double> total = end - start;
    std::cerr << "region of interest timing: (" << total.count() << ") s\n";

#ifdef VERSION2
    //get rid of this. 
    munmap( file_ptr, st.st_size );
#endif
    return( EXIT_SUCCESS );
}
