--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:48:25 07/08/2010
-- Design Name:   
-- Module Name:   C:/designs/app_notes/prbs_xapp/prbs_top_tb.vhd
-- Project Name:  prbs_xapp
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: prbs_top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY prbs_top_tb IS
END prbs_top_tb;
 
ARCHITECTURE behavior OF prbs_top_tb IS 

  -- Clock period definitions
   constant CLK_period : time := 10 ns;   
   
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT prbs_top
    PORT(
          INJ_ERR : in  std_logic;
          CLK : in  std_logic;
          ERR_DETECT_8 : out std_logic;
          ERR_DETECT_9 : out std_logic        );
    END COMPONENT;
    

   --Inputs
   signal INJ_ERR : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal ERR_DETECT_8 : std_logic;
   signal ERR_DETECT_9 : std_logic;

  
BEGIN

   ----------------------------------------------------------------------------------------------- 
	-- Instantiate the Unit Under Test (UUT)
   -----------------------------------------------------------------------------------------------
   uut: prbs_top PORT MAP (
          INJ_ERR => INJ_ERR,
          CLK => CLK,
          ERR_DETECT_8 => ERR_DETECT_8,
          ERR_DETECT_9 => ERR_DETECT_9
        );

   -----------------------------------------------------------------------------------------------
   --      Clock generator
   -----------------------------------------------------------------------------------------------
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
   
   -----------------------------------------------------------------------------------------------
   --      Inject error generator
   -----------------------------------------------------------------------------------------------
   INJ_ERR_PROCESS :
          process
   begin
          INJ_ERR <= '0';
          wait for (100*CLK_period - 100 ns);
          wait until rising_edge(CLK);
          INJ_ERR <= '1';
          wait until rising_edge(CLK);         
          INJ_ERR <= '0';
          wait;
   end process ;

END;
