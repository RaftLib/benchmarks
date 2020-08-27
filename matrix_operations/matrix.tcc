/**
 * matrix.tcc - 
 * @author: Jonathan Beard
 * @version: Thu Jun 19 10:20:15 2014
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
#ifndef _MATRIX_TCC_
#define _MATRIX_TCC_  1


enum Format { CSV, SPACE };
   

template< typename T > struct matrix{
   
   matrix( size_t height, size_t width ) :   height( height ),
                                             width( width )
   {
      data_matrix = new T[height * width]();
      std::memset( data_matrix, 0, sizeof( T ) * height * width );
   }

   matrix( const matrix< T > &other ) : height( other.height ),
                                         width(  other.width  )
   {
      data_matrix = new T[ height * width ]();
      std::memcpy( data_matrix, 
                   other.data_matrix, 
                   sizeof( T ) * height * width );
   }

   template< size_t H, size_t W >
   static
      matrix< T >* initFromArray( T input[H][W] )
   {
      matrix< T > *output = new matrix< T >( H, W );
      size_t index( 0 );
      for( size_t i( 0 ); i < H; i++ )
      {
         for( size_t j( 0 ); j < W; j++ )
         {
            output->data_matrix[ index++ ] = input[i][j];
         }
      }
      return( output );
   }
  
   


   static matrix< T >*
   initFromFile( const std::string filename )
   {
      
      std::ifstream input( filename );
      if( input.is_open() )
      {
         std::vector< std::vector< T >* > temp_data_matrix;
         std::string line;
         size_t num_columns( 0 );
         while( input.good() )
         {
            temp_data_matrix.push_back( new std::vector< T >() );
            std::getline( input, line, '\n' );
            std::istringstream iss( line );
            std::string val;
            while( iss.good() )
            {
               std::getline( iss, val, ',' );
               std::istringstream conv( val );
               T realval( 0 );
               conv >> realval ;
               temp_data_matrix.back()->push_back( realval );
            }
            if( num_columns == 0 )
            {
               num_columns = temp_data_matrix.back()->size();
            }
            else
            {
               if( temp_data_matrix.back()->size() != num_columns )
               {
                  std::cerr << 
                     "Number of columns are not equal at row (" << 
                     temp_data_matrix.size() << ").  Exiting!!\n";
                  exit( EXIT_FAILURE );
               }
            }
         }
         input.close();
         auto *output( new matrix< T >( temp_data_matrix.size(), num_columns ) );
         size_t index( 0 );
         for( std::vector< T >* v : temp_data_matrix )
         {
            for( T ele : *v )
            {
               output->data_matrix[ index++ ] = ele;
            }
            delete( v );
            v = nullptr;
         }
         return( output );
      }
      //TODO, probably should throw an exception
      return( nullptr );
   }

   template< size_t H >
   static
      matrix< T >* initFromArray( T input[H] )
   {
      matrix< T > *output = new matrix< T >( H, 1 );
      size_t index( 0 );
      for( size_t i( 0 ); i < H; i++ )
      {
         output->data_matrix[ index++ ] = input[ i ];
      }
      return( output );
   }

   virtual ~matrix()
   {
      delete[]( data_matrix );
   }


   bool operator == ( const matrix< T > &other )
   {
      const auto size_this( sizeof( T ) * height * width );
      const auto size_other( sizeof( T ) * other.height * other.width );
      if( size_this != size_other ) 
      {
         return( false );
      }
      return( std::memcmp( (this)->data_matrix,
                           other.data_matrix,
                           size_this /* they're the same size */ ) == 0 );
   }

   std::ostream& print( std::ostream &stream, Format format )
   {
      for( size_t row_index( 0 ); row_index < height; row_index++ )
      {
         for( size_t column_index( 0 ); column_index < width; column_index++ )
         {
            stream << data_matrix[ ( row_index * width ) + column_index ];
            if( column_index != (width - 1 ) )
            {
               switch( format )
               {
                  case( SPACE ):
                  {
                     stream << " ";
                  }
                  break;
                  case( CSV ):
                  {
                     stream << ",";
                  }
                  break;
                  default:
                     assert( false );
                  break;
               }
            }
         }
         stream << "\n";
      }
      return( stream );
   }

   matrix< T >* rotate()
   {
      if( width == 1 )
      {
         /* return copy */
         matrix< T > *output = new matrix< T >( *this );
         output->height = width;
         output->width  = height;
         return( output );
      }
      matrix< T > *output = new matrix< T >( width, height );
      size_t output_index( 0 );
      for( size_t column_index( 0 ); column_index < width; column_index++ )
      {
         for( size_t row_index( 0 ); row_index < height; row_index++ )
         {
            output->data_matrix[ output_index++ ] = 
               data_matrix[ ( row_index * width ) + column_index ];
         }
      }
      return( output );
   }

   
   T *data_matrix;
   size_t height;
   size_t width;
};
#endif /* END _MATRIX_TCC_ */
