--------------------------------------------------------------------------------
--     This file is owned and controlled by Xilinx and must be used           --
--     solely for design, simulation, implementation and creation of          --
--     design files limited to Xilinx devices or technologies. Use            --
--     with non-Xilinx devices or technologies is expressly prohibited        --
--     and immediately terminates your license.                               --
--                                                                            --
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"          --
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                --
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION        --
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION            --
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS              --
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                --
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE       --
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY               --
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                --
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         --
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        --
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS        --
--     FOR A PARTICULAR PURPOSE.                                              --
--                                                                            --
--     Xilinx products are not intended for use in life support               --
--     appliances, devices, or systems. Use in such applications are          --
--     expressly prohibited.                                                  --
--                                                                            --
--     (c) Copyright 1995-2007 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- The following code must appear in the VHDL architecture header:

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
component rgb2ycrcb_v1_0
	port (
	y: OUT std_logic_VECTOR(7 downto 0);
	cr: OUT std_logic_VECTOR(7 downto 0);
	cb: OUT std_logic_VECTOR(7 downto 0);
	r: IN std_logic_VECTOR(7 downto 0);
	g: IN std_logic_VECTOR(7 downto 0);
	b: IN std_logic_VECTOR(7 downto 0);
	v_sync_in: IN std_logic;
	h_sync_in: IN std_logic;
	pix_en_in: IN std_logic;
	v_sync_out: OUT std_logic;
	h_sync_out: OUT std_logic;
	pix_en_out: OUT std_logic;
	clk: IN std_logic;
	ce: IN std_logic;
	sclr: IN std_logic);
end component;

-- Synplicity black box declaration
attribute syn_black_box : boolean;
attribute syn_black_box of rgb2ycrcb_v1_0: component is true;

-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : rgb2ycrcb_v1_0
		port map (
			y => y,
			cr => cr,
			cb => cb,
			r => r,
			g => g,
			b => b,
			v_sync_in => v_sync_in,
			h_sync_in => h_sync_in,
			pix_en_in => pix_en_in,
			v_sync_out => v_sync_out,
			h_sync_out => h_sync_out,
			pix_en_out => pix_en_out,
			clk => clk,
			ce => ce,
			sclr => sclr);
-- INST_TAG_END ------ End INSTANTIATION Template ------------

-- You must compile the wrapper file rgb2ycrcb_v1_0.vhd when simulating
-- the core, rgb2ycrcb_v1_0. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

