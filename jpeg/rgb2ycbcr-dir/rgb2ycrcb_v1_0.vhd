--------------------------------------------------------------------------------
-- Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: K.39
--  \   \         Application: netgen
--  /   /         Filename: rgb2ycrcb_v1_0.vhd
-- /___/   /\     Timestamp: Wed Jan 11 11:41:38 2012
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -w -sim -ofmt vhdl /home/mercury/beardj/apps/jpeg/rgb2ycbcr-dir/tmp/_cg/rgb2ycrcb_v1_0.ngc /home/mercury/beardj/apps/jpeg/rgb2ycbcr-dir/tmp/_cg/rgb2ycrcb_v1_0.vhd 
-- Device	: 4vlx100ff1148-10
-- Input file	: /home/mercury/beardj/apps/jpeg/rgb2ycbcr-dir/tmp/_cg/rgb2ycrcb_v1_0.ngc
-- Output file	: /home/mercury/beardj/apps/jpeg/rgb2ycbcr-dir/tmp/_cg/rgb2ycrcb_v1_0.vhd
-- # of Entities	: 4
-- Design Name	: rgb2ycrcb_v1_0
-- Xilinx	: /syssoft/fpga_tools/xilinx/10/ISE
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Development System Reference Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------


-- synthesis translate_off
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity mac_2_INST_1 is
  port (
    clk : in STD_LOGIC := 'X'; 
    ce : in STD_LOGIC := 'X'; 
    sclr : in STD_LOGIC := 'X'; 
    p : out STD_LOGIC_VECTOR ( 11 downto 0 ); 
    a : in STD_LOGIC_VECTOR ( 17 downto 0 ); 
    b : in STD_LOGIC_VECTOR ( 16 downto 0 ); 
    c : in STD_LOGIC_VECTOR ( 11 downto 0 ) 
  );
end mac_2_INST_1;

architecture STRUCTURE of mac_2_INST_1 is
  signal N0 : STD_LOGIC; 
  signal N1 : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_CECARRYIN_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_0_UNCONNECTED : STD_LOGIC; 
begin
  XST_GND : GND
    port map (
      G => N0
    );
  XST_VCC : VCC
    port map (
      P => N1
    );
  Maddsub_pr_mult0000 : DSP48
    generic map(
      B_INPUT => "DIRECT",
      LEGACY_MODE => "MULT18X18S",
      CREG => 0,
      AREG => 1,
      BREG => 1,
      MREG => 1,
      PREG => 1,
      CARRYINREG => 0,
      OPMODEREG => 0,
      SUBTRACTREG => 0,
      CARRYINSELREG => 0
    )
    port map (
      CARRYIN => N1,
      CEA => ce,
      CEB => ce,
      CEC => N0,
      CECTRL => N0,
      CEP => ce,
      CEM => ce,
      CECARRYIN => NLW_Maddsub_pr_mult0000_CECARRYIN_UNCONNECTED,
      CECINSUB => N0,
      CLK => clk,
      RSTA => sclr,
      RSTB => sclr,
      RSTC => N0,
      RSTCTRL => N0,
      RSTP => sclr,
      RSTM => sclr,
      RSTCARRYIN => N0,
      SUBTRACT => N0,
      A(17) => a(17),
      A(16) => a(16),
      A(15) => a(15),
      A(14) => a(14),
      A(13) => a(13),
      A(12) => a(12),
      A(11) => a(11),
      A(10) => a(10),
      A(9) => a(9),
      A(8) => a(8),
      A(7) => a(7),
      A(6) => a(6),
      A(5) => a(5),
      A(4) => a(4),
      A(3) => a(3),
      A(2) => a(2),
      A(1) => a(1),
      A(0) => a(0),
      PCIN(47) => NLW_Maddsub_pr_mult0000_PCIN_47_UNCONNECTED,
      PCIN(46) => NLW_Maddsub_pr_mult0000_PCIN_46_UNCONNECTED,
      PCIN(45) => NLW_Maddsub_pr_mult0000_PCIN_45_UNCONNECTED,
      PCIN(44) => NLW_Maddsub_pr_mult0000_PCIN_44_UNCONNECTED,
      PCIN(43) => NLW_Maddsub_pr_mult0000_PCIN_43_UNCONNECTED,
      PCIN(42) => NLW_Maddsub_pr_mult0000_PCIN_42_UNCONNECTED,
      PCIN(41) => NLW_Maddsub_pr_mult0000_PCIN_41_UNCONNECTED,
      PCIN(40) => NLW_Maddsub_pr_mult0000_PCIN_40_UNCONNECTED,
      PCIN(39) => NLW_Maddsub_pr_mult0000_PCIN_39_UNCONNECTED,
      PCIN(38) => NLW_Maddsub_pr_mult0000_PCIN_38_UNCONNECTED,
      PCIN(37) => NLW_Maddsub_pr_mult0000_PCIN_37_UNCONNECTED,
      PCIN(36) => NLW_Maddsub_pr_mult0000_PCIN_36_UNCONNECTED,
      PCIN(35) => NLW_Maddsub_pr_mult0000_PCIN_35_UNCONNECTED,
      PCIN(34) => NLW_Maddsub_pr_mult0000_PCIN_34_UNCONNECTED,
      PCIN(33) => NLW_Maddsub_pr_mult0000_PCIN_33_UNCONNECTED,
      PCIN(32) => NLW_Maddsub_pr_mult0000_PCIN_32_UNCONNECTED,
      PCIN(31) => NLW_Maddsub_pr_mult0000_PCIN_31_UNCONNECTED,
      PCIN(30) => NLW_Maddsub_pr_mult0000_PCIN_30_UNCONNECTED,
      PCIN(29) => NLW_Maddsub_pr_mult0000_PCIN_29_UNCONNECTED,
      PCIN(28) => NLW_Maddsub_pr_mult0000_PCIN_28_UNCONNECTED,
      PCIN(27) => NLW_Maddsub_pr_mult0000_PCIN_27_UNCONNECTED,
      PCIN(26) => NLW_Maddsub_pr_mult0000_PCIN_26_UNCONNECTED,
      PCIN(25) => NLW_Maddsub_pr_mult0000_PCIN_25_UNCONNECTED,
      PCIN(24) => NLW_Maddsub_pr_mult0000_PCIN_24_UNCONNECTED,
      PCIN(23) => NLW_Maddsub_pr_mult0000_PCIN_23_UNCONNECTED,
      PCIN(22) => NLW_Maddsub_pr_mult0000_PCIN_22_UNCONNECTED,
      PCIN(21) => NLW_Maddsub_pr_mult0000_PCIN_21_UNCONNECTED,
      PCIN(20) => NLW_Maddsub_pr_mult0000_PCIN_20_UNCONNECTED,
      PCIN(19) => NLW_Maddsub_pr_mult0000_PCIN_19_UNCONNECTED,
      PCIN(18) => NLW_Maddsub_pr_mult0000_PCIN_18_UNCONNECTED,
      PCIN(17) => NLW_Maddsub_pr_mult0000_PCIN_17_UNCONNECTED,
      PCIN(16) => NLW_Maddsub_pr_mult0000_PCIN_16_UNCONNECTED,
      PCIN(15) => NLW_Maddsub_pr_mult0000_PCIN_15_UNCONNECTED,
      PCIN(14) => NLW_Maddsub_pr_mult0000_PCIN_14_UNCONNECTED,
      PCIN(13) => NLW_Maddsub_pr_mult0000_PCIN_13_UNCONNECTED,
      PCIN(12) => NLW_Maddsub_pr_mult0000_PCIN_12_UNCONNECTED,
      PCIN(11) => NLW_Maddsub_pr_mult0000_PCIN_11_UNCONNECTED,
      PCIN(10) => NLW_Maddsub_pr_mult0000_PCIN_10_UNCONNECTED,
      PCIN(9) => NLW_Maddsub_pr_mult0000_PCIN_9_UNCONNECTED,
      PCIN(8) => NLW_Maddsub_pr_mult0000_PCIN_8_UNCONNECTED,
      PCIN(7) => NLW_Maddsub_pr_mult0000_PCIN_7_UNCONNECTED,
      PCIN(6) => NLW_Maddsub_pr_mult0000_PCIN_6_UNCONNECTED,
      PCIN(5) => NLW_Maddsub_pr_mult0000_PCIN_5_UNCONNECTED,
      PCIN(4) => NLW_Maddsub_pr_mult0000_PCIN_4_UNCONNECTED,
      PCIN(3) => NLW_Maddsub_pr_mult0000_PCIN_3_UNCONNECTED,
      PCIN(2) => NLW_Maddsub_pr_mult0000_PCIN_2_UNCONNECTED,
      PCIN(1) => NLW_Maddsub_pr_mult0000_PCIN_1_UNCONNECTED,
      PCIN(0) => NLW_Maddsub_pr_mult0000_PCIN_0_UNCONNECTED,
      B(17) => b(16),
      B(16) => b(16),
      B(15) => b(15),
      B(14) => b(14),
      B(13) => b(13),
      B(12) => b(12),
      B(11) => b(11),
      B(10) => b(10),
      B(9) => b(9),
      B(8) => b(8),
      B(7) => b(7),
      B(6) => b(6),
      B(5) => b(5),
      B(4) => b(4),
      B(3) => b(3),
      B(2) => b(2),
      B(1) => b(1),
      B(0) => b(0),
      C(47) => c(11),
      C(46) => c(11),
      C(45) => c(11),
      C(44) => c(11),
      C(43) => c(11),
      C(42) => c(11),
      C(41) => c(11),
      C(40) => c(11),
      C(39) => c(11),
      C(38) => c(11),
      C(37) => c(11),
      C(36) => c(11),
      C(35) => c(11),
      C(34) => c(11),
      C(33) => c(10),
      C(32) => c(9),
      C(31) => c(8),
      C(30) => c(7),
      C(29) => c(6),
      C(28) => c(5),
      C(27) => c(4),
      C(26) => c(3),
      C(25) => c(2),
      C(24) => c(1),
      C(23) => c(0),
      C(22) => N0,
      C(21) => N1,
      C(20) => N1,
      C(19) => N1,
      C(18) => N1,
      C(17) => N1,
      C(16) => N1,
      C(15) => N1,
      C(14) => N1,
      C(13) => N1,
      C(12) => N1,
      C(11) => N1,
      C(10) => N1,
      C(9) => N1,
      C(8) => N1,
      C(7) => N1,
      C(6) => N1,
      C(5) => N1,
      C(4) => N1,
      C(3) => N1,
      C(2) => N1,
      C(1) => N1,
      C(0) => N1,
      CARRYINSEL(1) => N0,
      CARRYINSEL(0) => N0,
      OPMODE(6) => N0,
      OPMODE(5) => N1,
      OPMODE(4) => N1,
      OPMODE(3) => N0,
      OPMODE(2) => N1,
      OPMODE(1) => N0,
      OPMODE(0) => N1,
      BCIN(17) => NLW_Maddsub_pr_mult0000_BCIN_17_UNCONNECTED,
      BCIN(16) => NLW_Maddsub_pr_mult0000_BCIN_16_UNCONNECTED,
      BCIN(15) => NLW_Maddsub_pr_mult0000_BCIN_15_UNCONNECTED,
      BCIN(14) => NLW_Maddsub_pr_mult0000_BCIN_14_UNCONNECTED,
      BCIN(13) => NLW_Maddsub_pr_mult0000_BCIN_13_UNCONNECTED,
      BCIN(12) => NLW_Maddsub_pr_mult0000_BCIN_12_UNCONNECTED,
      BCIN(11) => NLW_Maddsub_pr_mult0000_BCIN_11_UNCONNECTED,
      BCIN(10) => NLW_Maddsub_pr_mult0000_BCIN_10_UNCONNECTED,
      BCIN(9) => NLW_Maddsub_pr_mult0000_BCIN_9_UNCONNECTED,
      BCIN(8) => NLW_Maddsub_pr_mult0000_BCIN_8_UNCONNECTED,
      BCIN(7) => NLW_Maddsub_pr_mult0000_BCIN_7_UNCONNECTED,
      BCIN(6) => NLW_Maddsub_pr_mult0000_BCIN_6_UNCONNECTED,
      BCIN(5) => NLW_Maddsub_pr_mult0000_BCIN_5_UNCONNECTED,
      BCIN(4) => NLW_Maddsub_pr_mult0000_BCIN_4_UNCONNECTED,
      BCIN(3) => NLW_Maddsub_pr_mult0000_BCIN_3_UNCONNECTED,
      BCIN(2) => NLW_Maddsub_pr_mult0000_BCIN_2_UNCONNECTED,
      BCIN(1) => NLW_Maddsub_pr_mult0000_BCIN_1_UNCONNECTED,
      BCIN(0) => NLW_Maddsub_pr_mult0000_BCIN_0_UNCONNECTED,
      PCOUT(47) => NLW_Maddsub_pr_mult0000_PCOUT_47_UNCONNECTED,
      PCOUT(46) => NLW_Maddsub_pr_mult0000_PCOUT_46_UNCONNECTED,
      PCOUT(45) => NLW_Maddsub_pr_mult0000_PCOUT_45_UNCONNECTED,
      PCOUT(44) => NLW_Maddsub_pr_mult0000_PCOUT_44_UNCONNECTED,
      PCOUT(43) => NLW_Maddsub_pr_mult0000_PCOUT_43_UNCONNECTED,
      PCOUT(42) => NLW_Maddsub_pr_mult0000_PCOUT_42_UNCONNECTED,
      PCOUT(41) => NLW_Maddsub_pr_mult0000_PCOUT_41_UNCONNECTED,
      PCOUT(40) => NLW_Maddsub_pr_mult0000_PCOUT_40_UNCONNECTED,
      PCOUT(39) => NLW_Maddsub_pr_mult0000_PCOUT_39_UNCONNECTED,
      PCOUT(38) => NLW_Maddsub_pr_mult0000_PCOUT_38_UNCONNECTED,
      PCOUT(37) => NLW_Maddsub_pr_mult0000_PCOUT_37_UNCONNECTED,
      PCOUT(36) => NLW_Maddsub_pr_mult0000_PCOUT_36_UNCONNECTED,
      PCOUT(35) => NLW_Maddsub_pr_mult0000_PCOUT_35_UNCONNECTED,
      PCOUT(34) => NLW_Maddsub_pr_mult0000_PCOUT_34_UNCONNECTED,
      PCOUT(33) => NLW_Maddsub_pr_mult0000_PCOUT_33_UNCONNECTED,
      PCOUT(32) => NLW_Maddsub_pr_mult0000_PCOUT_32_UNCONNECTED,
      PCOUT(31) => NLW_Maddsub_pr_mult0000_PCOUT_31_UNCONNECTED,
      PCOUT(30) => NLW_Maddsub_pr_mult0000_PCOUT_30_UNCONNECTED,
      PCOUT(29) => NLW_Maddsub_pr_mult0000_PCOUT_29_UNCONNECTED,
      PCOUT(28) => NLW_Maddsub_pr_mult0000_PCOUT_28_UNCONNECTED,
      PCOUT(27) => NLW_Maddsub_pr_mult0000_PCOUT_27_UNCONNECTED,
      PCOUT(26) => NLW_Maddsub_pr_mult0000_PCOUT_26_UNCONNECTED,
      PCOUT(25) => NLW_Maddsub_pr_mult0000_PCOUT_25_UNCONNECTED,
      PCOUT(24) => NLW_Maddsub_pr_mult0000_PCOUT_24_UNCONNECTED,
      PCOUT(23) => NLW_Maddsub_pr_mult0000_PCOUT_23_UNCONNECTED,
      PCOUT(22) => NLW_Maddsub_pr_mult0000_PCOUT_22_UNCONNECTED,
      PCOUT(21) => NLW_Maddsub_pr_mult0000_PCOUT_21_UNCONNECTED,
      PCOUT(20) => NLW_Maddsub_pr_mult0000_PCOUT_20_UNCONNECTED,
      PCOUT(19) => NLW_Maddsub_pr_mult0000_PCOUT_19_UNCONNECTED,
      PCOUT(18) => NLW_Maddsub_pr_mult0000_PCOUT_18_UNCONNECTED,
      PCOUT(17) => NLW_Maddsub_pr_mult0000_PCOUT_17_UNCONNECTED,
      PCOUT(16) => NLW_Maddsub_pr_mult0000_PCOUT_16_UNCONNECTED,
      PCOUT(15) => NLW_Maddsub_pr_mult0000_PCOUT_15_UNCONNECTED,
      PCOUT(14) => NLW_Maddsub_pr_mult0000_PCOUT_14_UNCONNECTED,
      PCOUT(13) => NLW_Maddsub_pr_mult0000_PCOUT_13_UNCONNECTED,
      PCOUT(12) => NLW_Maddsub_pr_mult0000_PCOUT_12_UNCONNECTED,
      PCOUT(11) => NLW_Maddsub_pr_mult0000_PCOUT_11_UNCONNECTED,
      PCOUT(10) => NLW_Maddsub_pr_mult0000_PCOUT_10_UNCONNECTED,
      PCOUT(9) => NLW_Maddsub_pr_mult0000_PCOUT_9_UNCONNECTED,
      PCOUT(8) => NLW_Maddsub_pr_mult0000_PCOUT_8_UNCONNECTED,
      PCOUT(7) => NLW_Maddsub_pr_mult0000_PCOUT_7_UNCONNECTED,
      PCOUT(6) => NLW_Maddsub_pr_mult0000_PCOUT_6_UNCONNECTED,
      PCOUT(5) => NLW_Maddsub_pr_mult0000_PCOUT_5_UNCONNECTED,
      PCOUT(4) => NLW_Maddsub_pr_mult0000_PCOUT_4_UNCONNECTED,
      PCOUT(3) => NLW_Maddsub_pr_mult0000_PCOUT_3_UNCONNECTED,
      PCOUT(2) => NLW_Maddsub_pr_mult0000_PCOUT_2_UNCONNECTED,
      PCOUT(1) => NLW_Maddsub_pr_mult0000_PCOUT_1_UNCONNECTED,
      PCOUT(0) => NLW_Maddsub_pr_mult0000_PCOUT_0_UNCONNECTED,
      P(47) => NLW_Maddsub_pr_mult0000_P_47_UNCONNECTED,
      P(46) => NLW_Maddsub_pr_mult0000_P_46_UNCONNECTED,
      P(45) => NLW_Maddsub_pr_mult0000_P_45_UNCONNECTED,
      P(44) => NLW_Maddsub_pr_mult0000_P_44_UNCONNECTED,
      P(43) => NLW_Maddsub_pr_mult0000_P_43_UNCONNECTED,
      P(42) => NLW_Maddsub_pr_mult0000_P_42_UNCONNECTED,
      P(41) => NLW_Maddsub_pr_mult0000_P_41_UNCONNECTED,
      P(40) => NLW_Maddsub_pr_mult0000_P_40_UNCONNECTED,
      P(39) => NLW_Maddsub_pr_mult0000_P_39_UNCONNECTED,
      P(38) => NLW_Maddsub_pr_mult0000_P_38_UNCONNECTED,
      P(37) => NLW_Maddsub_pr_mult0000_P_37_UNCONNECTED,
      P(36) => NLW_Maddsub_pr_mult0000_P_36_UNCONNECTED,
      P(35) => NLW_Maddsub_pr_mult0000_P_35_UNCONNECTED,
      P(34) => p(11),
      P(33) => p(10),
      P(32) => p(9),
      P(31) => p(8),
      P(30) => p(7),
      P(29) => p(6),
      P(28) => p(5),
      P(27) => p(4),
      P(26) => p(3),
      P(25) => p(2),
      P(24) => p(1),
      P(23) => p(0),
      P(22) => NLW_Maddsub_pr_mult0000_P_22_UNCONNECTED,
      P(21) => NLW_Maddsub_pr_mult0000_P_21_UNCONNECTED,
      P(20) => NLW_Maddsub_pr_mult0000_P_20_UNCONNECTED,
      P(19) => NLW_Maddsub_pr_mult0000_P_19_UNCONNECTED,
      P(18) => NLW_Maddsub_pr_mult0000_P_18_UNCONNECTED,
      P(17) => NLW_Maddsub_pr_mult0000_P_17_UNCONNECTED,
      P(16) => NLW_Maddsub_pr_mult0000_P_16_UNCONNECTED,
      P(15) => NLW_Maddsub_pr_mult0000_P_15_UNCONNECTED,
      P(14) => NLW_Maddsub_pr_mult0000_P_14_UNCONNECTED,
      P(13) => NLW_Maddsub_pr_mult0000_P_13_UNCONNECTED,
      P(12) => NLW_Maddsub_pr_mult0000_P_12_UNCONNECTED,
      P(11) => NLW_Maddsub_pr_mult0000_P_11_UNCONNECTED,
      P(10) => NLW_Maddsub_pr_mult0000_P_10_UNCONNECTED,
      P(9) => NLW_Maddsub_pr_mult0000_P_9_UNCONNECTED,
      P(8) => NLW_Maddsub_pr_mult0000_P_8_UNCONNECTED,
      P(7) => NLW_Maddsub_pr_mult0000_P_7_UNCONNECTED,
      P(6) => NLW_Maddsub_pr_mult0000_P_6_UNCONNECTED,
      P(5) => NLW_Maddsub_pr_mult0000_P_5_UNCONNECTED,
      P(4) => NLW_Maddsub_pr_mult0000_P_4_UNCONNECTED,
      P(3) => NLW_Maddsub_pr_mult0000_P_3_UNCONNECTED,
      P(2) => NLW_Maddsub_pr_mult0000_P_2_UNCONNECTED,
      P(1) => NLW_Maddsub_pr_mult0000_P_1_UNCONNECTED,
      P(0) => NLW_Maddsub_pr_mult0000_P_0_UNCONNECTED,
      BCOUT(17) => NLW_Maddsub_pr_mult0000_BCOUT_17_UNCONNECTED,
      BCOUT(16) => NLW_Maddsub_pr_mult0000_BCOUT_16_UNCONNECTED,
      BCOUT(15) => NLW_Maddsub_pr_mult0000_BCOUT_15_UNCONNECTED,
      BCOUT(14) => NLW_Maddsub_pr_mult0000_BCOUT_14_UNCONNECTED,
      BCOUT(13) => NLW_Maddsub_pr_mult0000_BCOUT_13_UNCONNECTED,
      BCOUT(12) => NLW_Maddsub_pr_mult0000_BCOUT_12_UNCONNECTED,
      BCOUT(11) => NLW_Maddsub_pr_mult0000_BCOUT_11_UNCONNECTED,
      BCOUT(10) => NLW_Maddsub_pr_mult0000_BCOUT_10_UNCONNECTED,
      BCOUT(9) => NLW_Maddsub_pr_mult0000_BCOUT_9_UNCONNECTED,
      BCOUT(8) => NLW_Maddsub_pr_mult0000_BCOUT_8_UNCONNECTED,
      BCOUT(7) => NLW_Maddsub_pr_mult0000_BCOUT_7_UNCONNECTED,
      BCOUT(6) => NLW_Maddsub_pr_mult0000_BCOUT_6_UNCONNECTED,
      BCOUT(5) => NLW_Maddsub_pr_mult0000_BCOUT_5_UNCONNECTED,
      BCOUT(4) => NLW_Maddsub_pr_mult0000_BCOUT_4_UNCONNECTED,
      BCOUT(3) => NLW_Maddsub_pr_mult0000_BCOUT_3_UNCONNECTED,
      BCOUT(2) => NLW_Maddsub_pr_mult0000_BCOUT_2_UNCONNECTED,
      BCOUT(1) => NLW_Maddsub_pr_mult0000_BCOUT_1_UNCONNECTED,
      BCOUT(0) => NLW_Maddsub_pr_mult0000_BCOUT_0_UNCONNECTED
    );

