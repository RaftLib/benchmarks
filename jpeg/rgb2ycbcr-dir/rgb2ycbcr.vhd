--Author: Jonathan Beard
--Version: Last Modified 11 Jan 2012
--Email: jonathan.c.beard@gmail.com

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.xpkg.all;

entity rgb2ycbcr is
  clk                : in std_logic;
  rst                : in std_logic;

  --input dim_in
  avail_dim_in       : in std_logic;
  input_dim_in       : in X_UNSIGNED32;
  read_dim_in        : out std_logic;
  
  --input red_pixels
  avail_red_pixels       : in std_logic;
  input_red_pixels       : in X_UNSIGNED64;
  read_red_pixels        : out std_logic;

  --input green_pixels
  avail_green_pixels       : in std_logic;
  input_green_pixels       : in X_UNSIGNED64;
  read_green_pixels        : out std_logic;
  
  --input blue_pixels
  avail_blue_pixels       : in std_logic;
  input_blue_pixels       : in X_UNSIGNED64;
  read_blue_pixels        : out std_logic;

   --output dimensions
   output_dim_out         : out X_UNSIGNED32;
   write_dim_out          : out std_logic;
   afull_dim_out          : in std_logic;
   
   --output Y
   output_Y         : out X_UNSIGNED64;
   write_Y          : out std_logic;
   afull_Y          : in std_logic;
   
   --output Cb
   output_Cb         : out X_UNSIGNED64;
   write_Cb          : out std_logic;
   afull_Cb          : in std_logic;
   
   --output Cr
   output_Cr         : out X_UNSIGNED64;
   write_Cr          : out std_logic;
   afull_Cr          : in std_logic;

end entity rgb2ycbcr;