end STRUCTURE;

-- synthesis translate_on

-- synthesis translate_off
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity mac_2 is
  port (
    clk : in STD_LOGIC := 'X'; 
    ce : in STD_LOGIC := 'X'; 
    sclr : in STD_LOGIC := 'X'; 
    p : out STD_LOGIC_VECTOR ( 11 downto 0 ); 
    a : in STD_LOGIC_VECTOR ( 17 downto 0 ); 
    b : in STD_LOGIC_VECTOR ( 16 downto 0 ); 
    c : in STD_LOGIC_VECTOR ( 11 downto 0 ) 
  );
end mac_2;

architecture STRUCTURE of mac_2 is
  signal N0 : STD_LOGIC; 
  signal N1 : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_CECARRYIN_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_0_UNCONNECTED : STD_LOGIC; 
begin
  XST_GND : GND
    port map (
      G => N0
    );
  XST_VCC : VCC
    port map (
      P => N1
    );
  Maddsub_pr_mult0000 : DSP48
    generic map(
      B_INPUT => "DIRECT",
      LEGACY_MODE => "MULT18X18S",
      CREG => 0,
      AREG => 1,
      BREG => 1,
      MREG => 1,
      PREG => 1,
      CARRYINREG => 0,
      OPMODEREG => 0,
      SUBTRACTREG => 0,
      CARRYINSELREG => 0
    )
    port map (
      CARRYIN => N1,
      CEA => ce,
      CEB => ce,
      CEC => N0,
      CECTRL => N0,
      CEP => ce,
      CEM => ce,
      CECARRYIN => NLW_Maddsub_pr_mult0000_CECARRYIN_UNCONNECTED,
      CECINSUB => N0,
      CLK => clk,
      RSTA => sclr,
      RSTB => sclr,
      RSTC => N0,
      RSTCTRL => N0,
      RSTP => sclr,
      RSTM => sclr,
      RSTCARRYIN => N0,
      SUBTRACT => N0,
      A(17) => a(17),
      A(16) => a(16),
      A(15) => a(15),
      A(14) => a(14),
      A(13) => a(13),
      A(12) => a(12),
      A(11) => a(11),
      A(10) => a(10),
      A(9) => a(9),
      A(8) => a(8),
      A(7) => a(7),
      A(6) => a(6),
      A(5) => a(5),
      A(4) => a(4),
      A(3) => a(3),
      A(2) => a(2),
      A(1) => a(1),
      A(0) => a(0),
      PCIN(47) => NLW_Maddsub_pr_mult0000_PCIN_47_UNCONNECTED,
      PCIN(46) => NLW_Maddsub_pr_mult0000_PCIN_46_UNCONNECTED,
      PCIN(45) => NLW_Maddsub_pr_mult0000_PCIN_45_UNCONNECTED,
      PCIN(44) => NLW_Maddsub_pr_mult0000_PCIN_44_UNCONNECTED,
      PCIN(43) => NLW_Maddsub_pr_mult0000_PCIN_43_UNCONNECTED,
      PCIN(42) => NLW_Maddsub_pr_mult0000_PCIN_42_UNCONNECTED,
      PCIN(41) => NLW_Maddsub_pr_mult0000_PCIN_41_UNCONNECTED,
      PCIN(40) => NLW_Maddsub_pr_mult0000_PCIN_40_UNCONNECTED,
      PCIN(39) => NLW_Maddsub_pr_mult0000_PCIN_39_UNCONNECTED,
      PCIN(38) => NLW_Maddsub_pr_mult0000_PCIN_38_UNCONNECTED,
      PCIN(37) => NLW_Maddsub_pr_mult0000_PCIN_37_UNCONNECTED,
      PCIN(36) => NLW_Maddsub_pr_mult0000_PCIN_36_UNCONNECTED,
      PCIN(35) => NLW_Maddsub_pr_mult0000_PCIN_35_UNCONNECTED,
      PCIN(34) => NLW_Maddsub_pr_mult0000_PCIN_34_UNCONNECTED,
      PCIN(33) => NLW_Maddsub_pr_mult0000_PCIN_33_UNCONNECTED,
      PCIN(32) => NLW_Maddsub_pr_mult0000_PCIN_32_UNCONNECTED,
      PCIN(31) => NLW_Maddsub_pr_mult0000_PCIN_31_UNCONNECTED,
      PCIN(30) => NLW_Maddsub_pr_mult0000_PCIN_30_UNCONNECTED,
      PCIN(29) => NLW_Maddsub_pr_mult0000_PCIN_29_UNCONNECTED,
      PCIN(28) => NLW_Maddsub_pr_mult0000_PCIN_28_UNCONNECTED,
      PCIN(27) => NLW_Maddsub_pr_mult0000_PCIN_27_UNCONNECTED,
      PCIN(26) => NLW_Maddsub_pr_mult0000_PCIN_26_UNCONNECTED,
      PCIN(25) => NLW_Maddsub_pr_mult0000_PCIN_25_UNCONNECTED,
      PCIN(24) => NLW_Maddsub_pr_mult0000_PCIN_24_UNCONNECTED,
      PCIN(23) => NLW_Maddsub_pr_mult0000_PCIN_23_UNCONNECTED,
      PCIN(22) => NLW_Maddsub_pr_mult0000_PCIN_22_UNCONNECTED,
      PCIN(21) => NLW_Maddsub_pr_mult0000_PCIN_21_UNCONNECTED,
      PCIN(20) => NLW_Maddsub_pr_mult0000_PCIN_20_UNCONNECTED,
      PCIN(19) => NLW_Maddsub_pr_mult0000_PCIN_19_UNCONNECTED,
      PCIN(18) => NLW_Maddsub_pr_mult0000_PCIN_18_UNCONNECTED,
      PCIN(17) => NLW_Maddsub_pr_mult0000_PCIN_17_UNCONNECTED,
      PCIN(16) => NLW_Maddsub_pr_mult0000_PCIN_16_UNCONNECTED,
      PCIN(15) => NLW_Maddsub_pr_mult0000_PCIN_15_UNCONNECTED,
      PCIN(14) => NLW_Maddsub_pr_mult0000_PCIN_14_UNCONNECTED,
      PCIN(13) => NLW_Maddsub_pr_mult0000_PCIN_13_UNCONNECTED,
      PCIN(12) => NLW_Maddsub_pr_mult0000_PCIN_12_UNCONNECTED,
      PCIN(11) => NLW_Maddsub_pr_mult0000_PCIN_11_UNCONNECTED,
      PCIN(10) => NLW_Maddsub_pr_mult0000_PCIN_10_UNCONNECTED,
      PCIN(9) => NLW_Maddsub_pr_mult0000_PCIN_9_UNCONNECTED,
      PCIN(8) => NLW_Maddsub_pr_mult0000_PCIN_8_UNCONNECTED,
      PCIN(7) => NLW_Maddsub_pr_mult0000_PCIN_7_UNCONNECTED,
      PCIN(6) => NLW_Maddsub_pr_mult0000_PCIN_6_UNCONNECTED,
      PCIN(5) => NLW_Maddsub_pr_mult0000_PCIN_5_UNCONNECTED,
      PCIN(4) => NLW_Maddsub_pr_mult0000_PCIN_4_UNCONNECTED,
      PCIN(3) => NLW_Maddsub_pr_mult0000_PCIN_3_UNCONNECTED,
      PCIN(2) => NLW_Maddsub_pr_mult0000_PCIN_2_UNCONNECTED,
      PCIN(1) => NLW_Maddsub_pr_mult0000_PCIN_1_UNCONNECTED,
      PCIN(0) => NLW_Maddsub_pr_mult0000_PCIN_0_UNCONNECTED,
      B(17) => b(16),
      B(16) => b(16),
      B(15) => b(15),
      B(14) => b(14),
      B(13) => b(13),
      B(12) => b(12),
      B(11) => b(11),
      B(10) => b(10),
      B(9) => b(9),
      B(8) => b(8),
      B(7) => b(7),
      B(6) => b(6),
      B(5) => b(5),
      B(4) => b(4),
      B(3) => b(3),
      B(2) => b(2),
      B(1) => b(1),
      B(0) => b(0),
      C(47) => c(11),
      C(46) => c(11),
      C(45) => c(11),
      C(44) => c(11),
      C(43) => c(11),
      C(42) => c(11),
      C(41) => c(11),
      C(40) => c(11),
      C(39) => c(11),
      C(38) => c(11),
      C(37) => c(11),
      C(36) => c(11),
      C(35) => c(11),
      C(34) => c(11),
      C(33) => c(10),
      C(32) => c(9),
      C(31) => c(8),
      C(30) => c(7),
      C(29) => c(6),
      C(28) => c(5),
      C(27) => c(4),
      C(26) => c(3),
      C(25) => c(2),
      C(24) => c(1),
      C(23) => c(0),
      C(22) => N0,
      C(21) => N1,
      C(20) => N1,
      C(19) => N1,
      C(18) => N1,
      C(17) => N1,
      C(16) => N1,
      C(15) => N1,
      C(14) => N1,
      C(13) => N1,
      C(12) => N1,
      C(11) => N1,
      C(10) => N1,
      C(9) => N1,
      C(8) => N1,
      C(7) => N1,
      C(6) => N1,
      C(5) => N1,
      C(4) => N1,
      C(3) => N1,
      C(2) => N1,
      C(1) => N1,
      C(0) => N1,
      CARRYINSEL(1) => N0,
      CARRYINSEL(0) => N0,
      OPMODE(6) => N0,
      OPMODE(5) => N1,
      OPMODE(4) => N1,
      OPMODE(3) => N0,
      OPMODE(2) => N1,
      OPMODE(1) => N0,
      OPMODE(0) => N1,
      BCIN(17) => NLW_Maddsub_pr_mult0000_BCIN_17_UNCONNECTED,
      BCIN(16) => NLW_Maddsub_pr_mult0000_BCIN_16_UNCONNECTED,
      BCIN(15) => NLW_Maddsub_pr_mult0000_BCIN_15_UNCONNECTED,
      BCIN(14) => NLW_Maddsub_pr_mult0000_BCIN_14_UNCONNECTED,
      BCIN(13) => NLW_Maddsub_pr_mult0000_BCIN_13_UNCONNECTED,
      BCIN(12) => NLW_Maddsub_pr_mult0000_BCIN_12_UNCONNECTED,
      BCIN(11) => NLW_Maddsub_pr_mult0000_BCIN_11_UNCONNECTED,
      BCIN(10) => NLW_Maddsub_pr_mult0000_BCIN_10_UNCONNECTED,
      BCIN(9) => NLW_Maddsub_pr_mult0000_BCIN_9_UNCONNECTED,
      BCIN(8) => NLW_Maddsub_pr_mult0000_BCIN_8_UNCONNECTED,
      BCIN(7) => NLW_Maddsub_pr_mult0000_BCIN_7_UNCONNECTED,
      BCIN(6) => NLW_Maddsub_pr_mult0000_BCIN_6_UNCONNECTED,
      BCIN(5) => NLW_Maddsub_pr_mult0000_BCIN_5_UNCONNECTED,
      BCIN(4) => NLW_Maddsub_pr_mult0000_BCIN_4_UNCONNECTED,
      BCIN(3) => NLW_Maddsub_pr_mult0000_BCIN_3_UNCONNECTED,
      BCIN(2) => NLW_Maddsub_pr_mult0000_BCIN_2_UNCONNECTED,
      BCIN(1) => NLW_Maddsub_pr_mult0000_BCIN_1_UNCONNECTED,
      BCIN(0) => NLW_Maddsub_pr_mult0000_BCIN_0_UNCONNECTED,
      PCOUT(47) => NLW_Maddsub_pr_mult0000_PCOUT_47_UNCONNECTED,
      PCOUT(46) => NLW_Maddsub_pr_mult0000_PCOUT_46_UNCONNECTED,
      PCOUT(45) => NLW_Maddsub_pr_mult0000_PCOUT_45_UNCONNECTED,
      PCOUT(44) => NLW_Maddsub_pr_mult0000_PCOUT_44_UNCONNECTED,
      PCOUT(43) => NLW_Maddsub_pr_mult0000_PCOUT_43_UNCONNECTED,
      PCOUT(42) => NLW_Maddsub_pr_mult0000_PCOUT_42_UNCONNECTED,
      PCOUT(41) => NLW_Maddsub_pr_mult0000_PCOUT_41_UNCONNECTED,
      PCOUT(40) => NLW_Maddsub_pr_mult0000_PCOUT_40_UNCONNECTED,
      PCOUT(39) => NLW_Maddsub_pr_mult0000_PCOUT_39_UNCONNECTED,
      PCOUT(38) => NLW_Maddsub_pr_mult0000_PCOUT_38_UNCONNECTED,
      PCOUT(37) => NLW_Maddsub_pr_mult0000_PCOUT_37_UNCONNECTED,
      PCOUT(36) => NLW_Maddsub_pr_mult0000_PCOUT_36_UNCONNECTED,
      PCOUT(35) => NLW_Maddsub_pr_mult0000_PCOUT_35_UNCONNECTED,
      PCOUT(34) => NLW_Maddsub_pr_mult0000_PCOUT_34_UNCONNECTED,
      PCOUT(33) => NLW_Maddsub_pr_mult0000_PCOUT_33_UNCONNECTED,
      PCOUT(32) => NLW_Maddsub_pr_mult0000_PCOUT_32_UNCONNECTED,
      PCOUT(31) => NLW_Maddsub_pr_mult0000_PCOUT_31_UNCONNECTED,
      PCOUT(30) => NLW_Maddsub_pr_mult0000_PCOUT_30_UNCONNECTED,
      PCOUT(29) => NLW_Maddsub_pr_mult0000_PCOUT_29_UNCONNECTED,
      PCOUT(28) => NLW_Maddsub_pr_mult0000_PCOUT_28_UNCONNECTED,
      PCOUT(27) => NLW_Maddsub_pr_mult0000_PCOUT_27_UNCONNECTED,
      PCOUT(26) => NLW_Maddsub_pr_mult0000_PCOUT_26_UNCONNECTED,
      PCOUT(25) => NLW_Maddsub_pr_mult0000_PCOUT_25_UNCONNECTED,
      PCOUT(24) => NLW_Maddsub_pr_mult0000_PCOUT_24_UNCONNECTED,
      PCOUT(23) => NLW_Maddsub_pr_mult0000_PCOUT_23_UNCONNECTED,
      PCOUT(22) => NLW_Maddsub_pr_mult0000_PCOUT_22_UNCONNECTED,
      PCOUT(21) => NLW_Maddsub_pr_mult0000_PCOUT_21_UNCONNECTED,
      PCOUT(20) => NLW_Maddsub_pr_mult0000_PCOUT_20_UNCONNECTED,
      PCOUT(19) => NLW_Maddsub_pr_mult0000_PCOUT_19_UNCONNECTED,
      PCOUT(18) => NLW_Maddsub_pr_mult0000_PCOUT_18_UNCONNECTED,
      PCOUT(17) => NLW_Maddsub_pr_mult0000_PCOUT_17_UNCONNECTED,
      PCOUT(16) => NLW_Maddsub_pr_mult0000_PCOUT_16_UNCONNECTED,
      PCOUT(15) => NLW_Maddsub_pr_mult0000_PCOUT_15_UNCONNECTED,
      PCOUT(14) => NLW_Maddsub_pr_mult0000_PCOUT_14_UNCONNECTED,
      PCOUT(13) => NLW_Maddsub_pr_mult0000_PCOUT_13_UNCONNECTED,
      PCOUT(12) => NLW_Maddsub_pr_mult0000_PCOUT_12_UNCONNECTED,
      PCOUT(11) => NLW_Maddsub_pr_mult0000_PCOUT_11_UNCONNECTED,
      PCOUT(10) => NLW_Maddsub_pr_mult0000_PCOUT_10_UNCONNECTED,
      PCOUT(9) => NLW_Maddsub_pr_mult0000_PCOUT_9_UNCONNECTED,
      PCOUT(8) => NLW_Maddsub_pr_mult0000_PCOUT_8_UNCONNECTED,
      PCOUT(7) => NLW_Maddsub_pr_mult0000_PCOUT_7_UNCONNECTED,
      PCOUT(6) => NLW_Maddsub_pr_mult0000_PCOUT_6_UNCONNECTED,
      PCOUT(5) => NLW_Maddsub_pr_mult0000_PCOUT_5_UNCONNECTED,
      PCOUT(4) => NLW_Maddsub_pr_mult0000_PCOUT_4_UNCONNECTED,
      PCOUT(3) => NLW_Maddsub_pr_mult0000_PCOUT_3_UNCONNECTED,
      PCOUT(2) => NLW_Maddsub_pr_mult0000_PCOUT_2_UNCONNECTED,
      PCOUT(1) => NLW_Maddsub_pr_mult0000_PCOUT_1_UNCONNECTED,
      PCOUT(0) => NLW_Maddsub_pr_mult0000_PCOUT_0_UNCONNECTED,
      P(47) => NLW_Maddsub_pr_mult0000_P_47_UNCONNECTED,
      P(46) => NLW_Maddsub_pr_mult0000_P_46_UNCONNECTED,
      P(45) => NLW_Maddsub_pr_mult0000_P_45_UNCONNECTED,
      P(44) => NLW_Maddsub_pr_mult0000_P_44_UNCONNECTED,
      P(43) => NLW_Maddsub_pr_mult0000_P_43_UNCONNECTED,
      P(42) => NLW_Maddsub_pr_mult0000_P_42_UNCONNECTED,
      P(41) => NLW_Maddsub_pr_mult0000_P_41_UNCONNECTED,
      P(40) => NLW_Maddsub_pr_mult0000_P_40_UNCONNECTED,
      P(39) => NLW_Maddsub_pr_mult0000_P_39_UNCONNECTED,
      P(38) => NLW_Maddsub_pr_mult0000_P_38_UNCONNECTED,
      P(37) => NLW_Maddsub_pr_mult0000_P_37_UNCONNECTED,
      P(36) => NLW_Maddsub_pr_mult0000_P_36_UNCONNECTED,
      P(35) => NLW_Maddsub_pr_mult0000_P_35_UNCONNECTED,
      P(34) => p(11),
      P(33) => p(10),
      P(32) => p(9),
      P(31) => p(8),
      P(30) => p(7),
      P(29) => p(6),
      P(28) => p(5),
      P(27) => p(4),
      P(26) => p(3),
      P(25) => p(2),
      P(24) => p(1),
      P(23) => p(0),
      P(22) => NLW_Maddsub_pr_mult0000_P_22_UNCONNECTED,
      P(21) => NLW_Maddsub_pr_mult0000_P_21_UNCONNECTED,
      P(20) => NLW_Maddsub_pr_mult0000_P_20_UNCONNECTED,
      P(19) => NLW_Maddsub_pr_mult0000_P_19_UNCONNECTED,
      P(18) => NLW_Maddsub_pr_mult0000_P_18_UNCONNECTED,
      P(17) => NLW_Maddsub_pr_mult0000_P_17_UNCONNECTED,
      P(16) => NLW_Maddsub_pr_mult0000_P_16_UNCONNECTED,
      P(15) => NLW_Maddsub_pr_mult0000_P_15_UNCONNECTED,
      P(14) => NLW_Maddsub_pr_mult0000_P_14_UNCONNECTED,
      P(13) => NLW_Maddsub_pr_mult0000_P_13_UNCONNECTED,
      P(12) => NLW_Maddsub_pr_mult0000_P_12_UNCONNECTED,
      P(11) => NLW_Maddsub_pr_mult0000_P_11_UNCONNECTED,
      P(10) => NLW_Maddsub_pr_mult0000_P_10_UNCONNECTED,
      P(9) => NLW_Maddsub_pr_mult0000_P_9_UNCONNECTED,
      P(8) => NLW_Maddsub_pr_mult0000_P_8_UNCONNECTED,
      P(7) => NLW_Maddsub_pr_mult0000_P_7_UNCONNECTED,
      P(6) => NLW_Maddsub_pr_mult0000_P_6_UNCONNECTED,
      P(5) => NLW_Maddsub_pr_mult0000_P_5_UNCONNECTED,
      P(4) => NLW_Maddsub_pr_mult0000_P_4_UNCONNECTED,
      P(3) => NLW_Maddsub_pr_mult0000_P_3_UNCONNECTED,
      P(2) => NLW_Maddsub_pr_mult0000_P_2_UNCONNECTED,
      P(1) => NLW_Maddsub_pr_mult0000_P_1_UNCONNECTED,
      P(0) => NLW_Maddsub_pr_mult0000_P_0_UNCONNECTED,
      BCOUT(17) => NLW_Maddsub_pr_mult0000_BCOUT_17_UNCONNECTED,
      BCOUT(16) => NLW_Maddsub_pr_mult0000_BCOUT_16_UNCONNECTED,
      BCOUT(15) => NLW_Maddsub_pr_mult0000_BCOUT_15_UNCONNECTED,
      BCOUT(14) => NLW_Maddsub_pr_mult0000_BCOUT_14_UNCONNECTED,
      BCOUT(13) => NLW_Maddsub_pr_mult0000_BCOUT_13_UNCONNECTED,
      BCOUT(12) => NLW_Maddsub_pr_mult0000_BCOUT_12_UNCONNECTED,
      BCOUT(11) => NLW_Maddsub_pr_mult0000_BCOUT_11_UNCONNECTED,
      BCOUT(10) => NLW_Maddsub_pr_mult0000_BCOUT_10_UNCONNECTED,
      BCOUT(9) => NLW_Maddsub_pr_mult0000_BCOUT_9_UNCONNECTED,
      BCOUT(8) => NLW_Maddsub_pr_mult0000_BCOUT_8_UNCONNECTED,
      BCOUT(7) => NLW_Maddsub_pr_mult0000_BCOUT_7_UNCONNECTED,
      BCOUT(6) => NLW_Maddsub_pr_mult0000_BCOUT_6_UNCONNECTED,
      BCOUT(5) => NLW_Maddsub_pr_mult0000_BCOUT_5_UNCONNECTED,
      BCOUT(4) => NLW_Maddsub_pr_mult0000_BCOUT_4_UNCONNECTED,
      BCOUT(3) => NLW_Maddsub_pr_mult0000_BCOUT_3_UNCONNECTED,
      BCOUT(2) => NLW_Maddsub_pr_mult0000_BCOUT_2_UNCONNECTED,
      BCOUT(1) => NLW_Maddsub_pr_mult0000_BCOUT_1_UNCONNECTED,
      BCOUT(0) => NLW_Maddsub_pr_mult0000_BCOUT_0_UNCONNECTED
    );

end STRUCTURE;

-- synthesis translate_on

-- synthesis translate_off
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity mac_1 is
  port (
    clk : in STD_LOGIC := 'X'; 
    ce : in STD_LOGIC := 'X'; 
    sclr : in STD_LOGIC := 'X'; 
    p : out STD_LOGIC_VECTOR ( 25 downto 0 ); 
    a : in STD_LOGIC_VECTOR ( 8 downto 0 ); 
    b : in STD_LOGIC_VECTOR ( 16 downto 0 ); 
    c : in STD_LOGIC_VECTOR ( 25 downto 0 ) 
  );
end mac_1;

architecture STRUCTURE of mac_1 is
  signal N1 : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_CECARRYIN_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCIN_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCIN_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_PCOUT_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_P_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_Maddsub_pr_mult0000_BCOUT_0_UNCONNECTED : STD_LOGIC; 
  signal br : STD_LOGIC_VECTOR ( 16 downto 16 ); 
begin
  XST_GND : GND
    port map (
      G => br(16)
    );
  XST_VCC : VCC
    port map (
      P => N1
    );
  Maddsub_pr_mult0000 : DSP48
    generic map(
      B_INPUT => "DIRECT",
      LEGACY_MODE => "MULT18X18S",
      CREG => 0,
      AREG => 1,
      BREG => 1,
      MREG => 1,
      PREG => 1,
      CARRYINREG => 0,
      OPMODEREG => 0,
      SUBTRACTREG => 0,
      CARRYINSELREG => 0
    )
    port map (
      CARRYIN => br(16),
      CEA => ce,
      CEB => ce,
      CEC => br(16),
      CECTRL => br(16),
      CEP => ce,
      CEM => ce,
      CECARRYIN => NLW_Maddsub_pr_mult0000_CECARRYIN_UNCONNECTED,
      CECINSUB => br(16),
      CLK => clk,
      RSTA => sclr,
      RSTB => sclr,
      RSTC => br(16),
      RSTCTRL => br(16),
      RSTP => sclr,
      RSTM => sclr,
      RSTCARRYIN => br(16),
      SUBTRACT => br(16),
      A(17) => br(16),
      A(16) => br(16),
      A(15) => br(16),
      A(14) => br(16),
      A(13) => br(16),
      A(12) => N1,
      A(11) => N1,
      A(10) => br(16),
      A(9) => br(16),
      A(8) => N1,
      A(7) => br(16),
      A(6) => br(16),
      A(5) => br(16),
      A(4) => br(16),
      A(3) => N1,
      A(2) => N1,
      A(1) => N1,
      A(0) => N1,
      PCIN(47) => NLW_Maddsub_pr_mult0000_PCIN_47_UNCONNECTED,
      PCIN(46) => NLW_Maddsub_pr_mult0000_PCIN_46_UNCONNECTED,
      PCIN(45) => NLW_Maddsub_pr_mult0000_PCIN_45_UNCONNECTED,
      PCIN(44) => NLW_Maddsub_pr_mult0000_PCIN_44_UNCONNECTED,
      PCIN(43) => NLW_Maddsub_pr_mult0000_PCIN_43_UNCONNECTED,
      PCIN(42) => NLW_Maddsub_pr_mult0000_PCIN_42_UNCONNECTED,
      PCIN(41) => NLW_Maddsub_pr_mult0000_PCIN_41_UNCONNECTED,
      PCIN(40) => NLW_Maddsub_pr_mult0000_PCIN_40_UNCONNECTED,
      PCIN(39) => NLW_Maddsub_pr_mult0000_PCIN_39_UNCONNECTED,
      PCIN(38) => NLW_Maddsub_pr_mult0000_PCIN_38_UNCONNECTED,
      PCIN(37) => NLW_Maddsub_pr_mult0000_PCIN_37_UNCONNECTED,
      PCIN(36) => NLW_Maddsub_pr_mult0000_PCIN_36_UNCONNECTED,
      PCIN(35) => NLW_Maddsub_pr_mult0000_PCIN_35_UNCONNECTED,
      PCIN(34) => NLW_Maddsub_pr_mult0000_PCIN_34_UNCONNECTED,
      PCIN(33) => NLW_Maddsub_pr_mult0000_PCIN_33_UNCONNECTED,
      PCIN(32) => NLW_Maddsub_pr_mult0000_PCIN_32_UNCONNECTED,
      PCIN(31) => NLW_Maddsub_pr_mult0000_PCIN_31_UNCONNECTED,
      PCIN(30) => NLW_Maddsub_pr_mult0000_PCIN_30_UNCONNECTED,
      PCIN(29) => NLW_Maddsub_pr_mult0000_PCIN_29_UNCONNECTED,
      PCIN(28) => NLW_Maddsub_pr_mult0000_PCIN_28_UNCONNECTED,
      PCIN(27) => NLW_Maddsub_pr_mult0000_PCIN_27_UNCONNECTED,
      PCIN(26) => NLW_Maddsub_pr_mult0000_PCIN_26_UNCONNECTED,
      PCIN(25) => NLW_Maddsub_pr_mult0000_PCIN_25_UNCONNECTED,
      PCIN(24) => NLW_Maddsub_pr_mult0000_PCIN_24_UNCONNECTED,
      PCIN(23) => NLW_Maddsub_pr_mult0000_PCIN_23_UNCONNECTED,
      PCIN(22) => NLW_Maddsub_pr_mult0000_PCIN_22_UNCONNECTED,
      PCIN(21) => NLW_Maddsub_pr_mult0000_PCIN_21_UNCONNECTED,
      PCIN(20) => NLW_Maddsub_pr_mult0000_PCIN_20_UNCONNECTED,
      PCIN(19) => NLW_Maddsub_pr_mult0000_PCIN_19_UNCONNECTED,
      PCIN(18) => NLW_Maddsub_pr_mult0000_PCIN_18_UNCONNECTED,
      PCIN(17) => NLW_Maddsub_pr_mult0000_PCIN_17_UNCONNECTED,
      PCIN(16) => NLW_Maddsub_pr_mult0000_PCIN_16_UNCONNECTED,
      PCIN(15) => NLW_Maddsub_pr_mult0000_PCIN_15_UNCONNECTED,
      PCIN(14) => NLW_Maddsub_pr_mult0000_PCIN_14_UNCONNECTED,
      PCIN(13) => NLW_Maddsub_pr_mult0000_PCIN_13_UNCONNECTED,
      PCIN(12) => NLW_Maddsub_pr_mult0000_PCIN_12_UNCONNECTED,
      PCIN(11) => NLW_Maddsub_pr_mult0000_PCIN_11_UNCONNECTED,
      PCIN(10) => NLW_Maddsub_pr_mult0000_PCIN_10_UNCONNECTED,
      PCIN(9) => NLW_Maddsub_pr_mult0000_PCIN_9_UNCONNECTED,
      PCIN(8) => NLW_Maddsub_pr_mult0000_PCIN_8_UNCONNECTED,
      PCIN(7) => NLW_Maddsub_pr_mult0000_PCIN_7_UNCONNECTED,
      PCIN(6) => NLW_Maddsub_pr_mult0000_PCIN_6_UNCONNECTED,
      PCIN(5) => NLW_Maddsub_pr_mult0000_PCIN_5_UNCONNECTED,
      PCIN(4) => NLW_Maddsub_pr_mult0000_PCIN_4_UNCONNECTED,
      PCIN(3) => NLW_Maddsub_pr_mult0000_PCIN_3_UNCONNECTED,
      PCIN(2) => NLW_Maddsub_pr_mult0000_PCIN_2_UNCONNECTED,
      PCIN(1) => NLW_Maddsub_pr_mult0000_PCIN_1_UNCONNECTED,
      PCIN(0) => NLW_Maddsub_pr_mult0000_PCIN_0_UNCONNECTED,
      B(17) => a(8),
      B(16) => a(8),
      B(15) => a(8),
      B(14) => a(8),
      B(13) => a(8),
      B(12) => a(8),
      B(11) => a(8),
      B(10) => a(8),
      B(9) => a(8),
      B(8) => a(8),
      B(7) => a(7),
      B(6) => a(6),
      B(5) => a(5),
      B(4) => a(4),
      B(3) => a(3),
      B(2) => a(2),
      B(1) => a(1),
      B(0) => a(0),
      C(47) => c(25),
      C(46) => c(25),
      C(45) => c(25),
      C(44) => c(25),
      C(43) => c(25),
      C(42) => c(25),
      C(41) => c(25),
      C(40) => c(25),
      C(39) => c(25),
      C(38) => c(25),
      C(37) => c(25),
      C(36) => c(25),
      C(35) => c(25),
      C(34) => c(25),
      C(33) => c(25),
      C(32) => c(25),
      C(31) => c(25),
      C(30) => c(25),
      C(29) => c(25),
      C(28) => c(25),
      C(27) => c(25),
      C(26) => c(25),
      C(25) => c(25),
      C(24) => c(24),
      C(23) => c(23),
      C(22) => c(22),
      C(21) => c(21),
      C(20) => c(20),
      C(19) => c(19),
      C(18) => c(18),
      C(17) => c(17),
      C(16) => c(16),
      C(15) => c(15),
      C(14) => c(14),
      C(13) => c(13),
      C(12) => c(12),
      C(11) => c(11),
      C(10) => c(10),
      C(9) => c(9),
      C(8) => c(8),
      C(7) => c(7),
      C(6) => c(6),
      C(5) => c(5),
      C(4) => c(4),
      C(3) => c(3),
      C(2) => c(2),
      C(1) => c(1),
      C(0) => c(0),
      CARRYINSEL(1) => br(16),
      CARRYINSEL(0) => br(16),
      OPMODE(6) => br(16),
      OPMODE(5) => N1,
      OPMODE(4) => N1,
      OPMODE(3) => br(16),
      OPMODE(2) => N1,
      OPMODE(1) => br(16),
      OPMODE(0) => N1,
      BCIN(17) => NLW_Maddsub_pr_mult0000_BCIN_17_UNCONNECTED,
      BCIN(16) => NLW_Maddsub_pr_mult0000_BCIN_16_UNCONNECTED,
      BCIN(15) => NLW_Maddsub_pr_mult0000_BCIN_15_UNCONNECTED,
      BCIN(14) => NLW_Maddsub_pr_mult0000_BCIN_14_UNCONNECTED,
      BCIN(13) => NLW_Maddsub_pr_mult0000_BCIN_13_UNCONNECTED,
      BCIN(12) => NLW_Maddsub_pr_mult0000_BCIN_12_UNCONNECTED,
      BCIN(11) => NLW_Maddsub_pr_mult0000_BCIN_11_UNCONNECTED,
      BCIN(10) => NLW_Maddsub_pr_mult0000_BCIN_10_UNCONNECTED,
      BCIN(9) => NLW_Maddsub_pr_mult0000_BCIN_9_UNCONNECTED,
      BCIN(8) => NLW_Maddsub_pr_mult0000_BCIN_8_UNCONNECTED,
      BCIN(7) => NLW_Maddsub_pr_mult0000_BCIN_7_UNCONNECTED,
      BCIN(6) => NLW_Maddsub_pr_mult0000_BCIN_6_UNCONNECTED,
      BCIN(5) => NLW_Maddsub_pr_mult0000_BCIN_5_UNCONNECTED,
      BCIN(4) => NLW_Maddsub_pr_mult0000_BCIN_4_UNCONNECTED,
      BCIN(3) => NLW_Maddsub_pr_mult0000_BCIN_3_UNCONNECTED,
      BCIN(2) => NLW_Maddsub_pr_mult0000_BCIN_2_UNCONNECTED,
      BCIN(1) => NLW_Maddsub_pr_mult0000_BCIN_1_UNCONNECTED,
      BCIN(0) => NLW_Maddsub_pr_mult0000_BCIN_0_UNCONNECTED,
      PCOUT(47) => NLW_Maddsub_pr_mult0000_PCOUT_47_UNCONNECTED,
      PCOUT(46) => NLW_Maddsub_pr_mult0000_PCOUT_46_UNCONNECTED,
      PCOUT(45) => NLW_Maddsub_pr_mult0000_PCOUT_45_UNCONNECTED,
      PCOUT(44) => NLW_Maddsub_pr_mult0000_PCOUT_44_UNCONNECTED,
      PCOUT(43) => NLW_Maddsub_pr_mult0000_PCOUT_43_UNCONNECTED,
      PCOUT(42) => NLW_Maddsub_pr_mult0000_PCOUT_42_UNCONNECTED,
      PCOUT(41) => NLW_Maddsub_pr_mult0000_PCOUT_41_UNCONNECTED,
      PCOUT(40) => NLW_Maddsub_pr_mult0000_PCOUT_40_UNCONNECTED,
      PCOUT(39) => NLW_Maddsub_pr_mult0000_PCOUT_39_UNCONNECTED,
      PCOUT(38) => NLW_Maddsub_pr_mult0000_PCOUT_38_UNCONNECTED,
      PCOUT(37) => NLW_Maddsub_pr_mult0000_PCOUT_37_UNCONNECTED,
      PCOUT(36) => NLW_Maddsub_pr_mult0000_PCOUT_36_UNCONNECTED,
      PCOUT(35) => NLW_Maddsub_pr_mult0000_PCOUT_35_UNCONNECTED,
      PCOUT(34) => NLW_Maddsub_pr_mult0000_PCOUT_34_UNCONNECTED,
      PCOUT(33) => NLW_Maddsub_pr_mult0000_PCOUT_33_UNCONNECTED,
      PCOUT(32) => NLW_Maddsub_pr_mult0000_PCOUT_32_UNCONNECTED,
      PCOUT(31) => NLW_Maddsub_pr_mult0000_PCOUT_31_UNCONNECTED,
      PCOUT(30) => NLW_Maddsub_pr_mult0000_PCOUT_30_UNCONNECTED,
      PCOUT(29) => NLW_Maddsub_pr_mult0000_PCOUT_29_UNCONNECTED,
      PCOUT(28) => NLW_Maddsub_pr_mult0000_PCOUT_28_UNCONNECTED,
      PCOUT(27) => NLW_Maddsub_pr_mult0000_PCOUT_27_UNCONNECTED,
      PCOUT(26) => NLW_Maddsub_pr_mult0000_PCOUT_26_UNCONNECTED,
      PCOUT(25) => NLW_Maddsub_pr_mult0000_PCOUT_25_UNCONNECTED,
      PCOUT(24) => NLW_Maddsub_pr_mult0000_PCOUT_24_UNCONNECTED,
      PCOUT(23) => NLW_Maddsub_pr_mult0000_PCOUT_23_UNCONNECTED,
      PCOUT(22) => NLW_Maddsub_pr_mult0000_PCOUT_22_UNCONNECTED,
      PCOUT(21) => NLW_Maddsub_pr_mult0000_PCOUT_21_UNCONNECTED,
      PCOUT(20) => NLW_Maddsub_pr_mult0000_PCOUT_20_UNCONNECTED,
      PCOUT(19) => NLW_Maddsub_pr_mult0000_PCOUT_19_UNCONNECTED,
      PCOUT(18) => NLW_Maddsub_pr_mult0000_PCOUT_18_UNCONNECTED,
      PCOUT(17) => NLW_Maddsub_pr_mult0000_PCOUT_17_UNCONNECTED,
      PCOUT(16) => NLW_Maddsub_pr_mult0000_PCOUT_16_UNCONNECTED,
      PCOUT(15) => NLW_Maddsub_pr_mult0000_PCOUT_15_UNCONNECTED,
      PCOUT(14) => NLW_Maddsub_pr_mult0000_PCOUT_14_UNCONNECTED,
      PCOUT(13) => NLW_Maddsub_pr_mult0000_PCOUT_13_UNCONNECTED,
      PCOUT(12) => NLW_Maddsub_pr_mult0000_PCOUT_12_UNCONNECTED,
      PCOUT(11) => NLW_Maddsub_pr_mult0000_PCOUT_11_UNCONNECTED,
      PCOUT(10) => NLW_Maddsub_pr_mult0000_PCOUT_10_UNCONNECTED,
      PCOUT(9) => NLW_Maddsub_pr_mult0000_PCOUT_9_UNCONNECTED,
      PCOUT(8) => NLW_Maddsub_pr_mult0000_PCOUT_8_UNCONNECTED,
      PCOUT(7) => NLW_Maddsub_pr_mult0000_PCOUT_7_UNCONNECTED,
      PCOUT(6) => NLW_Maddsub_pr_mult0000_PCOUT_6_UNCONNECTED,
      PCOUT(5) => NLW_Maddsub_pr_mult0000_PCOUT_5_UNCONNECTED,
      PCOUT(4) => NLW_Maddsub_pr_mult0000_PCOUT_4_UNCONNECTED,
      PCOUT(3) => NLW_Maddsub_pr_mult0000_PCOUT_3_UNCONNECTED,
      PCOUT(2) => NLW_Maddsub_pr_mult0000_PCOUT_2_UNCONNECTED,
      PCOUT(1) => NLW_Maddsub_pr_mult0000_PCOUT_1_UNCONNECTED,
      PCOUT(0) => NLW_Maddsub_pr_mult0000_PCOUT_0_UNCONNECTED,
      P(47) => NLW_Maddsub_pr_mult0000_P_47_UNCONNECTED,
      P(46) => NLW_Maddsub_pr_mult0000_P_46_UNCONNECTED,
      P(45) => NLW_Maddsub_pr_mult0000_P_45_UNCONNECTED,
      P(44) => NLW_Maddsub_pr_mult0000_P_44_UNCONNECTED,
      P(43) => NLW_Maddsub_pr_mult0000_P_43_UNCONNECTED,
      P(42) => NLW_Maddsub_pr_mult0000_P_42_UNCONNECTED,
      P(41) => NLW_Maddsub_pr_mult0000_P_41_UNCONNECTED,
      P(40) => NLW_Maddsub_pr_mult0000_P_40_UNCONNECTED,
      P(39) => NLW_Maddsub_pr_mult0000_P_39_UNCONNECTED,
      P(38) => NLW_Maddsub_pr_mult0000_P_38_UNCONNECTED,
      P(37) => NLW_Maddsub_pr_mult0000_P_37_UNCONNECTED,
      P(36) => NLW_Maddsub_pr_mult0000_P_36_UNCONNECTED,
      P(35) => NLW_Maddsub_pr_mult0000_P_35_UNCONNECTED,
      P(34) => NLW_Maddsub_pr_mult0000_P_34_UNCONNECTED,
      P(33) => NLW_Maddsub_pr_mult0000_P_33_UNCONNECTED,
      P(32) => NLW_Maddsub_pr_mult0000_P_32_UNCONNECTED,
      P(31) => NLW_Maddsub_pr_mult0000_P_31_UNCONNECTED,
      P(30) => NLW_Maddsub_pr_mult0000_P_30_UNCONNECTED,
      P(29) => NLW_Maddsub_pr_mult0000_P_29_UNCONNECTED,
      P(28) => NLW_Maddsub_pr_mult0000_P_28_UNCONNECTED,
      P(27) => NLW_Maddsub_pr_mult0000_P_27_UNCONNECTED,
      P(26) => NLW_Maddsub_pr_mult0000_P_26_UNCONNECTED,
      P(25) => p(25),
      P(24) => p(24),
      P(23) => p(23),
      P(22) => p(22),
      P(21) => p(21),
      P(20) => p(20),
      P(19) => p(19),
      P(18) => p(18),
      P(17) => p(17),
      P(16) => p(16),
      P(15) => p(15),
      P(14) => p(14),
      P(13) => p(13),
      P(12) => p(12),
      P(11) => p(11),
      P(10) => p(10),
      P(9) => p(9),
      P(8) => p(8),
      P(7) => p(7),
      P(6) => p(6),
      P(5) => p(5),
      P(4) => p(4),
      P(3) => p(3),
      P(2) => p(2),
      P(1) => p(1),
      P(0) => p(0),
      BCOUT(17) => NLW_Maddsub_pr_mult0000_BCOUT_17_UNCONNECTED,
      BCOUT(16) => NLW_Maddsub_pr_mult0000_BCOUT_16_UNCONNECTED,
      BCOUT(15) => NLW_Maddsub_pr_mult0000_BCOUT_15_UNCONNECTED,
      BCOUT(14) => NLW_Maddsub_pr_mult0000_BCOUT_14_UNCONNECTED,
      BCOUT(13) => NLW_Maddsub_pr_mult0000_BCOUT_13_UNCONNECTED,
      BCOUT(12) => NLW_Maddsub_pr_mult0000_BCOUT_12_UNCONNECTED,
      BCOUT(11) => NLW_Maddsub_pr_mult0000_BCOUT_11_UNCONNECTED,
      BCOUT(10) => NLW_Maddsub_pr_mult0000_BCOUT_10_UNCONNECTED,
      BCOUT(9) => NLW_Maddsub_pr_mult0000_BCOUT_9_UNCONNECTED,
      BCOUT(8) => NLW_Maddsub_pr_mult0000_BCOUT_8_UNCONNECTED,
      BCOUT(7) => NLW_Maddsub_pr_mult0000_BCOUT_7_UNCONNECTED,
      BCOUT(6) => NLW_Maddsub_pr_mult0000_BCOUT_6_UNCONNECTED,
      BCOUT(5) => NLW_Maddsub_pr_mult0000_BCOUT_5_UNCONNECTED,
      BCOUT(4) => NLW_Maddsub_pr_mult0000_BCOUT_4_UNCONNECTED,
      BCOUT(3) => NLW_Maddsub_pr_mult0000_BCOUT_3_UNCONNECTED,
      BCOUT(2) => NLW_Maddsub_pr_mult0000_BCOUT_2_UNCONNECTED,
      BCOUT(1) => NLW_Maddsub_pr_mult0000_BCOUT_1_UNCONNECTED,
      BCOUT(0) => NLW_Maddsub_pr_mult0000_BCOUT_0_UNCONNECTED
    );

end STRUCTURE;

-- synthesis translate_on

-- synthesis translate_off
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity rgb2ycrcb_v1_0 is
  port (
    sclr : in STD_LOGIC := 'X'; 
    ce : in STD_LOGIC := 'X'; 
    h_sync_out : out STD_LOGIC; 
    pix_en_out : out STD_LOGIC; 
    pix_en_in : in STD_LOGIC := 'X'; 
    clk : in STD_LOGIC := 'X'; 
    v_sync_out : out STD_LOGIC; 
    h_sync_in : in STD_LOGIC := 'X'; 
    v_sync_in : in STD_LOGIC := 'X'; 
    cb : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    cr : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    b : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    g : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    r : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    y : out STD_LOGIC_VECTOR ( 7 downto 0 ) 
  );
end rgb2ycrcb_v1_0;

architecture STRUCTURE of rgb2ycrcb_v1_0 is
  component mac_1
    port (
      clk : in STD_LOGIC := 'X'; 
      ce : in STD_LOGIC := 'X'; 
      sclr : in STD_LOGIC := 'X'; 
      p : out STD_LOGIC_VECTOR ( 25 downto 0 ); 
      a : in STD_LOGIC_VECTOR ( 8 downto 0 ); 
      b : in STD_LOGIC_VECTOR ( 16 downto 0 ); 
      c : in STD_LOGIC_VECTOR ( 25 downto 0 ) 
    );
  end component;
  component mac_2
    port (
      clk : in STD_LOGIC := 'X'; 
      ce : in STD_LOGIC := 'X'; 
      sclr : in STD_LOGIC := 'X'; 
      p : out STD_LOGIC_VECTOR ( 11 downto 0 ); 
      a : in STD_LOGIC_VECTOR ( 17 downto 0 ); 
      b : in STD_LOGIC_VECTOR ( 16 downto 0 ); 
      c : in STD_LOGIC_VECTOR ( 11 downto 0 ) 
    );
  end component;
  component mac_2_INST_1
    port (
      clk : in STD_LOGIC := 'X'; 
      ce : in STD_LOGIC := 'X'; 
      sclr : in STD_LOGIC := 'X'; 
      p : out STD_LOGIC_VECTOR ( 11 downto 0 ); 
      a : in STD_LOGIC_VECTOR ( 17 downto 0 ); 
      b : in STD_LOGIC_VECTOR ( 16 downto 0 ); 
      c : in STD_LOGIC_VECTOR ( 11 downto 0 ) 
    );
  end component;
  signal BU2_v_sync_out11 : STD_LOGIC; 
  signal BU2_pix_en_out11 : STD_LOGIC; 
  signal BU2_h_sync_out11 : STD_LOGIC; 
  signal BU2_sclr_shift10_781 : STD_LOGIC; 
  signal BU2_sclr_shift9_780 : STD_LOGIC; 
  signal BU2_sclr_shift8_779 : STD_LOGIC; 
  signal BU2_sclr_shift7_778 : STD_LOGIC; 
  signal BU2_sclr_shift6_777 : STD_LOGIC; 
  signal BU2_sclr_shift5_776 : STD_LOGIC; 
  signal BU2_sclr_shift4_775 : STD_LOGIC; 
  signal BU2_sclr_shift3_774 : STD_LOGIC; 
  signal BU2_sclr_shift2_773 : STD_LOGIC; 
  signal BU2_sclr_shift1_772 : STD_LOGIC; 
  signal BU2_pix_en_out1_771 : STD_LOGIC; 
  signal BU2_Mshreg_pix_en_out_770 : STD_LOGIC; 
  signal BU2_v_sync_out1_769 : STD_LOGIC; 
  signal BU2_Mshreg_v_sync_out_768 : STD_LOGIC; 
  signal BU2_h_sync_out1_767 : STD_LOGIC; 
  signal BU2_Mshreg_h_sync_out_766 : STD_LOGIC; 
  signal BU2_U0_del_G_Mshreg_shift_register_4_7_765 : STD_LOGIC; 
  signal BU2_U0_del_G_Mshreg_shift_register_4_6_764 : STD_LOGIC; 
  signal BU2_U0_del_G_Mshreg_shift_register_4_5_763 : STD_LOGIC; 
  signal BU2_U0_del_G_Mshreg_shift_register_4_3_762 : STD_LOGIC; 
  signal BU2_U0_del_G_Mshreg_shift_register_4_2_761 : STD_LOGIC; 
  signal BU2_U0_del_G_Mshreg_shift_register_4_4_760 : STD_LOGIC; 
  signal BU2_U0_del_G_Mshreg_shift_register_4_1_759 : STD_LOGIC; 
  signal BU2_U0_del_G_Mshreg_shift_register_4_0_758 : STD_LOGIC; 
  signal BU2_U0_del_R_Mshreg_shift_register_5_7_757 : STD_LOGIC; 
  signal BU2_U0_del_R_Mshreg_shift_register_5_6_756 : STD_LOGIC; 
  signal BU2_U0_del_R_Mshreg_shift_register_5_5_755 : STD_LOGIC; 
  signal BU2_U0_del_R_Mshreg_shift_register_5_4_754 : STD_LOGIC; 
  signal BU2_U0_del_R_Mshreg_shift_register_5_2_753 : STD_LOGIC; 
  signal BU2_U0_del_R_Mshreg_shift_register_5_1_752 : STD_LOGIC; 
  signal BU2_U0_del_R_Mshreg_shift_register_5_3_751 : STD_LOGIC; 
  signal BU2_U0_del_R_Mshreg_shift_register_5_0_750 : STD_LOGIC; 
  signal BU2_U0_del_B_Mshreg_shift_register_5_7_749 : STD_LOGIC; 
  signal BU2_U0_del_B_Mshreg_shift_register_5_6_748 : STD_LOGIC; 
  signal BU2_U0_del_B_Mshreg_shift_register_5_5_747 : STD_LOGIC; 
  signal BU2_U0_del_B_Mshreg_shift_register_5_4_746 : STD_LOGIC; 
  signal BU2_U0_del_B_Mshreg_shift_register_5_3_745 : STD_LOGIC; 
  signal BU2_U0_del_B_Mshreg_shift_register_5_1_744 : STD_LOGIC; 
  signal BU2_U0_del_B_Mshreg_shift_register_5_0_743 : STD_LOGIC; 
  signal BU2_U0_del_B_Mshreg_shift_register_5_2_742 : STD_LOGIC; 
  signal BU2_U0_del_Y_Mshreg_shift_register_3_9_741 : STD_LOGIC; 
  signal BU2_U0_del_Y_Mshreg_shift_register_3_8_740 : STD_LOGIC; 
  signal BU2_U0_del_Y_Mshreg_shift_register_3_6_739 : STD_LOGIC; 
  signal BU2_U0_del_Y_Mshreg_shift_register_3_5_738 : STD_LOGIC; 
  signal BU2_U0_del_Y_Mshreg_shift_register_3_7_737 : STD_LOGIC; 
  signal BU2_U0_del_Y_Mshreg_shift_register_3_4_736 : STD_LOGIC; 
  signal BU2_U0_del_Y_Mshreg_shift_register_3_3_735 : STD_LOGIC; 
  signal BU2_U0_del_Y_Mshreg_shift_register_3_1_734 : STD_LOGIC; 
  signal BU2_U0_del_Y_Mshreg_shift_register_3_0_733 : STD_LOGIC; 
  signal BU2_U0_del_Y_Mshreg_shift_register_3_2_732 : STD_LOGIC; 
  signal BU2_U0_del_Y_shift_register_3_0_731 : STD_LOGIC; 
  signal BU2_U0_del_Y_shift_register_3_1_730 : STD_LOGIC; 
  signal BU2_U0_del_Y_shift_register_3_2_729 : STD_LOGIC; 
  signal BU2_U0_del_Y_shift_register_3_3_728 : STD_LOGIC; 
  signal BU2_U0_del_Y_shift_register_3_4_727 : STD_LOGIC; 
  signal BU2_U0_del_Y_shift_register_3_5_726 : STD_LOGIC; 
  signal BU2_U0_del_Y_shift_register_3_6_725 : STD_LOGIC; 
  signal BU2_U0_del_Y_shift_register_3_7_724 : STD_LOGIC; 
  signal BU2_U0_del_Y_shift_register_3_8_723 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_reg_shift_register_1_0_722 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_c_0_Q : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_reg_shift_register_1_1_720 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_c_1_Q : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_reg_shift_register_1_2_718 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_c_2_Q : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_reg_shift_register_1_3_716 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_c_3_Q : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_reg_shift_register_1_4_714 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_c_4_Q : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_reg_shift_register_1_5_712 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_c_5_Q : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_reg_shift_register_1_6_710 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_c_6_Q : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_reg_shift_register_1_7_708 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_c_7_Q : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_reg_shift_register_1_9_706 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cb_reg_shift_register_1_0_705 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cb_reg_shift_register_1_1_703 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cb_reg_shift_register_1_2_701 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cb_reg_shift_register_1_3_699 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cb_reg_shift_register_1_4_697 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cb_reg_shift_register_1_5_695 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cb_reg_shift_register_1_6_693 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cb_reg_shift_register_1_7_691 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cb_reg_shift_register_1_9_689 : STD_LOGIC; 
  signal BU2_U0_clip_max_Y_reg_shift_register_1_0_688 : STD_LOGIC; 
  signal BU2_U0_clip_max_Y_reg_shift_register_1_1_686 : STD_LOGIC; 
  signal BU2_U0_clip_max_Y_reg_shift_register_1_2_684 : STD_LOGIC; 
  signal BU2_U0_clip_max_Y_reg_shift_register_1_3_682 : STD_LOGIC; 
  signal BU2_U0_clip_max_Y_reg_shift_register_1_4_680 : STD_LOGIC; 
  signal BU2_U0_clip_max_Y_reg_shift_register_1_5_678 : STD_LOGIC; 
  signal BU2_U0_clip_max_Y_reg_shift_register_1_6_676 : STD_LOGIC; 
  signal BU2_U0_clip_max_Y_reg_shift_register_1_7_674 : STD_LOGIC; 
  signal BU2_U0_clip_max_Y_reg_shift_register_1_9_672 : STD_LOGIC; 
  signal BU2_U0_del_Y_shift_register_3_9_671 : STD_LOGIC; 
  signal BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_6_rt_559 : STD_LOGIC; 
  signal BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_7_rt_557 : STD_LOGIC; 
  signal BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_8_rt_554 : STD_LOGIC; 
  signal BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_9_rt_551 : STD_LOGIC; 
  signal BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_10_rt_548 : STD_LOGIC; 
  signal BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_11_rt_545 : STD_LOGIC; 
  signal BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_12_rt_542 : STD_LOGIC; 
  signal BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_13_rt_539 : STD_LOGIC; 
  signal BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_14_rt_536 : STD_LOGIC; 
  signal BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_15_rt_533 : STD_LOGIC; 
  signal BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_16_rt_530 : STD_LOGIC; 
  signal BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_17_rt_527 : STD_LOGIC; 
  signal BU2_U0_del_R_shift_register_5_0_505 : STD_LOGIC; 
  signal BU2_U0_del_R_shift_register_5_1_501 : STD_LOGIC; 
  signal BU2_U0_del_R_shift_register_5_2_497 : STD_LOGIC; 
  signal BU2_U0_del_R_shift_register_5_3_493 : STD_LOGIC; 
  signal BU2_U0_del_R_shift_register_5_4_489 : STD_LOGIC; 
  signal BU2_U0_del_R_shift_register_5_5_485 : STD_LOGIC; 
  signal BU2_U0_del_R_shift_register_5_6_481 : STD_LOGIC; 
  signal BU2_U0_del_R_shift_register_5_7_477 : STD_LOGIC; 
  signal BU2_U0_del_G_shift_register_4_0_464 : STD_LOGIC; 
  signal BU2_U0_del_G_shift_register_4_1_461 : STD_LOGIC; 
  signal BU2_U0_del_G_shift_register_4_2_457 : STD_LOGIC; 
  signal BU2_U0_del_G_shift_register_4_3_453 : STD_LOGIC; 
  signal BU2_U0_del_G_shift_register_4_4_449 : STD_LOGIC; 
  signal BU2_U0_del_G_shift_register_4_5_445 : STD_LOGIC; 
  signal BU2_U0_del_G_shift_register_4_6_441 : STD_LOGIC; 
  signal BU2_U0_del_G_shift_register_4_7_437 : STD_LOGIC; 
  signal BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy_15_rt_432 : STD_LOGIC; 
  signal BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_xor_16_rt_429 : STD_LOGIC; 
  signal BU2_U0_del_B_shift_register_5_0_406 : STD_LOGIC; 
  signal BU2_U0_del_B_shift_register_5_1_401 : STD_LOGIC; 
  signal BU2_U0_del_B_shift_register_5_2_396 : STD_LOGIC; 
  signal BU2_U0_del_B_shift_register_5_3_391 : STD_LOGIC; 
  signal BU2_U0_del_B_shift_register_5_4_386 : STD_LOGIC; 
  signal BU2_U0_del_B_shift_register_5_5_381 : STD_LOGIC; 
  signal BU2_U0_del_B_shift_register_5_6_376 : STD_LOGIC; 
  signal BU2_U0_del_B_shift_register_5_7_371 : STD_LOGIC; 
  signal BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_17_1 : STD_LOGIC; 
  signal BU2_U0_clip_max_Cr_c_9_Q : STD_LOGIC; 
  signal BU2_N1 : STD_LOGIC; 
  signal BU2_N0 : STD_LOGIC; 
  signal NLW_BU2_U0_v4_mac23_mac_cBY_p_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_v4_mac23_mac_cBY_p_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_v4_mac23_mac_cRY_p_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_v4_mac23_mac_cRY_p_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_v4_mac1_mult_aCr_p_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_v4_mac1_mult_aCr_p_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_v4_mac1_mult_aCr_p_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_v4_mac1_mult_aCr_p_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_v4_mac1_mult_aCr_p_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_v4_mac1_mult_aCr_p_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_v4_mac1_mult_aCr_p_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_v4_mac1_mult_aCr_p_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_v4_mac1_mult_aCr_p_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_v4_mac1_mult_aCr_p_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_VCC_P_UNCONNECTED : STD_LOGIC; 
  signal NLW_GND_G_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_CECARRYIN_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_C_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_P_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_0_UNCONNECTED : STD_LOGIC; 
  signal BU2_U0_clip_max_Cb_c : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_clip_max_Y_c : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_clamp_min_Cr_c : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_clamp_min_Cb_c : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_clamp_min_Y_c : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s : STD_LOGIC_VECTOR ( 16 downto 0 ); 
  signal BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s : STD_LOGIC_VECTOR ( 17 downto 0 ); 
  signal BU2_U0_sub_RG_use_fabric_adder_out_s : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_sub_BG_use_fabric_adder_c : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_sub_RG_use_fabric_adder_c : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c : STD_LOGIC_VECTOR ( 17 downto 6 ); 
  signal BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy : STD_LOGIC_VECTOR ( 16 downto 6 ); 
  signal BU2_U0_sub_RY_use_fabric_adder_c : STD_LOGIC_VECTOR ( 17 downto 0 ); 
  signal BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut : STD_LOGIC_VECTOR ( 16 downto 0 ); 
  signal BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy : STD_LOGIC_VECTOR ( 16 downto 0 ); 
  signal BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut : STD_LOGIC_VECTOR ( 17 downto 0 ); 
  signal BU2_U0_add_aRG_bBG_G_use_fabric_adder_c : STD_LOGIC_VECTOR ( 16 downto 7 ); 
  signal BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut : STD_LOGIC_VECTOR ( 14 downto 7 ); 
  signal BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy : STD_LOGIC_VECTOR ( 15 downto 7 ); 
  signal BU2_U0_sub_BY_use_fabric_adder_c : STD_LOGIC_VECTOR ( 17 downto 0 ); 
  signal BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy : STD_LOGIC_VECTOR ( 16 downto 0 ); 
  signal BU2_U0_rgm : STD_LOGIC_VECTOR ( 24 downto 0 ); 
  signal BU2_U0_sub_BG_use_fabric_adder_out_s : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_y_inta_raw : STD_LOGIC_VECTOR ( 24 downto 9 ); 
  signal BU2_U0_sub_RY_use_fabric_adder_out_s : STD_LOGIC_VECTOR ( 17 downto 0 ); 
  signal BU2_U0_cr_int : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_sub_BY_use_fabric_adder_out_s : STD_LOGIC_VECTOR ( 17 downto 0 ); 
  signal BU2_U0_cb_int : STD_LOGIC_VECTOR ( 9 downto 0 ); 
begin
  VCC_0 : VCC
    port map (
      P => NLW_VCC_P_UNCONNECTED
    );
  GND_1 : GND
    port map (
      G => NLW_GND_G_UNCONNECTED
    );
  BU2_v_sync_out2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_v_sync_out11,
      R => sclr,
      Q => v_sync_out
    );
  BU2_v_sync_out1 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_v_sync_out1_769,
      I1 => BU2_sclr_shift10_781,
      O => BU2_v_sync_out11
    );
  BU2_pix_en_out2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_pix_en_out11,
      R => sclr,
      Q => pix_en_out
    );
  BU2_pix_en_out1 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_pix_en_out1_771,
      I1 => BU2_sclr_shift10_781,
      O => BU2_pix_en_out11
    );
  BU2_h_sync_out2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_h_sync_out11,
      R => sclr,
      Q => h_sync_out
    );
  BU2_h_sync_out1 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => BU2_h_sync_out1_767,
      I1 => BU2_sclr_shift10_781,
      O => BU2_h_sync_out11
    );
  BU2_sclr_shift10 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => BU2_sclr_shift9_780,
      R => sclr,
      Q => BU2_sclr_shift10_781
    );
  BU2_sclr_shift9 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => BU2_sclr_shift8_779,
      R => sclr,
      Q => BU2_sclr_shift9_780
    );
  BU2_sclr_shift8 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => BU2_sclr_shift7_778,
      R => sclr,
      Q => BU2_sclr_shift8_779
    );
  BU2_sclr_shift7 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => BU2_sclr_shift6_777,
      R => sclr,
      Q => BU2_sclr_shift7_778
    );
  BU2_sclr_shift6 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => BU2_sclr_shift5_776,
      R => sclr,
      Q => BU2_sclr_shift6_777
    );
  BU2_sclr_shift5 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => BU2_sclr_shift4_775,
      R => sclr,
      Q => BU2_sclr_shift5_776
    );
  BU2_sclr_shift4 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => BU2_sclr_shift3_774,
      R => sclr,
      Q => BU2_sclr_shift4_775
    );
  BU2_sclr_shift3 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => BU2_sclr_shift2_773,
      R => sclr,
      Q => BU2_sclr_shift3_774
    );
  BU2_sclr_shift2 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => BU2_sclr_shift1_772,
      R => sclr,
      Q => BU2_sclr_shift2_773
    );
  BU2_sclr_shift1 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => BU2_N1,
      R => sclr,
      Q => BU2_sclr_shift1_772
    );
  BU2_pix_en_out : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_Mshreg_pix_en_out_770,
      Q => BU2_pix_en_out1_771
    );
  BU2_Mshreg_pix_en_out : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N0,
      A1 => BU2_N0,
      A2 => BU2_N0,
      A3 => BU2_N1,
      CE => ce,
      CLK => clk,
      D => pix_en_in,
      Q => BU2_Mshreg_pix_en_out_770
    );
  BU2_v_sync_out : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_Mshreg_v_sync_out_768,
      Q => BU2_v_sync_out1_769
    );
  BU2_Mshreg_v_sync_out : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N0,
      A1 => BU2_N0,
      A2 => BU2_N0,
      A3 => BU2_N1,
      CE => ce,
      CLK => clk,
      D => v_sync_in,
      Q => BU2_Mshreg_v_sync_out_768
    );
  BU2_h_sync_out : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_Mshreg_h_sync_out_766,
      Q => BU2_h_sync_out1_767
    );
  BU2_Mshreg_h_sync_out : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N0,
      A1 => BU2_N0,
      A2 => BU2_N0,
      A3 => BU2_N1,
      CE => ce,
      CLK => clk,
      D => h_sync_in,
      Q => BU2_Mshreg_h_sync_out_766
    );
  BU2_U0_del_G_shift_register_4_7 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_G_Mshreg_shift_register_4_7_765,
      Q => BU2_U0_del_G_shift_register_4_7_437
    );
  BU2_U0_del_G_Mshreg_shift_register_4_7 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N0,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => g(7),
      Q => BU2_U0_del_G_Mshreg_shift_register_4_7_765
    );
  BU2_U0_del_G_shift_register_4_6 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_G_Mshreg_shift_register_4_6_764,
      Q => BU2_U0_del_G_shift_register_4_6_441
    );
  BU2_U0_del_G_Mshreg_shift_register_4_6 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N0,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => g(6),
      Q => BU2_U0_del_G_Mshreg_shift_register_4_6_764
    );
  BU2_U0_del_G_shift_register_4_5 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_G_Mshreg_shift_register_4_5_763,
      Q => BU2_U0_del_G_shift_register_4_5_445
    );
  BU2_U0_del_G_Mshreg_shift_register_4_5 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N0,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => g(5),
      Q => BU2_U0_del_G_Mshreg_shift_register_4_5_763
    );
  BU2_U0_del_G_shift_register_4_3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_G_Mshreg_shift_register_4_3_762,
      Q => BU2_U0_del_G_shift_register_4_3_453
    );
  BU2_U0_del_G_Mshreg_shift_register_4_3 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N0,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => g(3),
      Q => BU2_U0_del_G_Mshreg_shift_register_4_3_762
    );
  BU2_U0_del_G_shift_register_4_2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_G_Mshreg_shift_register_4_2_761,
      Q => BU2_U0_del_G_shift_register_4_2_457
    );
  BU2_U0_del_G_Mshreg_shift_register_4_2 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N0,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => g(2),
      Q => BU2_U0_del_G_Mshreg_shift_register_4_2_761
    );
  BU2_U0_del_G_shift_register_4_4 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_G_Mshreg_shift_register_4_4_760,
      Q => BU2_U0_del_G_shift_register_4_4_449
    );
  BU2_U0_del_G_Mshreg_shift_register_4_4 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N0,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => g(4),
      Q => BU2_U0_del_G_Mshreg_shift_register_4_4_760
    );
  BU2_U0_del_G_shift_register_4_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_G_Mshreg_shift_register_4_1_759,
      Q => BU2_U0_del_G_shift_register_4_1_461
    );
  BU2_U0_del_G_Mshreg_shift_register_4_1 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N0,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => g(1),
      Q => BU2_U0_del_G_Mshreg_shift_register_4_1_759
    );
  BU2_U0_del_G_shift_register_4_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_G_Mshreg_shift_register_4_0_758,
      Q => BU2_U0_del_G_shift_register_4_0_464
    );
  BU2_U0_del_G_Mshreg_shift_register_4_0 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N0,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => g(0),
      Q => BU2_U0_del_G_Mshreg_shift_register_4_0_758
    );
  BU2_U0_del_R_shift_register_5_7 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_R_Mshreg_shift_register_5_7_757,
      Q => BU2_U0_del_R_shift_register_5_7_477
    );
  BU2_U0_del_R_Mshreg_shift_register_5_7 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => r(7),
      Q => BU2_U0_del_R_Mshreg_shift_register_5_7_757
    );
  BU2_U0_del_R_shift_register_5_6 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_R_Mshreg_shift_register_5_6_756,
      Q => BU2_U0_del_R_shift_register_5_6_481
    );
  BU2_U0_del_R_Mshreg_shift_register_5_6 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => r(6),
      Q => BU2_U0_del_R_Mshreg_shift_register_5_6_756
    );
  BU2_U0_del_R_shift_register_5_5 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_R_Mshreg_shift_register_5_5_755,
      Q => BU2_U0_del_R_shift_register_5_5_485
    );
  BU2_U0_del_R_Mshreg_shift_register_5_5 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => r(5),
      Q => BU2_U0_del_R_Mshreg_shift_register_5_5_755
    );
  BU2_U0_del_R_shift_register_5_4 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_R_Mshreg_shift_register_5_4_754,
      Q => BU2_U0_del_R_shift_register_5_4_489
    );
  BU2_U0_del_R_Mshreg_shift_register_5_4 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => r(4),
      Q => BU2_U0_del_R_Mshreg_shift_register_5_4_754
    );
  BU2_U0_del_R_shift_register_5_2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_R_Mshreg_shift_register_5_2_753,
      Q => BU2_U0_del_R_shift_register_5_2_497
    );
  BU2_U0_del_R_Mshreg_shift_register_5_2 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => r(2),
      Q => BU2_U0_del_R_Mshreg_shift_register_5_2_753
    );
  BU2_U0_del_R_shift_register_5_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_R_Mshreg_shift_register_5_1_752,
      Q => BU2_U0_del_R_shift_register_5_1_501
    );
  BU2_U0_del_R_Mshreg_shift_register_5_1 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => r(1),
      Q => BU2_U0_del_R_Mshreg_shift_register_5_1_752
    );
  BU2_U0_del_R_shift_register_5_3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_R_Mshreg_shift_register_5_3_751,
      Q => BU2_U0_del_R_shift_register_5_3_493
    );
  BU2_U0_del_R_Mshreg_shift_register_5_3 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => r(3),
      Q => BU2_U0_del_R_Mshreg_shift_register_5_3_751
    );
  BU2_U0_del_R_shift_register_5_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_R_Mshreg_shift_register_5_0_750,
      Q => BU2_U0_del_R_shift_register_5_0_505
    );
  BU2_U0_del_R_Mshreg_shift_register_5_0 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => r(0),
      Q => BU2_U0_del_R_Mshreg_shift_register_5_0_750
    );
  BU2_U0_del_B_shift_register_5_7 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_B_Mshreg_shift_register_5_7_749,
      Q => BU2_U0_del_B_shift_register_5_7_371
    );
  BU2_U0_del_B_Mshreg_shift_register_5_7 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => b(7),
      Q => BU2_U0_del_B_Mshreg_shift_register_5_7_749
    );
  BU2_U0_del_B_shift_register_5_6 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_B_Mshreg_shift_register_5_6_748,
      Q => BU2_U0_del_B_shift_register_5_6_376
    );
  BU2_U0_del_B_Mshreg_shift_register_5_6 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => b(6),
      Q => BU2_U0_del_B_Mshreg_shift_register_5_6_748
    );
  BU2_U0_del_B_shift_register_5_5 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_B_Mshreg_shift_register_5_5_747,
      Q => BU2_U0_del_B_shift_register_5_5_381
    );
  BU2_U0_del_B_Mshreg_shift_register_5_5 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => b(5),
      Q => BU2_U0_del_B_Mshreg_shift_register_5_5_747
    );
  BU2_U0_del_B_shift_register_5_4 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_B_Mshreg_shift_register_5_4_746,
      Q => BU2_U0_del_B_shift_register_5_4_386
    );
  BU2_U0_del_B_Mshreg_shift_register_5_4 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => b(4),
      Q => BU2_U0_del_B_Mshreg_shift_register_5_4_746
    );
  BU2_U0_del_B_shift_register_5_3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_B_Mshreg_shift_register_5_3_745,
      Q => BU2_U0_del_B_shift_register_5_3_391
    );
  BU2_U0_del_B_Mshreg_shift_register_5_3 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => b(3),
      Q => BU2_U0_del_B_Mshreg_shift_register_5_3_745
    );
  BU2_U0_del_B_shift_register_5_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_B_Mshreg_shift_register_5_1_744,
      Q => BU2_U0_del_B_shift_register_5_1_401
    );
  BU2_U0_del_B_Mshreg_shift_register_5_1 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => b(1),
      Q => BU2_U0_del_B_Mshreg_shift_register_5_1_744
    );
  BU2_U0_del_B_shift_register_5_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_B_Mshreg_shift_register_5_0_743,
      Q => BU2_U0_del_B_shift_register_5_0_406
    );
  BU2_U0_del_B_Mshreg_shift_register_5_0 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => b(0),
      Q => BU2_U0_del_B_Mshreg_shift_register_5_0_743
    );
  BU2_U0_del_B_shift_register_5_2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_B_Mshreg_shift_register_5_2_742,
      Q => BU2_U0_del_B_shift_register_5_2_396
    );
  BU2_U0_del_B_Mshreg_shift_register_5_2 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N1,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => b(2),
      Q => BU2_U0_del_B_Mshreg_shift_register_5_2_742
    );
  BU2_U0_del_Y_shift_register_3_9 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_Y_Mshreg_shift_register_3_9_741,
      Q => BU2_U0_del_Y_shift_register_3_9_671
    );
  BU2_U0_del_Y_Mshreg_shift_register_3_9 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N0,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(16),
      Q => BU2_U0_del_Y_Mshreg_shift_register_3_9_741
    );
  BU2_U0_del_Y_shift_register_3_8 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_Y_Mshreg_shift_register_3_8_740,
      Q => BU2_U0_del_Y_shift_register_3_8_723
    );
  BU2_U0_del_Y_Mshreg_shift_register_3_8 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N0,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(15),
      Q => BU2_U0_del_Y_Mshreg_shift_register_3_8_740
    );
  BU2_U0_del_Y_shift_register_3_6 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_Y_Mshreg_shift_register_3_6_739,
      Q => BU2_U0_del_Y_shift_register_3_6_725
    );
  BU2_U0_del_Y_Mshreg_shift_register_3_6 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N0,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(13),
      Q => BU2_U0_del_Y_Mshreg_shift_register_3_6_739
    );
  BU2_U0_del_Y_shift_register_3_5 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_Y_Mshreg_shift_register_3_5_738,
      Q => BU2_U0_del_Y_shift_register_3_5_726
    );
  BU2_U0_del_Y_Mshreg_shift_register_3_5 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N0,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(12),
      Q => BU2_U0_del_Y_Mshreg_shift_register_3_5_738
    );
  BU2_U0_del_Y_shift_register_3_7 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_Y_Mshreg_shift_register_3_7_737,
      Q => BU2_U0_del_Y_shift_register_3_7_724
    );
  BU2_U0_del_Y_Mshreg_shift_register_3_7 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N0,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(14),
      Q => BU2_U0_del_Y_Mshreg_shift_register_3_7_737
    );
  BU2_U0_del_Y_shift_register_3_4 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_Y_Mshreg_shift_register_3_4_736,
      Q => BU2_U0_del_Y_shift_register_3_4_727
    );
  BU2_U0_del_Y_Mshreg_shift_register_3_4 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N0,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(11),
      Q => BU2_U0_del_Y_Mshreg_shift_register_3_4_736
    );
  BU2_U0_del_Y_shift_register_3_3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_Y_Mshreg_shift_register_3_3_735,
      Q => BU2_U0_del_Y_shift_register_3_3_728
    );
  BU2_U0_del_Y_Mshreg_shift_register_3_3 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N0,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(10),
      Q => BU2_U0_del_Y_Mshreg_shift_register_3_3_735
    );
  BU2_U0_del_Y_shift_register_3_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_Y_Mshreg_shift_register_3_1_734,
      Q => BU2_U0_del_Y_shift_register_3_1_730
    );
  BU2_U0_del_Y_Mshreg_shift_register_3_1 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N0,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(8),
      Q => BU2_U0_del_Y_Mshreg_shift_register_3_1_734
    );
  BU2_U0_del_Y_shift_register_3_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_Y_Mshreg_shift_register_3_0_733,
      Q => BU2_U0_del_Y_shift_register_3_0_731
    );
  BU2_U0_del_Y_Mshreg_shift_register_3_0 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N0,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(7),
      Q => BU2_U0_del_Y_Mshreg_shift_register_3_0_733
    );
  BU2_U0_del_Y_shift_register_3_2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_Y_Mshreg_shift_register_3_2_732,
      Q => BU2_U0_del_Y_shift_register_3_2_729
    );
  BU2_U0_del_Y_Mshreg_shift_register_3_2 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => BU2_N1,
      A1 => BU2_N0,
      A2 => BU2_N0,
      A3 => BU2_N0,
      CE => ce,
      CLK => clk,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(9),
      Q => BU2_U0_del_Y_Mshreg_shift_register_3_2_732
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_17_1_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(16),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_17_1
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_0_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(0),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(0)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_1_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(1),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(1)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_2_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(2),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(2)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_3_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(3),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(3)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_4_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(4),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(4)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_5_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(5),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(5)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_6_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(6),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(6)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_15_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(15),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(15)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_16_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(16),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(16)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_0_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(0),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(0)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_1_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(1),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(1)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_2_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(2),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(2)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_3_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(3),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(3)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_4_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(4),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(4)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_5_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(5),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(5)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_6_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(6),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(6)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_15_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(15),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(15)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_16_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(16),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(16)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_17_INV_0 : INV
    port map (
      I => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(16),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(17)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_17_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(16),
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_17_rt_527
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_xor_16_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_y_inta_raw(24),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_xor_16_rt_429
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_6_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(6),
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_6_rt_559
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_7_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(7),
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_7_rt_557
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_8_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(8),
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_8_rt_554
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_9_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(9),
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_9_rt_551
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_10_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(10),
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_10_rt_548
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_11_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(11),
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_11_rt_545
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_12_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(12),
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_12_rt_542
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_13_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(13),
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_13_rt_539
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_14_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(14),
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_14_rt_536
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_15_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(15),
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_15_rt_533
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_16_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(16),
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_16_rt_530
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy_15_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_y_inta_raw(24),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy_15_rt_432
    );
  BU2_U0_clip_max_Cb_c_0_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_cb_int(9),
      I1 => BU2_U0_cb_int(8),
      I2 => BU2_U0_cb_int(0),
      O => BU2_U0_clip_max_Cb_c(0)
    );
  BU2_U0_clip_max_Cb_c_1_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_cb_int(9),
      I1 => BU2_U0_cb_int(8),
      I2 => BU2_U0_cb_int(1),
      O => BU2_U0_clip_max_Cb_c(1)
    );
  BU2_U0_clip_max_Cb_c_2_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_cb_int(9),
      I1 => BU2_U0_cb_int(8),
      I2 => BU2_U0_cb_int(2),
      O => BU2_U0_clip_max_Cb_c(2)
    );
  BU2_U0_clip_max_Cb_c_3_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_cb_int(9),
      I1 => BU2_U0_cb_int(8),
      I2 => BU2_U0_cb_int(3),
      O => BU2_U0_clip_max_Cb_c(3)
    );
  BU2_U0_clip_max_Cb_c_4_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_cb_int(9),
      I1 => BU2_U0_cb_int(8),
      I2 => BU2_U0_cb_int(4),
      O => BU2_U0_clip_max_Cb_c(4)
    );
  BU2_U0_clip_max_Cb_c_5_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_cb_int(9),
      I1 => BU2_U0_cb_int(8),
      I2 => BU2_U0_cb_int(5),
      O => BU2_U0_clip_max_Cb_c(5)
    );
  BU2_U0_clip_max_Cb_c_6_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_cb_int(9),
      I1 => BU2_U0_cb_int(8),
      I2 => BU2_U0_cb_int(6),
      O => BU2_U0_clip_max_Cb_c(6)
    );
  BU2_U0_clip_max_Cb_c_7_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_cb_int(9),
      I1 => BU2_U0_cb_int(8),
      I2 => BU2_U0_cb_int(7),
      O => BU2_U0_clip_max_Cb_c(7)
    );
  BU2_U0_clip_max_Cr_c_0_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_c_9_Q,
      I1 => BU2_U0_cr_int(8),
      I2 => BU2_U0_cr_int(0),
      O => BU2_U0_clip_max_Cr_c_0_Q
    );
  BU2_U0_clip_max_Cr_c_1_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_c_9_Q,
      I1 => BU2_U0_cr_int(8),
      I2 => BU2_U0_cr_int(1),
      O => BU2_U0_clip_max_Cr_c_1_Q
    );
  BU2_U0_clip_max_Cr_c_2_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_c_9_Q,
      I1 => BU2_U0_cr_int(8),
      I2 => BU2_U0_cr_int(2),
      O => BU2_U0_clip_max_Cr_c_2_Q
    );
  BU2_U0_clip_max_Cr_c_3_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_c_9_Q,
      I1 => BU2_U0_cr_int(8),
      I2 => BU2_U0_cr_int(3),
      O => BU2_U0_clip_max_Cr_c_3_Q
    );
  BU2_U0_clip_max_Cr_c_4_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_c_9_Q,
      I1 => BU2_U0_cr_int(8),
      I2 => BU2_U0_cr_int(4),
      O => BU2_U0_clip_max_Cr_c_4_Q
    );
  BU2_U0_clip_max_Cr_c_5_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_c_9_Q,
      I1 => BU2_U0_cr_int(8),
      I2 => BU2_U0_cr_int(5),
      O => BU2_U0_clip_max_Cr_c_5_Q
    );
  BU2_U0_clip_max_Cr_c_6_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_c_9_Q,
      I1 => BU2_U0_cr_int(8),
      I2 => BU2_U0_cr_int(6),
      O => BU2_U0_clip_max_Cr_c_6_Q
    );
  BU2_U0_clip_max_Cr_c_7_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_c_9_Q,
      I1 => BU2_U0_cr_int(8),
      I2 => BU2_U0_cr_int(7),
      O => BU2_U0_clip_max_Cr_c_7_Q
    );
  BU2_U0_clip_max_Y_c_0_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_del_Y_shift_register_3_9_671,
      I1 => BU2_U0_del_Y_shift_register_3_8_723,
      I2 => BU2_U0_del_Y_shift_register_3_0_731,
      O => BU2_U0_clip_max_Y_c(0)
    );
  BU2_U0_clip_max_Y_c_1_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_del_Y_shift_register_3_9_671,
      I1 => BU2_U0_del_Y_shift_register_3_8_723,
      I2 => BU2_U0_del_Y_shift_register_3_1_730,
      O => BU2_U0_clip_max_Y_c(1)
    );
  BU2_U0_clip_max_Y_c_2_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_del_Y_shift_register_3_9_671,
      I1 => BU2_U0_del_Y_shift_register_3_8_723,
      I2 => BU2_U0_del_Y_shift_register_3_2_729,
      O => BU2_U0_clip_max_Y_c(2)
    );
  BU2_U0_clip_max_Y_c_3_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_del_Y_shift_register_3_9_671,
      I1 => BU2_U0_del_Y_shift_register_3_8_723,
      I2 => BU2_U0_del_Y_shift_register_3_3_728,
      O => BU2_U0_clip_max_Y_c(3)
    );
  BU2_U0_clip_max_Y_c_4_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_del_Y_shift_register_3_9_671,
      I1 => BU2_U0_del_Y_shift_register_3_8_723,
      I2 => BU2_U0_del_Y_shift_register_3_4_727,
      O => BU2_U0_clip_max_Y_c(4)
    );
  BU2_U0_clip_max_Y_c_5_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_del_Y_shift_register_3_9_671,
      I1 => BU2_U0_del_Y_shift_register_3_8_723,
      I2 => BU2_U0_del_Y_shift_register_3_5_726,
      O => BU2_U0_clip_max_Y_c(5)
    );
  BU2_U0_clip_max_Y_c_6_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_del_Y_shift_register_3_9_671,
      I1 => BU2_U0_del_Y_shift_register_3_8_723,
      I2 => BU2_U0_del_Y_shift_register_3_6_725,
      O => BU2_U0_clip_max_Y_c(6)
    );
  BU2_U0_clip_max_Y_c_7_1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_del_Y_shift_register_3_9_671,
      I1 => BU2_U0_del_Y_shift_register_3_8_723,
      I2 => BU2_U0_del_Y_shift_register_3_7_724,
      O => BU2_U0_clip_max_Y_c(7)
    );
  BU2_U0_clamp_min_Cb_c_0_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cb_reg_shift_register_1_9_689,
      I1 => BU2_U0_clip_max_Cb_reg_shift_register_1_0_705,
      O => BU2_U0_clamp_min_Cb_c(0)
    );
  BU2_U0_clamp_min_Cb_c_1_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cb_reg_shift_register_1_9_689,
      I1 => BU2_U0_clip_max_Cb_reg_shift_register_1_1_703,
      O => BU2_U0_clamp_min_Cb_c(1)
    );
  BU2_U0_clamp_min_Cb_c_2_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cb_reg_shift_register_1_9_689,
      I1 => BU2_U0_clip_max_Cb_reg_shift_register_1_2_701,
      O => BU2_U0_clamp_min_Cb_c(2)
    );
  BU2_U0_clamp_min_Cb_c_3_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cb_reg_shift_register_1_9_689,
      I1 => BU2_U0_clip_max_Cb_reg_shift_register_1_3_699,
      O => BU2_U0_clamp_min_Cb_c(3)
    );
  BU2_U0_clamp_min_Cb_c_4_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cb_reg_shift_register_1_9_689,
      I1 => BU2_U0_clip_max_Cb_reg_shift_register_1_4_697,
      O => BU2_U0_clamp_min_Cb_c(4)
    );
  BU2_U0_clamp_min_Cb_c_5_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cb_reg_shift_register_1_9_689,
      I1 => BU2_U0_clip_max_Cb_reg_shift_register_1_5_695,
      O => BU2_U0_clamp_min_Cb_c(5)
    );
  BU2_U0_clamp_min_Cb_c_6_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cb_reg_shift_register_1_9_689,
      I1 => BU2_U0_clip_max_Cb_reg_shift_register_1_6_693,
      O => BU2_U0_clamp_min_Cb_c(6)
    );
  BU2_U0_clamp_min_Cb_c_7_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cb_reg_shift_register_1_9_689,
      I1 => BU2_U0_clip_max_Cb_reg_shift_register_1_7_691,
      O => BU2_U0_clamp_min_Cb_c(7)
    );
  BU2_U0_clamp_min_Cr_c_0_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_reg_shift_register_1_9_706,
      I1 => BU2_U0_clip_max_Cr_reg_shift_register_1_0_722,
      O => BU2_U0_clamp_min_Cr_c(0)
    );
  BU2_U0_clamp_min_Cr_c_1_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_reg_shift_register_1_9_706,
      I1 => BU2_U0_clip_max_Cr_reg_shift_register_1_1_720,
      O => BU2_U0_clamp_min_Cr_c(1)
    );
  BU2_U0_clamp_min_Cr_c_2_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_reg_shift_register_1_9_706,
      I1 => BU2_U0_clip_max_Cr_reg_shift_register_1_2_718,
      O => BU2_U0_clamp_min_Cr_c(2)
    );
  BU2_U0_clamp_min_Cr_c_3_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_reg_shift_register_1_9_706,
      I1 => BU2_U0_clip_max_Cr_reg_shift_register_1_3_716,
      O => BU2_U0_clamp_min_Cr_c(3)
    );
  BU2_U0_clamp_min_Cr_c_4_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_reg_shift_register_1_9_706,
      I1 => BU2_U0_clip_max_Cr_reg_shift_register_1_4_714,
      O => BU2_U0_clamp_min_Cr_c(4)
    );
  BU2_U0_clamp_min_Cr_c_5_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_reg_shift_register_1_9_706,
      I1 => BU2_U0_clip_max_Cr_reg_shift_register_1_5_712,
      O => BU2_U0_clamp_min_Cr_c(5)
    );
  BU2_U0_clamp_min_Cr_c_6_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_reg_shift_register_1_9_706,
      I1 => BU2_U0_clip_max_Cr_reg_shift_register_1_6_710,
      O => BU2_U0_clamp_min_Cr_c(6)
    );
  BU2_U0_clamp_min_Cr_c_7_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Cr_reg_shift_register_1_9_706,
      I1 => BU2_U0_clip_max_Cr_reg_shift_register_1_7_708,
      O => BU2_U0_clamp_min_Cr_c(7)
    );
  BU2_U0_clamp_min_Y_c_0_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Y_reg_shift_register_1_9_672,
      I1 => BU2_U0_clip_max_Y_reg_shift_register_1_0_688,
      O => BU2_U0_clamp_min_Y_c(0)
    );
  BU2_U0_clamp_min_Y_c_1_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Y_reg_shift_register_1_9_672,
      I1 => BU2_U0_clip_max_Y_reg_shift_register_1_1_686,
      O => BU2_U0_clamp_min_Y_c(1)
    );
  BU2_U0_clamp_min_Y_c_2_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Y_reg_shift_register_1_9_672,
      I1 => BU2_U0_clip_max_Y_reg_shift_register_1_2_684,
      O => BU2_U0_clamp_min_Y_c(2)
    );
  BU2_U0_clamp_min_Y_c_3_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Y_reg_shift_register_1_9_672,
      I1 => BU2_U0_clip_max_Y_reg_shift_register_1_3_682,
      O => BU2_U0_clamp_min_Y_c(3)
    );
  BU2_U0_clamp_min_Y_c_4_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Y_reg_shift_register_1_9_672,
      I1 => BU2_U0_clip_max_Y_reg_shift_register_1_4_680,
      O => BU2_U0_clamp_min_Y_c(4)
    );
  BU2_U0_clamp_min_Y_c_5_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Y_reg_shift_register_1_9_672,
      I1 => BU2_U0_clip_max_Y_reg_shift_register_1_5_678,
      O => BU2_U0_clamp_min_Y_c(5)
    );
  BU2_U0_clamp_min_Y_c_6_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Y_reg_shift_register_1_9_672,
      I1 => BU2_U0_clip_max_Y_reg_shift_register_1_6_676,
      O => BU2_U0_clamp_min_Y_c(6)
    );
  BU2_U0_clamp_min_Y_c_7_1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_clip_max_Y_reg_shift_register_1_9_672,
      I1 => BU2_U0_clip_max_Y_reg_shift_register_1_7_674,
      O => BU2_U0_clamp_min_Y_c(7)
    );
  BU2_U0_clip_max_Cr_reg_shift_register_1_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cr_c_0_Q,
      R => sclr,
      Q => BU2_U0_clip_max_Cr_reg_shift_register_1_0_722
    );
  BU2_U0_clip_max_Cr_reg_shift_register_1_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cr_c_1_Q,
      R => sclr,
      Q => BU2_U0_clip_max_Cr_reg_shift_register_1_1_720
    );
  BU2_U0_clip_max_Cr_reg_shift_register_1_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cr_c_2_Q,
      R => sclr,
      Q => BU2_U0_clip_max_Cr_reg_shift_register_1_2_718
    );
  BU2_U0_clip_max_Cr_reg_shift_register_1_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cr_c_3_Q,
      R => sclr,
      Q => BU2_U0_clip_max_Cr_reg_shift_register_1_3_716
    );
  BU2_U0_clip_max_Cr_reg_shift_register_1_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cr_c_4_Q,
      R => sclr,
      Q => BU2_U0_clip_max_Cr_reg_shift_register_1_4_714
    );
  BU2_U0_clip_max_Cr_reg_shift_register_1_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cr_c_5_Q,
      R => sclr,
      Q => BU2_U0_clip_max_Cr_reg_shift_register_1_5_712
    );
  BU2_U0_clip_max_Cr_reg_shift_register_1_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cr_c_6_Q,
      R => sclr,
      Q => BU2_U0_clip_max_Cr_reg_shift_register_1_6_710
    );
  BU2_U0_clip_max_Cr_reg_shift_register_1_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cr_c_7_Q,
      R => sclr,
      Q => BU2_U0_clip_max_Cr_reg_shift_register_1_7_708
    );
  BU2_U0_clip_max_Cr_reg_shift_register_1_9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cr_c_9_Q,
      R => sclr,
      Q => BU2_U0_clip_max_Cr_reg_shift_register_1_9_706
    );
  BU2_U0_clip_max_Cb_reg_shift_register_1_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cb_c(0),
      R => sclr,
      Q => BU2_U0_clip_max_Cb_reg_shift_register_1_0_705
    );
  BU2_U0_clip_max_Cb_reg_shift_register_1_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cb_c(1),
      R => sclr,
      Q => BU2_U0_clip_max_Cb_reg_shift_register_1_1_703
    );
  BU2_U0_clip_max_Cb_reg_shift_register_1_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cb_c(2),
      R => sclr,
      Q => BU2_U0_clip_max_Cb_reg_shift_register_1_2_701
    );
  BU2_U0_clip_max_Cb_reg_shift_register_1_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cb_c(3),
      R => sclr,
      Q => BU2_U0_clip_max_Cb_reg_shift_register_1_3_699
    );
  BU2_U0_clip_max_Cb_reg_shift_register_1_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cb_c(4),
      R => sclr,
      Q => BU2_U0_clip_max_Cb_reg_shift_register_1_4_697
    );
  BU2_U0_clip_max_Cb_reg_shift_register_1_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cb_c(5),
      R => sclr,
      Q => BU2_U0_clip_max_Cb_reg_shift_register_1_5_695
    );
  BU2_U0_clip_max_Cb_reg_shift_register_1_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cb_c(6),
      R => sclr,
      Q => BU2_U0_clip_max_Cb_reg_shift_register_1_6_693
    );
  BU2_U0_clip_max_Cb_reg_shift_register_1_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Cb_c(7),
      R => sclr,
      Q => BU2_U0_clip_max_Cb_reg_shift_register_1_7_691
    );
  BU2_U0_clip_max_Cb_reg_shift_register_1_9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_cb_int(9),
      R => sclr,
      Q => BU2_U0_clip_max_Cb_reg_shift_register_1_9_689
    );
  BU2_U0_clip_max_Y_reg_shift_register_1_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Y_c(0),
      R => sclr,
      Q => BU2_U0_clip_max_Y_reg_shift_register_1_0_688
    );
  BU2_U0_clip_max_Y_reg_shift_register_1_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Y_c(1),
      R => sclr,
      Q => BU2_U0_clip_max_Y_reg_shift_register_1_1_686
    );
  BU2_U0_clip_max_Y_reg_shift_register_1_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Y_c(2),
      R => sclr,
      Q => BU2_U0_clip_max_Y_reg_shift_register_1_2_684
    );
  BU2_U0_clip_max_Y_reg_shift_register_1_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Y_c(3),
      R => sclr,
      Q => BU2_U0_clip_max_Y_reg_shift_register_1_3_682
    );
  BU2_U0_clip_max_Y_reg_shift_register_1_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Y_c(4),
      R => sclr,
      Q => BU2_U0_clip_max_Y_reg_shift_register_1_4_680
    );
  BU2_U0_clip_max_Y_reg_shift_register_1_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Y_c(5),
      R => sclr,
      Q => BU2_U0_clip_max_Y_reg_shift_register_1_5_678
    );
  BU2_U0_clip_max_Y_reg_shift_register_1_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Y_c(6),
      R => sclr,
      Q => BU2_U0_clip_max_Y_reg_shift_register_1_6_676
    );
  BU2_U0_clip_max_Y_reg_shift_register_1_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clip_max_Y_c(7),
      R => sclr,
      Q => BU2_U0_clip_max_Y_reg_shift_register_1_7_674
    );
  BU2_U0_clip_max_Y_reg_shift_register_1_9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_del_Y_shift_register_3_9_671,
      R => sclr,
      Q => BU2_U0_clip_max_Y_reg_shift_register_1_9_672
    );
  BU2_U0_clamp_min_Cr_reg_shift_register_1_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cr_c(0),
      R => sclr,
      Q => cr(0)
    );
  BU2_U0_clamp_min_Cr_reg_shift_register_1_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cr_c(1),
      R => sclr,
      Q => cr(1)
    );
  BU2_U0_clamp_min_Cr_reg_shift_register_1_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cr_c(2),
      R => sclr,
      Q => cr(2)
    );
  BU2_U0_clamp_min_Cr_reg_shift_register_1_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cr_c(3),
      R => sclr,
      Q => cr(3)
    );
  BU2_U0_clamp_min_Cr_reg_shift_register_1_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cr_c(4),
      R => sclr,
      Q => cr(4)
    );
  BU2_U0_clamp_min_Cr_reg_shift_register_1_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cr_c(5),
      R => sclr,
      Q => cr(5)
    );
  BU2_U0_clamp_min_Cr_reg_shift_register_1_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cr_c(6),
      R => sclr,
      Q => cr(6)
    );
  BU2_U0_clamp_min_Cr_reg_shift_register_1_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cr_c(7),
      R => sclr,
      Q => cr(7)
    );
  BU2_U0_clamp_min_Cb_reg_shift_register_1_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cb_c(0),
      R => sclr,
      Q => cb(0)
    );
  BU2_U0_clamp_min_Cb_reg_shift_register_1_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cb_c(1),
      R => sclr,
      Q => cb(1)
    );
  BU2_U0_clamp_min_Cb_reg_shift_register_1_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cb_c(2),
      R => sclr,
      Q => cb(2)
    );
  BU2_U0_clamp_min_Cb_reg_shift_register_1_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cb_c(3),
      R => sclr,
      Q => cb(3)
    );
  BU2_U0_clamp_min_Cb_reg_shift_register_1_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cb_c(4),
      R => sclr,
      Q => cb(4)
    );
  BU2_U0_clamp_min_Cb_reg_shift_register_1_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cb_c(5),
      R => sclr,
      Q => cb(5)
    );
  BU2_U0_clamp_min_Cb_reg_shift_register_1_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cb_c(6),
      R => sclr,
      Q => cb(6)
    );
  BU2_U0_clamp_min_Cb_reg_shift_register_1_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Cb_c(7),
      R => sclr,
      Q => cb(7)
    );
  BU2_U0_clamp_min_Y_reg_shift_register_1_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Y_c(0),
      R => sclr,
      Q => y(0)
    );
  BU2_U0_clamp_min_Y_reg_shift_register_1_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Y_c(1),
      R => sclr,
      Q => y(1)
    );
  BU2_U0_clamp_min_Y_reg_shift_register_1_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Y_c(2),
      R => sclr,
      Q => y(2)
    );
  BU2_U0_clamp_min_Y_reg_shift_register_1_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Y_c(3),
      R => sclr,
      Q => y(3)
    );
  BU2_U0_clamp_min_Y_reg_shift_register_1_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Y_c(4),
      R => sclr,
      Q => y(4)
    );
  BU2_U0_clamp_min_Y_reg_shift_register_1_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Y_c(5),
      R => sclr,
      Q => y(5)
    );
  BU2_U0_clamp_min_Y_reg_shift_register_1_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Y_c(6),
      R => sclr,
      Q => y(6)
    );
  BU2_U0_clamp_min_Y_reg_shift_register_1_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_clamp_min_Y_c(7),
      R => sclr,
      Q => y(7)
    );
  BU2_U0_sub_BG_use_fabric_adder_reg_shift_register_1_8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BG_use_fabric_adder_c(8),
      R => sclr,
      Q => BU2_U0_sub_BG_use_fabric_adder_out_s(8)
    );
  BU2_U0_sub_BG_use_fabric_adder_reg_shift_register_1_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BG_use_fabric_adder_c(7),
      R => sclr,
      Q => BU2_U0_sub_BG_use_fabric_adder_out_s(7)
    );
  BU2_U0_sub_BG_use_fabric_adder_reg_shift_register_1_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BG_use_fabric_adder_c(6),
      R => sclr,
      Q => BU2_U0_sub_BG_use_fabric_adder_out_s(6)
    );
  BU2_U0_sub_BG_use_fabric_adder_reg_shift_register_1_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BG_use_fabric_adder_c(5),
      R => sclr,
      Q => BU2_U0_sub_BG_use_fabric_adder_out_s(5)
    );
  BU2_U0_sub_BG_use_fabric_adder_reg_shift_register_1_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BG_use_fabric_adder_c(4),
      R => sclr,
      Q => BU2_U0_sub_BG_use_fabric_adder_out_s(4)
    );
  BU2_U0_sub_BG_use_fabric_adder_reg_shift_register_1_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BG_use_fabric_adder_c(3),
      R => sclr,
      Q => BU2_U0_sub_BG_use_fabric_adder_out_s(3)
    );
  BU2_U0_sub_BG_use_fabric_adder_reg_shift_register_1_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BG_use_fabric_adder_c(2),
      R => sclr,
      Q => BU2_U0_sub_BG_use_fabric_adder_out_s(2)
    );
  BU2_U0_sub_BG_use_fabric_adder_reg_shift_register_1_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BG_use_fabric_adder_c(1),
      R => sclr,
      Q => BU2_U0_sub_BG_use_fabric_adder_out_s(1)
    );
  BU2_U0_sub_BG_use_fabric_adder_reg_shift_register_1_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BG_use_fabric_adder_c(0),
      R => sclr,
      Q => BU2_U0_sub_BG_use_fabric_adder_out_s(0)
    );
  BU2_U0_sub_RG_use_fabric_adder_reg_shift_register_1_8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RG_use_fabric_adder_c(8),
      R => sclr,
      Q => BU2_U0_sub_RG_use_fabric_adder_out_s(8)
    );
  BU2_U0_sub_RG_use_fabric_adder_reg_shift_register_1_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RG_use_fabric_adder_c(7),
      R => sclr,
      Q => BU2_U0_sub_RG_use_fabric_adder_out_s(7)
    );
  BU2_U0_sub_RG_use_fabric_adder_reg_shift_register_1_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RG_use_fabric_adder_c(6),
      R => sclr,
      Q => BU2_U0_sub_RG_use_fabric_adder_out_s(6)
    );
  BU2_U0_sub_RG_use_fabric_adder_reg_shift_register_1_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RG_use_fabric_adder_c(5),
      R => sclr,
      Q => BU2_U0_sub_RG_use_fabric_adder_out_s(5)
    );
  BU2_U0_sub_RG_use_fabric_adder_reg_shift_register_1_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RG_use_fabric_adder_c(4),
      R => sclr,
      Q => BU2_U0_sub_RG_use_fabric_adder_out_s(4)
    );
  BU2_U0_sub_RG_use_fabric_adder_reg_shift_register_1_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RG_use_fabric_adder_c(3),
      R => sclr,
      Q => BU2_U0_sub_RG_use_fabric_adder_out_s(3)
    );
  BU2_U0_sub_RG_use_fabric_adder_reg_shift_register_1_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RG_use_fabric_adder_c(2),
      R => sclr,
      Q => BU2_U0_sub_RG_use_fabric_adder_out_s(2)
    );
  BU2_U0_sub_RG_use_fabric_adder_reg_shift_register_1_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RG_use_fabric_adder_c(1),
      R => sclr,
      Q => BU2_U0_sub_RG_use_fabric_adder_out_s(1)
    );
  BU2_U0_sub_RG_use_fabric_adder_reg_shift_register_1_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RG_use_fabric_adder_c(0),
      R => sclr,
      Q => BU2_U0_sub_RG_use_fabric_adder_out_s(0)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_16 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(16),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(16)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_15 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(15),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(15)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_14 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(14),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(14)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_13 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(13),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(13)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_12 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(12),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(12)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_11 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(11),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(11)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_10 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(10),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(10)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(9),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(9)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(8),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(8)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(7),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(7)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_inta_raw(15),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(6)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_inta_raw(14),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(5)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_inta_raw(13),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(4)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_inta_raw(12),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(3)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_inta_raw(11),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(2)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_inta_raw(10),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(1)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_reg_shift_register_1_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_inta_raw(9),
      R => sclr,
      Q => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(0)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_17 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(17),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(17)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_16 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(16),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(16)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_15 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(15),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(15)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_14 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(14),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(14)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_13 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(13),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(13)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_12 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(12),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(12)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_11 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(11),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(11)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_10 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(10),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(10)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(9),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(9)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(8),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(8)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(7),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(7)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(6),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(6)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(5),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(5)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(4),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(4)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(3),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(3)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(2),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(2)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(1),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(1)
    );
  BU2_U0_sub_RY_use_fabric_adder_reg_shift_register_1_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_RY_use_fabric_adder_c(0),
      R => sclr,
      Q => BU2_U0_sub_RY_use_fabric_adder_out_s(0)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_17 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(17),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(17)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_16 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(16),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(16)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_15 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(15),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(15)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_14 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(14),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(14)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_13 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(13),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(13)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_12 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(12),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(12)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_11 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(11),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(11)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_10 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(10),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(10)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(9),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(9)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(8),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(8)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(7),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(7)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(6),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(6)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(5),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(5)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(4),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(4)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(3),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(3)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(2),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(2)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(1),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(1)
    );
  BU2_U0_sub_BY_use_fabric_adder_reg_shift_register_1_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_sub_BY_use_fabric_adder_c(0),
      R => sclr,
      Q => BU2_U0_sub_BY_use_fabric_adder_out_s(0)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(0),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(0)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(1),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(1)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(2),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(2)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(3),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(3)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(4),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(4)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(5),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(5)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(6),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(6)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(7),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(7)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(8),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(8)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(9),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(9)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_10 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(10),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(10)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_11 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(11),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(11)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_12 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(12),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(12)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_13 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(13),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(13)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_14 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(14),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(14)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_15 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(15),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(15)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_16 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(16),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(16)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_reg_shift_register_1_17 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(17),
      R => sclr,
      Q => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_out_s(17)
    );
  BU2_U0_mult_aRG_Mmult_c : DSP48
    generic map(
      CARRYINSELREG => 0,
      LEGACY_MODE => "MULT18X18S",
      AREG => 0,
      BREG => 0,
      CREG => 0,
      MREG => 1,
      PREG => 1,
      CARRYINREG => 0,
      SUBTRACTREG => 0,
      OPMODEREG => 0,
      B_INPUT => "DIRECT"
    )
    port map (
      CARRYIN => BU2_N0,
      CEA => BU2_N0,
      CEB => BU2_N0,
      CEC => BU2_N0,
      CECTRL => BU2_N0,
      CEP => ce,
      CEM => ce,
      CECARRYIN => NLW_BU2_U0_mult_aRG_Mmult_c_CECARRYIN_UNCONNECTED,
      CECINSUB => BU2_N0,
      CLK => clk,
      RSTA => BU2_N0,
      RSTB => BU2_N0,
      RSTC => BU2_N0,
      RSTCTRL => BU2_N0,
      RSTP => sclr,
      RSTM => sclr,
      RSTCARRYIN => BU2_N0,
      SUBTRACT => BU2_N0,
      A(17) => BU2_U0_sub_RG_use_fabric_adder_out_s(8),
      A(16) => BU2_U0_sub_RG_use_fabric_adder_out_s(8),
      A(15) => BU2_U0_sub_RG_use_fabric_adder_out_s(8),
      A(14) => BU2_U0_sub_RG_use_fabric_adder_out_s(8),
      A(13) => BU2_U0_sub_RG_use_fabric_adder_out_s(8),
      A(12) => BU2_U0_sub_RG_use_fabric_adder_out_s(8),
      A(11) => BU2_U0_sub_RG_use_fabric_adder_out_s(8),
      A(10) => BU2_U0_sub_RG_use_fabric_adder_out_s(8),
      A(9) => BU2_U0_sub_RG_use_fabric_adder_out_s(8),
      A(8) => BU2_U0_sub_RG_use_fabric_adder_out_s(8),
      A(7) => BU2_U0_sub_RG_use_fabric_adder_out_s(7),
      A(6) => BU2_U0_sub_RG_use_fabric_adder_out_s(6),
      A(5) => BU2_U0_sub_RG_use_fabric_adder_out_s(5),
      A(4) => BU2_U0_sub_RG_use_fabric_adder_out_s(4),
      A(3) => BU2_U0_sub_RG_use_fabric_adder_out_s(3),
      A(2) => BU2_U0_sub_RG_use_fabric_adder_out_s(2),
      A(1) => BU2_U0_sub_RG_use_fabric_adder_out_s(1),
      A(0) => BU2_U0_sub_RG_use_fabric_adder_out_s(0),
      PCIN(47) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_47_UNCONNECTED,
      PCIN(46) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_46_UNCONNECTED,
      PCIN(45) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_45_UNCONNECTED,
      PCIN(44) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_44_UNCONNECTED,
      PCIN(43) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_43_UNCONNECTED,
      PCIN(42) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_42_UNCONNECTED,
      PCIN(41) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_41_UNCONNECTED,
      PCIN(40) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_40_UNCONNECTED,
      PCIN(39) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_39_UNCONNECTED,
      PCIN(38) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_38_UNCONNECTED,
      PCIN(37) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_37_UNCONNECTED,
      PCIN(36) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_36_UNCONNECTED,
      PCIN(35) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_35_UNCONNECTED,
      PCIN(34) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_34_UNCONNECTED,
      PCIN(33) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_33_UNCONNECTED,
      PCIN(32) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_32_UNCONNECTED,
      PCIN(31) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_31_UNCONNECTED,
      PCIN(30) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_30_UNCONNECTED,
      PCIN(29) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_29_UNCONNECTED,
      PCIN(28) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_28_UNCONNECTED,
      PCIN(27) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_27_UNCONNECTED,
      PCIN(26) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_26_UNCONNECTED,
      PCIN(25) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_25_UNCONNECTED,
      PCIN(24) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_24_UNCONNECTED,
      PCIN(23) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_23_UNCONNECTED,
      PCIN(22) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_22_UNCONNECTED,
      PCIN(21) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_21_UNCONNECTED,
      PCIN(20) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_20_UNCONNECTED,
      PCIN(19) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_19_UNCONNECTED,
      PCIN(18) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_18_UNCONNECTED,
      PCIN(17) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_17_UNCONNECTED,
      PCIN(16) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_16_UNCONNECTED,
      PCIN(15) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_15_UNCONNECTED,
      PCIN(14) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_14_UNCONNECTED,
      PCIN(13) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_13_UNCONNECTED,
      PCIN(12) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_12_UNCONNECTED,
      PCIN(11) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_11_UNCONNECTED,
      PCIN(10) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_10_UNCONNECTED,
      PCIN(9) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_9_UNCONNECTED,
      PCIN(8) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_8_UNCONNECTED,
      PCIN(7) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_7_UNCONNECTED,
      PCIN(6) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_6_UNCONNECTED,
      PCIN(5) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_5_UNCONNECTED,
      PCIN(4) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_4_UNCONNECTED,
      PCIN(3) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_3_UNCONNECTED,
      PCIN(2) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_2_UNCONNECTED,
      PCIN(1) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_1_UNCONNECTED,
      PCIN(0) => NLW_BU2_U0_mult_aRG_Mmult_c_PCIN_0_UNCONNECTED,
      B(17) => BU2_N0,
      B(16) => BU2_N0,
      B(15) => BU2_N0,
      B(14) => BU2_N1,
      B(13) => BU2_N0,
      B(12) => BU2_N0,
      B(11) => BU2_N0,
      B(10) => BU2_N0,
      B(9) => BU2_N0,
      B(8) => BU2_N1,
      B(7) => BU2_N1,
      B(6) => BU2_N0,
      B(5) => BU2_N1,
      B(4) => BU2_N1,
      B(3) => BU2_N1,
      B(2) => BU2_N1,
      B(1) => BU2_N0,
      B(0) => BU2_N1,
      C(47) => NLW_BU2_U0_mult_aRG_Mmult_c_C_47_UNCONNECTED,
      C(46) => NLW_BU2_U0_mult_aRG_Mmult_c_C_46_UNCONNECTED,
      C(45) => NLW_BU2_U0_mult_aRG_Mmult_c_C_45_UNCONNECTED,
      C(44) => NLW_BU2_U0_mult_aRG_Mmult_c_C_44_UNCONNECTED,
      C(43) => NLW_BU2_U0_mult_aRG_Mmult_c_C_43_UNCONNECTED,
      C(42) => NLW_BU2_U0_mult_aRG_Mmult_c_C_42_UNCONNECTED,
      C(41) => NLW_BU2_U0_mult_aRG_Mmult_c_C_41_UNCONNECTED,
      C(40) => NLW_BU2_U0_mult_aRG_Mmult_c_C_40_UNCONNECTED,
      C(39) => NLW_BU2_U0_mult_aRG_Mmult_c_C_39_UNCONNECTED,
      C(38) => NLW_BU2_U0_mult_aRG_Mmult_c_C_38_UNCONNECTED,
      C(37) => NLW_BU2_U0_mult_aRG_Mmult_c_C_37_UNCONNECTED,
      C(36) => NLW_BU2_U0_mult_aRG_Mmult_c_C_36_UNCONNECTED,
      C(35) => NLW_BU2_U0_mult_aRG_Mmult_c_C_35_UNCONNECTED,
      C(34) => NLW_BU2_U0_mult_aRG_Mmult_c_C_34_UNCONNECTED,
      C(33) => NLW_BU2_U0_mult_aRG_Mmult_c_C_33_UNCONNECTED,
      C(32) => NLW_BU2_U0_mult_aRG_Mmult_c_C_32_UNCONNECTED,
      C(31) => NLW_BU2_U0_mult_aRG_Mmult_c_C_31_UNCONNECTED,
      C(30) => NLW_BU2_U0_mult_aRG_Mmult_c_C_30_UNCONNECTED,
      C(29) => NLW_BU2_U0_mult_aRG_Mmult_c_C_29_UNCONNECTED,
      C(28) => NLW_BU2_U0_mult_aRG_Mmult_c_C_28_UNCONNECTED,
      C(27) => NLW_BU2_U0_mult_aRG_Mmult_c_C_27_UNCONNECTED,
      C(26) => NLW_BU2_U0_mult_aRG_Mmult_c_C_26_UNCONNECTED,
      C(25) => NLW_BU2_U0_mult_aRG_Mmult_c_C_25_UNCONNECTED,
      C(24) => NLW_BU2_U0_mult_aRG_Mmult_c_C_24_UNCONNECTED,
      C(23) => NLW_BU2_U0_mult_aRG_Mmult_c_C_23_UNCONNECTED,
      C(22) => NLW_BU2_U0_mult_aRG_Mmult_c_C_22_UNCONNECTED,
      C(21) => NLW_BU2_U0_mult_aRG_Mmult_c_C_21_UNCONNECTED,
      C(20) => NLW_BU2_U0_mult_aRG_Mmult_c_C_20_UNCONNECTED,
      C(19) => NLW_BU2_U0_mult_aRG_Mmult_c_C_19_UNCONNECTED,
      C(18) => NLW_BU2_U0_mult_aRG_Mmult_c_C_18_UNCONNECTED,
      C(17) => NLW_BU2_U0_mult_aRG_Mmult_c_C_17_UNCONNECTED,
      C(16) => NLW_BU2_U0_mult_aRG_Mmult_c_C_16_UNCONNECTED,
      C(15) => NLW_BU2_U0_mult_aRG_Mmult_c_C_15_UNCONNECTED,
      C(14) => NLW_BU2_U0_mult_aRG_Mmult_c_C_14_UNCONNECTED,
      C(13) => NLW_BU2_U0_mult_aRG_Mmult_c_C_13_UNCONNECTED,
      C(12) => NLW_BU2_U0_mult_aRG_Mmult_c_C_12_UNCONNECTED,
      C(11) => NLW_BU2_U0_mult_aRG_Mmult_c_C_11_UNCONNECTED,
      C(10) => NLW_BU2_U0_mult_aRG_Mmult_c_C_10_UNCONNECTED,
      C(9) => NLW_BU2_U0_mult_aRG_Mmult_c_C_9_UNCONNECTED,
      C(8) => NLW_BU2_U0_mult_aRG_Mmult_c_C_8_UNCONNECTED,
      C(7) => NLW_BU2_U0_mult_aRG_Mmult_c_C_7_UNCONNECTED,
      C(6) => NLW_BU2_U0_mult_aRG_Mmult_c_C_6_UNCONNECTED,
      C(5) => NLW_BU2_U0_mult_aRG_Mmult_c_C_5_UNCONNECTED,
      C(4) => NLW_BU2_U0_mult_aRG_Mmult_c_C_4_UNCONNECTED,
      C(3) => NLW_BU2_U0_mult_aRG_Mmult_c_C_3_UNCONNECTED,
      C(2) => NLW_BU2_U0_mult_aRG_Mmult_c_C_2_UNCONNECTED,
      C(1) => NLW_BU2_U0_mult_aRG_Mmult_c_C_1_UNCONNECTED,
      C(0) => NLW_BU2_U0_mult_aRG_Mmult_c_C_0_UNCONNECTED,
      CARRYINSEL(1) => BU2_N0,
      CARRYINSEL(0) => BU2_N0,
      OPMODE(6) => BU2_N0,
      OPMODE(5) => BU2_N0,
      OPMODE(4) => BU2_N0,
      OPMODE(3) => BU2_N0,
      OPMODE(2) => BU2_N1,
      OPMODE(1) => BU2_N0,
      OPMODE(0) => BU2_N1,
      BCIN(17) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_17_UNCONNECTED,
      BCIN(16) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_16_UNCONNECTED,
      BCIN(15) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_15_UNCONNECTED,
      BCIN(14) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_14_UNCONNECTED,
      BCIN(13) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_13_UNCONNECTED,
      BCIN(12) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_12_UNCONNECTED,
      BCIN(11) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_11_UNCONNECTED,
      BCIN(10) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_10_UNCONNECTED,
      BCIN(9) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_9_UNCONNECTED,
      BCIN(8) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_8_UNCONNECTED,
      BCIN(7) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_7_UNCONNECTED,
      BCIN(6) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_6_UNCONNECTED,
      BCIN(5) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_5_UNCONNECTED,
      BCIN(4) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_4_UNCONNECTED,
      BCIN(3) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_3_UNCONNECTED,
      BCIN(2) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_2_UNCONNECTED,
      BCIN(1) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_1_UNCONNECTED,
      BCIN(0) => NLW_BU2_U0_mult_aRG_Mmult_c_BCIN_0_UNCONNECTED,
      PCOUT(47) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_47_UNCONNECTED,
      PCOUT(46) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_46_UNCONNECTED,
      PCOUT(45) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_45_UNCONNECTED,
      PCOUT(44) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_44_UNCONNECTED,
      PCOUT(43) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_43_UNCONNECTED,
      PCOUT(42) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_42_UNCONNECTED,
      PCOUT(41) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_41_UNCONNECTED,
      PCOUT(40) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_40_UNCONNECTED,
      PCOUT(39) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_39_UNCONNECTED,
      PCOUT(38) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_38_UNCONNECTED,
      PCOUT(37) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_37_UNCONNECTED,
      PCOUT(36) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_36_UNCONNECTED,
      PCOUT(35) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_35_UNCONNECTED,
      PCOUT(34) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_34_UNCONNECTED,
      PCOUT(33) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_33_UNCONNECTED,
      PCOUT(32) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_32_UNCONNECTED,
      PCOUT(31) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_31_UNCONNECTED,
      PCOUT(30) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_30_UNCONNECTED,
      PCOUT(29) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_29_UNCONNECTED,
      PCOUT(28) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_28_UNCONNECTED,
      PCOUT(27) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_27_UNCONNECTED,
      PCOUT(26) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_26_UNCONNECTED,
      PCOUT(25) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_25_UNCONNECTED,
      PCOUT(24) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_24_UNCONNECTED,
      PCOUT(23) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_23_UNCONNECTED,
      PCOUT(22) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_22_UNCONNECTED,
      PCOUT(21) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_21_UNCONNECTED,
      PCOUT(20) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_20_UNCONNECTED,
      PCOUT(19) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_19_UNCONNECTED,
      PCOUT(18) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_18_UNCONNECTED,
      PCOUT(17) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_17_UNCONNECTED,
      PCOUT(16) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_16_UNCONNECTED,
      PCOUT(15) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_15_UNCONNECTED,
      PCOUT(14) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_14_UNCONNECTED,
      PCOUT(13) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_13_UNCONNECTED,
      PCOUT(12) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_12_UNCONNECTED,
      PCOUT(11) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_11_UNCONNECTED,
      PCOUT(10) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_10_UNCONNECTED,
      PCOUT(9) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_9_UNCONNECTED,
      PCOUT(8) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_8_UNCONNECTED,
      PCOUT(7) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_7_UNCONNECTED,
      PCOUT(6) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_6_UNCONNECTED,
      PCOUT(5) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_5_UNCONNECTED,
      PCOUT(4) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_4_UNCONNECTED,
      PCOUT(3) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_3_UNCONNECTED,
      PCOUT(2) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_2_UNCONNECTED,
      PCOUT(1) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_1_UNCONNECTED,
      PCOUT(0) => NLW_BU2_U0_mult_aRG_Mmult_c_PCOUT_0_UNCONNECTED,
      P(47) => NLW_BU2_U0_mult_aRG_Mmult_c_P_47_UNCONNECTED,
      P(46) => NLW_BU2_U0_mult_aRG_Mmult_c_P_46_UNCONNECTED,
      P(45) => NLW_BU2_U0_mult_aRG_Mmult_c_P_45_UNCONNECTED,
      P(44) => NLW_BU2_U0_mult_aRG_Mmult_c_P_44_UNCONNECTED,
      P(43) => NLW_BU2_U0_mult_aRG_Mmult_c_P_43_UNCONNECTED,
      P(42) => NLW_BU2_U0_mult_aRG_Mmult_c_P_42_UNCONNECTED,
      P(41) => NLW_BU2_U0_mult_aRG_Mmult_c_P_41_UNCONNECTED,
      P(40) => NLW_BU2_U0_mult_aRG_Mmult_c_P_40_UNCONNECTED,
      P(39) => NLW_BU2_U0_mult_aRG_Mmult_c_P_39_UNCONNECTED,
      P(38) => NLW_BU2_U0_mult_aRG_Mmult_c_P_38_UNCONNECTED,
      P(37) => NLW_BU2_U0_mult_aRG_Mmult_c_P_37_UNCONNECTED,
      P(36) => NLW_BU2_U0_mult_aRG_Mmult_c_P_36_UNCONNECTED,
      P(35) => NLW_BU2_U0_mult_aRG_Mmult_c_P_35_UNCONNECTED,
      P(34) => NLW_BU2_U0_mult_aRG_Mmult_c_P_34_UNCONNECTED,
      P(33) => NLW_BU2_U0_mult_aRG_Mmult_c_P_33_UNCONNECTED,
      P(32) => NLW_BU2_U0_mult_aRG_Mmult_c_P_32_UNCONNECTED,
      P(31) => NLW_BU2_U0_mult_aRG_Mmult_c_P_31_UNCONNECTED,
      P(30) => NLW_BU2_U0_mult_aRG_Mmult_c_P_30_UNCONNECTED,
      P(29) => NLW_BU2_U0_mult_aRG_Mmult_c_P_29_UNCONNECTED,
      P(28) => NLW_BU2_U0_mult_aRG_Mmult_c_P_28_UNCONNECTED,
      P(27) => NLW_BU2_U0_mult_aRG_Mmult_c_P_27_UNCONNECTED,
      P(26) => NLW_BU2_U0_mult_aRG_Mmult_c_P_26_UNCONNECTED,
      P(25) => NLW_BU2_U0_mult_aRG_Mmult_c_P_25_UNCONNECTED,
      P(24) => BU2_U0_rgm(24),
      P(23) => BU2_U0_rgm(23),
      P(22) => BU2_U0_rgm(22),
      P(21) => BU2_U0_rgm(21),
      P(20) => BU2_U0_rgm(20),
      P(19) => BU2_U0_rgm(19),
      P(18) => BU2_U0_rgm(18),
      P(17) => BU2_U0_rgm(17),
      P(16) => BU2_U0_rgm(16),
      P(15) => BU2_U0_rgm(15),
      P(14) => BU2_U0_rgm(14),
      P(13) => BU2_U0_rgm(13),
      P(12) => BU2_U0_rgm(12),
      P(11) => BU2_U0_rgm(11),
      P(10) => BU2_U0_rgm(10),
      P(9) => BU2_U0_rgm(9),
      P(8) => BU2_U0_rgm(8),
      P(7) => BU2_U0_rgm(7),
      P(6) => BU2_U0_rgm(6),
      P(5) => BU2_U0_rgm(5),
      P(4) => BU2_U0_rgm(4),
      P(3) => BU2_U0_rgm(3),
      P(2) => BU2_U0_rgm(2),
      P(1) => BU2_U0_rgm(1),
      P(0) => BU2_U0_rgm(0),
      BCOUT(17) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_17_UNCONNECTED,
      BCOUT(16) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_16_UNCONNECTED,
      BCOUT(15) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_15_UNCONNECTED,
      BCOUT(14) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_14_UNCONNECTED,
      BCOUT(13) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_13_UNCONNECTED,
      BCOUT(12) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_12_UNCONNECTED,
      BCOUT(11) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_11_UNCONNECTED,
      BCOUT(10) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_10_UNCONNECTED,
      BCOUT(9) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_9_UNCONNECTED,
      BCOUT(8) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_8_UNCONNECTED,
      BCOUT(7) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_7_UNCONNECTED,
      BCOUT(6) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_6_UNCONNECTED,
      BCOUT(5) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_5_UNCONNECTED,
      BCOUT(4) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_4_UNCONNECTED,
      BCOUT(3) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_3_UNCONNECTED,
      BCOUT(2) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_2_UNCONNECTED,
      BCOUT(1) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_1_UNCONNECTED,
      BCOUT(0) => NLW_BU2_U0_mult_aRG_Mmult_c_BCOUT_0_UNCONNECTED
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut_0_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => b(0),
      I1 => g(0),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(0)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy_0_Q : MUXCY
    port map (
      CI => BU2_N1,
      DI => b(0),
      S => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(0),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(0)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_xor_0_Q : XORCY
    port map (
      CI => BU2_N1,
      LI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(0),
      O => BU2_U0_sub_BG_use_fabric_adder_c(0)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut_1_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => b(1),
      I1 => g(1),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(1)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy_1_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(0),
      DI => b(1),
      S => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(1),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(1)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_xor_1_Q : XORCY
    port map (
      CI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(0),
      LI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(1),
      O => BU2_U0_sub_BG_use_fabric_adder_c(1)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut_2_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => b(2),
      I1 => g(2),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(2)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy_2_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(1),
      DI => b(2),
      S => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(2),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(2)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_xor_2_Q : XORCY
    port map (
      CI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(1),
      LI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(2),
      O => BU2_U0_sub_BG_use_fabric_adder_c(2)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut_3_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => b(3),
      I1 => g(3),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(3)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy_3_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(2),
      DI => b(3),
      S => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(3),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(3)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_xor_3_Q : XORCY
    port map (
      CI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(2),
      LI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(3),
      O => BU2_U0_sub_BG_use_fabric_adder_c(3)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut_4_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => b(4),
      I1 => g(4),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(4)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy_4_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(3),
      DI => b(4),
      S => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(4),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(4)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_xor_4_Q : XORCY
    port map (
      CI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(3),
      LI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(4),
      O => BU2_U0_sub_BG_use_fabric_adder_c(4)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut_5_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => b(5),
      I1 => g(5),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(5)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy_5_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(4),
      DI => b(5),
      S => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(5),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(5)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_xor_5_Q : XORCY
    port map (
      CI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(4),
      LI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(5),
      O => BU2_U0_sub_BG_use_fabric_adder_c(5)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut_6_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => b(6),
      I1 => g(6),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(6)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy_6_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(5),
      DI => b(6),
      S => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(6),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(6)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_xor_6_Q : XORCY
    port map (
      CI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(5),
      LI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(6),
      O => BU2_U0_sub_BG_use_fabric_adder_c(6)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut_7_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => b(7),
      I1 => g(7),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(7)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy_7_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(6),
      DI => b(7),
      S => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(7),
      O => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(7)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_xor_7_Q : XORCY
    port map (
      CI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(6),
      LI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_lut(7),
      O => BU2_U0_sub_BG_use_fabric_adder_c(7)
    );
  BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_xor_8_Q : XORCY
    port map (
      CI => BU2_U0_sub_BG_use_fabric_adder_Msub_c_Madd_cy(7),
      LI => BU2_N1,
      O => BU2_U0_sub_BG_use_fabric_adder_c(8)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut_0_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => r(0),
      I1 => g(0),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(0)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy_0_Q : MUXCY
    port map (
      CI => BU2_N1,
      DI => r(0),
      S => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(0),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(0)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_xor_0_Q : XORCY
    port map (
      CI => BU2_N1,
      LI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(0),
      O => BU2_U0_sub_RG_use_fabric_adder_c(0)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut_1_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => r(1),
      I1 => g(1),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(1)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy_1_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(0),
      DI => r(1),
      S => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(1),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(1)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_xor_1_Q : XORCY
    port map (
      CI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(0),
      LI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(1),
      O => BU2_U0_sub_RG_use_fabric_adder_c(1)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut_2_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => r(2),
      I1 => g(2),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(2)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy_2_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(1),
      DI => r(2),
      S => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(2),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(2)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_xor_2_Q : XORCY
    port map (
      CI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(1),
      LI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(2),
      O => BU2_U0_sub_RG_use_fabric_adder_c(2)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut_3_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => r(3),
      I1 => g(3),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(3)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy_3_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(2),
      DI => r(3),
      S => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(3),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(3)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_xor_3_Q : XORCY
    port map (
      CI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(2),
      LI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(3),
      O => BU2_U0_sub_RG_use_fabric_adder_c(3)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut_4_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => r(4),
      I1 => g(4),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(4)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy_4_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(3),
      DI => r(4),
      S => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(4),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(4)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_xor_4_Q : XORCY
    port map (
      CI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(3),
      LI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(4),
      O => BU2_U0_sub_RG_use_fabric_adder_c(4)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut_5_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => r(5),
      I1 => g(5),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(5)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy_5_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(4),
      DI => r(5),
      S => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(5),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(5)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_xor_5_Q : XORCY
    port map (
      CI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(4),
      LI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(5),
      O => BU2_U0_sub_RG_use_fabric_adder_c(5)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut_6_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => r(6),
      I1 => g(6),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(6)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy_6_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(5),
      DI => r(6),
      S => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(6),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(6)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_xor_6_Q : XORCY
    port map (
      CI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(5),
      LI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(6),
      O => BU2_U0_sub_RG_use_fabric_adder_c(6)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut_7_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => r(7),
      I1 => g(7),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(7)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy_7_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(6),
      DI => r(7),
      S => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(7),
      O => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(7)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_xor_7_Q : XORCY
    port map (
      CI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(6),
      LI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_lut(7),
      O => BU2_U0_sub_RG_use_fabric_adder_c(7)
    );
  BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_xor_8_Q : XORCY
    port map (
      CI => BU2_U0_sub_RG_use_fabric_adder_Msub_c_Madd_cy(7),
      LI => BU2_N1,
      O => BU2_U0_sub_RG_use_fabric_adder_c(8)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_6_Q : MUXCY
    port map (
      CI => BU2_N1,
      DI => BU2_N0,
      S => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_6_rt_559,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(6)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_6_Q : XORCY
    port map (
      CI => BU2_N1,
      LI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_6_rt_559,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(6)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_7_Q : MUXCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(6),
      DI => BU2_N0,
      S => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_7_rt_557,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(7)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_7_Q : XORCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(6),
      LI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_7_rt_557,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(7)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_8_Q : MUXCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(7),
      DI => BU2_N0,
      S => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_8_rt_554,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(8)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_8_Q : XORCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(7),
      LI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_8_rt_554,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(8)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_9_Q : MUXCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(8),
      DI => BU2_N0,
      S => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_9_rt_551,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(9)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_9_Q : XORCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(8),
      LI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_9_rt_551,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(9)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_10_Q : MUXCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(9),
      DI => BU2_N0,
      S => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_10_rt_548,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(10)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_10_Q : XORCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(9),
      LI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_10_rt_548,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(10)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_11_Q : MUXCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(10),
      DI => BU2_N0,
      S => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_11_rt_545,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(11)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_11_Q : XORCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(10),
      LI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_11_rt_545,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(11)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_12_Q : MUXCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(11),
      DI => BU2_N0,
      S => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_12_rt_542,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(12)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_12_Q : XORCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(11),
      LI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_12_rt_542,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(12)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_13_Q : MUXCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(12),
      DI => BU2_N0,
      S => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_13_rt_539,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(13)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_13_Q : XORCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(12),
      LI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_13_rt_539,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(13)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_14_Q : MUXCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(13),
      DI => BU2_N0,
      S => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_14_rt_536,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(14)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_14_Q : XORCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(13),
      LI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_14_rt_536,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(14)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_15_Q : MUXCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(14),
      DI => BU2_N0,
      S => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_15_rt_533,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(15)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_15_Q : XORCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(14),
      LI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_15_rt_533,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(15)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_16_Q : MUXCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(15),
      DI => BU2_N0,
      S => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_16_rt_530,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(16)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_16_Q : XORCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(15),
      LI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy_16_rt_530,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(16)
    );
  BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_17_Q : XORCY
    port map (
      CI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_cy(16),
      LI => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_Madd_c_xor_17_rt_527,
      O => BU2_U0_y_needs_round_round_Y_adder_use_fabric_adder_c(17)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_0_Q : MUXCY
    port map (
      CI => BU2_N1,
      DI => BU2_N0,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(0),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(0)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_0_Q : XORCY
    port map (
      CI => BU2_N1,
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(0),
      O => BU2_U0_sub_RY_use_fabric_adder_c(0)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_1_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(0),
      DI => BU2_N0,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(1),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(1)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_1_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(0),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(1),
      O => BU2_U0_sub_RY_use_fabric_adder_c(1)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_2_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(1),
      DI => BU2_N0,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(2),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(2)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_2_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(1),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(2),
      O => BU2_U0_sub_RY_use_fabric_adder_c(2)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_3_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(2),
      DI => BU2_N0,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(3),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(3)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_3_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(2),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(3),
      O => BU2_U0_sub_RY_use_fabric_adder_c(3)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_4_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(3),
      DI => BU2_N0,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(4),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(4)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_4_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(3),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(4),
      O => BU2_U0_sub_RY_use_fabric_adder_c(4)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_5_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(4),
      DI => BU2_N0,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(5),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(5)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_5_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(4),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(5),
      O => BU2_U0_sub_RY_use_fabric_adder_c(5)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_6_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(5),
      DI => BU2_N0,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(6),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(6)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_6_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(5),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(6),
      O => BU2_U0_sub_RY_use_fabric_adder_c(6)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_7_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_R_shift_register_5_0_505,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(7),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(7)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_7_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(6),
      DI => BU2_U0_del_R_shift_register_5_0_505,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(7),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(7)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_7_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(6),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(7),
      O => BU2_U0_sub_RY_use_fabric_adder_c(7)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_8_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_R_shift_register_5_1_501,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(8),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(8)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_8_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(7),
      DI => BU2_U0_del_R_shift_register_5_1_501,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(8),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(8)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_8_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(7),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(8),
      O => BU2_U0_sub_RY_use_fabric_adder_c(8)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_9_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_R_shift_register_5_2_497,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(9),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(9)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_9_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(8),
      DI => BU2_U0_del_R_shift_register_5_2_497,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(9),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(9)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_9_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(8),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(9),
      O => BU2_U0_sub_RY_use_fabric_adder_c(9)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_10_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_R_shift_register_5_3_493,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(10),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(10)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_10_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(9),
      DI => BU2_U0_del_R_shift_register_5_3_493,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(10),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(10)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_10_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(9),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(10),
      O => BU2_U0_sub_RY_use_fabric_adder_c(10)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_11_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_R_shift_register_5_4_489,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(11),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(11)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_11_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(10),
      DI => BU2_U0_del_R_shift_register_5_4_489,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(11),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(11)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_11_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(10),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(11),
      O => BU2_U0_sub_RY_use_fabric_adder_c(11)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_12_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_R_shift_register_5_5_485,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(12),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(12)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_12_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(11),
      DI => BU2_U0_del_R_shift_register_5_5_485,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(12),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(12)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_12_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(11),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(12),
      O => BU2_U0_sub_RY_use_fabric_adder_c(12)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_13_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_R_shift_register_5_6_481,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(13),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(13)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_13_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(12),
      DI => BU2_U0_del_R_shift_register_5_6_481,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(13),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(13)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_13_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(12),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(13),
      O => BU2_U0_sub_RY_use_fabric_adder_c(13)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut_14_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_R_shift_register_5_7_477,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(14),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(14)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_14_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(13),
      DI => BU2_U0_del_R_shift_register_5_7_477,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(14),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(14)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_14_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(13),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(14),
      O => BU2_U0_sub_RY_use_fabric_adder_c(14)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_15_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(14),
      DI => BU2_N0,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(15),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(15)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_15_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(14),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(15),
      O => BU2_U0_sub_RY_use_fabric_adder_c(15)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy_16_Q : MUXCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(15),
      DI => BU2_N0,
      S => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(16),
      O => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(16)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_16_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(15),
      LI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_lut(16),
      O => BU2_U0_sub_RY_use_fabric_adder_c(16)
    );
  BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_xor_17_Q : XORCY
    port map (
      CI => BU2_U0_sub_RY_use_fabric_adder_Msub_c_Madd_cy(16),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(17),
      O => BU2_U0_sub_RY_use_fabric_adder_c(17)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut_7_Q : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_y_inta_raw(16),
      I1 => BU2_U0_del_G_shift_register_4_0_464,
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(7)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy_7_Q : MUXCY
    port map (
      CI => BU2_N0,
      DI => BU2_U0_y_inta_raw(16),
      S => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(7),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(7)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_xor_7_Q : XORCY
    port map (
      CI => BU2_N0,
      LI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(7),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(7)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut_8_Q : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_y_inta_raw(17),
      I1 => BU2_U0_del_G_shift_register_4_1_461,
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(8)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy_8_Q : MUXCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(7),
      DI => BU2_U0_y_inta_raw(17),
      S => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(8),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(8)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_xor_8_Q : XORCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(7),
      LI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(8),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(8)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut_9_Q : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_y_inta_raw(18),
      I1 => BU2_U0_del_G_shift_register_4_2_457,
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(9)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy_9_Q : MUXCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(8),
      DI => BU2_U0_y_inta_raw(18),
      S => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(9),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(9)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_xor_9_Q : XORCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(8),
      LI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(9),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(9)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut_10_Q : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_y_inta_raw(19),
      I1 => BU2_U0_del_G_shift_register_4_3_453,
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(10)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy_10_Q : MUXCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(9),
      DI => BU2_U0_y_inta_raw(19),
      S => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(10),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(10)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_xor_10_Q : XORCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(9),
      LI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(10),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(10)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut_11_Q : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_y_inta_raw(20),
      I1 => BU2_U0_del_G_shift_register_4_4_449,
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(11)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy_11_Q : MUXCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(10),
      DI => BU2_U0_y_inta_raw(20),
      S => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(11),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(11)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_xor_11_Q : XORCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(10),
      LI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(11),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(11)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut_12_Q : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_y_inta_raw(21),
      I1 => BU2_U0_del_G_shift_register_4_5_445,
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(12)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy_12_Q : MUXCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(11),
      DI => BU2_U0_y_inta_raw(21),
      S => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(12),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(12)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_xor_12_Q : XORCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(11),
      LI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(12),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(12)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut_13_Q : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_y_inta_raw(22),
      I1 => BU2_U0_del_G_shift_register_4_6_441,
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(13)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy_13_Q : MUXCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(12),
      DI => BU2_U0_y_inta_raw(22),
      S => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(13),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(13)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_xor_13_Q : XORCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(12),
      LI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(13),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(13)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut_14_Q : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_y_inta_raw(23),
      I1 => BU2_U0_del_G_shift_register_4_7_437,
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(14)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy_14_Q : MUXCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(13),
      DI => BU2_U0_y_inta_raw(23),
      S => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(14),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(14)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_xor_14_Q : XORCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(13),
      LI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_lut(14),
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(14)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy_15_Q : MUXCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(14),
      DI => BU2_N0,
      S => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy_15_rt_432,
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(15)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_xor_15_Q : XORCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(14),
      LI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy_15_rt_432,
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(15)
    );
  BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_xor_16_Q : XORCY
    port map (
      CI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_cy(15),
      LI => BU2_U0_add_aRG_bBG_G_use_fabric_adder_Madd_c_xor_16_rt_429,
      O => BU2_U0_add_aRG_bBG_G_use_fabric_adder_c(16)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_0_Q : MUXCY
    port map (
      CI => BU2_N1,
      DI => BU2_N0,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(0),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(0)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_0_Q : XORCY
    port map (
      CI => BU2_N1,
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(0),
      O => BU2_U0_sub_BY_use_fabric_adder_c(0)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_1_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(0),
      DI => BU2_N0,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(1),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(1)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_1_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(0),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(1),
      O => BU2_U0_sub_BY_use_fabric_adder_c(1)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_2_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(1),
      DI => BU2_N0,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(2),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(2)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_2_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(1),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(2),
      O => BU2_U0_sub_BY_use_fabric_adder_c(2)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_3_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(2),
      DI => BU2_N0,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(3),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(3)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_3_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(2),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(3),
      O => BU2_U0_sub_BY_use_fabric_adder_c(3)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_4_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(3),
      DI => BU2_N0,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(4),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(4)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_4_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(3),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(4),
      O => BU2_U0_sub_BY_use_fabric_adder_c(4)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_5_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(4),
      DI => BU2_N0,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(5),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(5)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_5_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(4),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(5),
      O => BU2_U0_sub_BY_use_fabric_adder_c(5)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_6_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(5),
      DI => BU2_N0,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(6),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(6)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_6_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(5),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(6),
      O => BU2_U0_sub_BY_use_fabric_adder_c(6)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_7_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_B_shift_register_5_0_406,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(7),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(7)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_7_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(6),
      DI => BU2_U0_del_B_shift_register_5_0_406,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(7),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(7)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_7_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(6),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(7),
      O => BU2_U0_sub_BY_use_fabric_adder_c(7)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_8_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_B_shift_register_5_1_401,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(8),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(8)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_8_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(7),
      DI => BU2_U0_del_B_shift_register_5_1_401,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(8),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(8)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_8_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(7),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(8),
      O => BU2_U0_sub_BY_use_fabric_adder_c(8)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_9_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_B_shift_register_5_2_396,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(9),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(9)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_9_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(8),
      DI => BU2_U0_del_B_shift_register_5_2_396,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(9),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(9)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_9_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(8),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(9),
      O => BU2_U0_sub_BY_use_fabric_adder_c(9)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_10_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_B_shift_register_5_3_391,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(10),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(10)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_10_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(9),
      DI => BU2_U0_del_B_shift_register_5_3_391,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(10),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(10)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_10_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(9),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(10),
      O => BU2_U0_sub_BY_use_fabric_adder_c(10)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_11_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_B_shift_register_5_4_386,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(11),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(11)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_11_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(10),
      DI => BU2_U0_del_B_shift_register_5_4_386,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(11),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(11)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_11_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(10),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(11),
      O => BU2_U0_sub_BY_use_fabric_adder_c(11)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_12_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_B_shift_register_5_5_381,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(12),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(12)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_12_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(11),
      DI => BU2_U0_del_B_shift_register_5_5_381,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(12),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(12)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_12_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(11),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(12),
      O => BU2_U0_sub_BY_use_fabric_adder_c(12)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_13_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_B_shift_register_5_6_376,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(13),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(13)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_13_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(12),
      DI => BU2_U0_del_B_shift_register_5_6_376,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(13),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(13)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_13_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(12),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(13),
      O => BU2_U0_sub_BY_use_fabric_adder_c(13)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_14_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_del_B_shift_register_5_7_371,
      I1 => BU2_U0_add_aRG_bBG_G_use_fabric_adder_out_s(14),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(14)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_14_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(13),
      DI => BU2_U0_del_B_shift_register_5_7_371,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(14),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(14)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_14_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(13),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(14),
      O => BU2_U0_sub_BY_use_fabric_adder_c(14)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_15_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(14),
      DI => BU2_N0,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(15),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(15)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_15_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(14),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(15),
      O => BU2_U0_sub_BY_use_fabric_adder_c(15)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy_16_Q : MUXCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(15),
      DI => BU2_N0,
      S => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(16),
      O => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(16)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_16_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(15),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut(16),
      O => BU2_U0_sub_BY_use_fabric_adder_c(16)
    );
  BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_xor_17_Q : XORCY
    port map (
      CI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_cy(16),
      LI => BU2_U0_sub_BY_use_fabric_adder_Msub_c_Madd_lut_17_1,
      O => BU2_U0_sub_BY_use_fabric_adder_c(17)
    );
  BU2_U0_v4_mac1_mult_aCr : mac_1
    port map (
      clk => clk,
      ce => ce,
      sclr => sclr,
      p(25) => NLW_BU2_U0_v4_mac1_mult_aCr_p_25_UNCONNECTED,
      p(24) => BU2_U0_y_inta_raw(24),
      p(23) => BU2_U0_y_inta_raw(23),
      p(22) => BU2_U0_y_inta_raw(22),
      p(21) => BU2_U0_y_inta_raw(21),
      p(20) => BU2_U0_y_inta_raw(20),
      p(19) => BU2_U0_y_inta_raw(19),
      p(18) => BU2_U0_y_inta_raw(18),
      p(17) => BU2_U0_y_inta_raw(17),
      p(16) => BU2_U0_y_inta_raw(16),
      p(15) => BU2_U0_y_inta_raw(15),
      p(14) => BU2_U0_y_inta_raw(14),
      p(13) => BU2_U0_y_inta_raw(13),
      p(12) => BU2_U0_y_inta_raw(12),
      p(11) => BU2_U0_y_inta_raw(11),
      p(10) => BU2_U0_y_inta_raw(10),
      p(9) => BU2_U0_y_inta_raw(9),
      p(8) => NLW_BU2_U0_v4_mac1_mult_aCr_p_8_UNCONNECTED,
      p(7) => NLW_BU2_U0_v4_mac1_mult_aCr_p_7_UNCONNECTED,
      p(6) => NLW_BU2_U0_v4_mac1_mult_aCr_p_6_UNCONNECTED,
      p(5) => NLW_BU2_U0_v4_mac1_mult_aCr_p_5_UNCONNECTED,
      p(4) => NLW_BU2_U0_v4_mac1_mult_aCr_p_4_UNCONNECTED,
      p(3) => NLW_BU2_U0_v4_mac1_mult_aCr_p_3_UNCONNECTED,
      p(2) => NLW_BU2_U0_v4_mac1_mult_aCr_p_2_UNCONNECTED,
      p(1) => NLW_BU2_U0_v4_mac1_mult_aCr_p_1_UNCONNECTED,
      p(0) => NLW_BU2_U0_v4_mac1_mult_aCr_p_0_UNCONNECTED,
      a(8) => BU2_U0_sub_BG_use_fabric_adder_out_s(8),
      a(7) => BU2_U0_sub_BG_use_fabric_adder_out_s(7),
      a(6) => BU2_U0_sub_BG_use_fabric_adder_out_s(6),
      a(5) => BU2_U0_sub_BG_use_fabric_adder_out_s(5),
      a(4) => BU2_U0_sub_BG_use_fabric_adder_out_s(4),
      a(3) => BU2_U0_sub_BG_use_fabric_adder_out_s(3),
      a(2) => BU2_U0_sub_BG_use_fabric_adder_out_s(2),
      a(1) => BU2_U0_sub_BG_use_fabric_adder_out_s(1),
      a(0) => BU2_U0_sub_BG_use_fabric_adder_out_s(0),
      b(16) => BU2_N0,
      b(15) => BU2_N0,
      b(14) => BU2_N0,
      b(13) => BU2_N0,
      b(12) => BU2_N1,
      b(11) => BU2_N1,
      b(10) => BU2_N0,
      b(9) => BU2_N0,
      b(8) => BU2_N1,
      b(7) => BU2_N0,
      b(6) => BU2_N0,
      b(5) => BU2_N0,
      b(4) => BU2_N0,
      b(3) => BU2_N1,
      b(2) => BU2_N1,
      b(1) => BU2_N1,
      b(0) => BU2_N1,
      c(25) => BU2_U0_rgm(24),
      c(24) => BU2_U0_rgm(24),
      c(23) => BU2_U0_rgm(23),
      c(22) => BU2_U0_rgm(22),
      c(21) => BU2_U0_rgm(21),
      c(20) => BU2_U0_rgm(20),
      c(19) => BU2_U0_rgm(19),
      c(18) => BU2_U0_rgm(18),
      c(17) => BU2_U0_rgm(17),
      c(16) => BU2_U0_rgm(16),
      c(15) => BU2_U0_rgm(15),
      c(14) => BU2_U0_rgm(14),
      c(13) => BU2_U0_rgm(13),
      c(12) => BU2_U0_rgm(12),
      c(11) => BU2_U0_rgm(11),
      c(10) => BU2_U0_rgm(10),
      c(9) => BU2_U0_rgm(9),
      c(8) => BU2_U0_rgm(8),
      c(7) => BU2_U0_rgm(7),
      c(6) => BU2_U0_rgm(6),
      c(5) => BU2_U0_rgm(5),
      c(4) => BU2_U0_rgm(4),
      c(3) => BU2_U0_rgm(3),
      c(2) => BU2_U0_rgm(2),
      c(1) => BU2_U0_rgm(1),
      c(0) => BU2_U0_rgm(0)
    );
  BU2_U0_v4_mac23_mac_cRY : mac_2
    port map (
      clk => clk,
      ce => ce,
      sclr => sclr,
      p(11) => NLW_BU2_U0_v4_mac23_mac_cRY_p_11_UNCONNECTED,
      p(10) => NLW_BU2_U0_v4_mac23_mac_cRY_p_10_UNCONNECTED,
      p(9) => BU2_U0_clip_max_Cr_c_9_Q,
      p(8) => BU2_U0_cr_int(8),
      p(7) => BU2_U0_cr_int(7),
      p(6) => BU2_U0_cr_int(6),
      p(5) => BU2_U0_cr_int(5),
      p(4) => BU2_U0_cr_int(4),
      p(3) => BU2_U0_cr_int(3),
      p(2) => BU2_U0_cr_int(2),
      p(1) => BU2_U0_cr_int(1),
      p(0) => BU2_U0_cr_int(0),
      a(17) => BU2_U0_sub_RY_use_fabric_adder_out_s(17),
      a(16) => BU2_U0_sub_RY_use_fabric_adder_out_s(16),
      a(15) => BU2_U0_sub_RY_use_fabric_adder_out_s(15),
      a(14) => BU2_U0_sub_RY_use_fabric_adder_out_s(14),
      a(13) => BU2_U0_sub_RY_use_fabric_adder_out_s(13),
      a(12) => BU2_U0_sub_RY_use_fabric_adder_out_s(12),
      a(11) => BU2_U0_sub_RY_use_fabric_adder_out_s(11),
      a(10) => BU2_U0_sub_RY_use_fabric_adder_out_s(10),
      a(9) => BU2_U0_sub_RY_use_fabric_adder_out_s(9),
      a(8) => BU2_U0_sub_RY_use_fabric_adder_out_s(8),
      a(7) => BU2_U0_sub_RY_use_fabric_adder_out_s(7),
      a(6) => BU2_U0_sub_RY_use_fabric_adder_out_s(6),
      a(5) => BU2_U0_sub_RY_use_fabric_adder_out_s(5),
      a(4) => BU2_U0_sub_RY_use_fabric_adder_out_s(4),
      a(3) => BU2_U0_sub_RY_use_fabric_adder_out_s(3),
      a(2) => BU2_U0_sub_RY_use_fabric_adder_out_s(2),
      a(1) => BU2_U0_sub_RY_use_fabric_adder_out_s(1),
      a(0) => BU2_U0_sub_RY_use_fabric_adder_out_s(0),
      b(16) => BU2_N0,
      b(15) => BU2_N1,
      b(14) => BU2_N0,
      b(13) => BU2_N0,
      b(12) => BU2_N1,
      b(11) => BU2_N0,
      b(10) => BU2_N1,
      b(9) => BU2_N1,
      b(8) => BU2_N1,
      b(7) => BU2_N0,
      b(6) => BU2_N1,
      b(5) => BU2_N0,
      b(4) => BU2_N0,
      b(3) => BU2_N1,
      b(2) => BU2_N0,
      b(1) => BU2_N1,
      b(0) => BU2_N1,
      c(11) => BU2_N0,
      c(10) => BU2_N0,
      c(9) => BU2_N0,
      c(8) => BU2_N0,
      c(7) => BU2_N1,
      c(6) => BU2_N0,
      c(5) => BU2_N0,
      c(4) => BU2_N0,
      c(3) => BU2_N0,
      c(2) => BU2_N0,
      c(1) => BU2_N0,
      c(0) => BU2_N0
    );
  BU2_U0_v4_mac23_mac_cBY : mac_2_INST_1
    port map (
      clk => clk,
      ce => ce,
      sclr => sclr,
      p(11) => NLW_BU2_U0_v4_mac23_mac_cBY_p_11_UNCONNECTED,
      p(10) => NLW_BU2_U0_v4_mac23_mac_cBY_p_10_UNCONNECTED,
      p(9) => BU2_U0_cb_int(9),
      p(8) => BU2_U0_cb_int(8),
      p(7) => BU2_U0_cb_int(7),
      p(6) => BU2_U0_cb_int(6),
      p(5) => BU2_U0_cb_int(5),
      p(4) => BU2_U0_cb_int(4),
      p(3) => BU2_U0_cb_int(3),
      p(2) => BU2_U0_cb_int(2),
      p(1) => BU2_U0_cb_int(1),
      p(0) => BU2_U0_cb_int(0),
      a(17) => BU2_U0_sub_BY_use_fabric_adder_out_s(17),
      a(16) => BU2_U0_sub_BY_use_fabric_adder_out_s(16),
      a(15) => BU2_U0_sub_BY_use_fabric_adder_out_s(15),
      a(14) => BU2_U0_sub_BY_use_fabric_adder_out_s(14),
      a(13) => BU2_U0_sub_BY_use_fabric_adder_out_s(13),
      a(12) => BU2_U0_sub_BY_use_fabric_adder_out_s(12),
      a(11) => BU2_U0_sub_BY_use_fabric_adder_out_s(11),
      a(10) => BU2_U0_sub_BY_use_fabric_adder_out_s(10),
      a(9) => BU2_U0_sub_BY_use_fabric_adder_out_s(9),
      a(8) => BU2_U0_sub_BY_use_fabric_adder_out_s(8),
      a(7) => BU2_U0_sub_BY_use_fabric_adder_out_s(7),
      a(6) => BU2_U0_sub_BY_use_fabric_adder_out_s(6),
      a(5) => BU2_U0_sub_BY_use_fabric_adder_out_s(5),
      a(4) => BU2_U0_sub_BY_use_fabric_adder_out_s(4),
      a(3) => BU2_U0_sub_BY_use_fabric_adder_out_s(3),
      a(2) => BU2_U0_sub_BY_use_fabric_adder_out_s(2),
      a(1) => BU2_U0_sub_BY_use_fabric_adder_out_s(1),
      a(0) => BU2_U0_sub_BY_use_fabric_adder_out_s(0),
      b(16) => BU2_N0,
      b(15) => BU2_N1,
      b(14) => BU2_N0,
      b(13) => BU2_N0,
      b(12) => BU2_N1,
      b(11) => BU2_N0,
      b(10) => BU2_N0,
      b(9) => BU2_N1,
      b(8) => BU2_N1,
      b(7) => BU2_N1,
      b(6) => BU2_N1,
      b(5) => BU2_N0,
      b(4) => BU2_N0,
      b(3) => BU2_N0,
      b(2) => BU2_N0,
      b(1) => BU2_N1,
      b(0) => BU2_N1,
      c(11) => BU2_N0,
      c(10) => BU2_N0,
      c(9) => BU2_N0,
      c(8) => BU2_N0,
      c(7) => BU2_N1,
      c(6) => BU2_N0,
      c(5) => BU2_N0,
      c(4) => BU2_N0,
      c(3) => BU2_N0,
      c(2) => BU2_N0,
      c(1) => BU2_N0,
      c(0) => BU2_N0
    );
  BU2_XST_VCC : VCC
    port map (
      P => BU2_N1
    );
  BU2_XST_GND : GND
    port map (
      G => BU2_N0
    );

end STRUCTURE;

-- synthesis translate_on
