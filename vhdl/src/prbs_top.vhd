----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:59:48 07/08/2010 
-- Design Name: 
-- Module Name:    prbs_top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_MISC.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity prbs_top is
    Port (
          INJ_ERR : in  std_logic;
          CLK : in  std_logic;
          ERR_DETECT_8 : out std_logic := '0';
          ERR_DETECT_9 : out std_logic := '0'
          );
end prbs_top;

architecture Behavioral of prbs_top is

constant POLY_LENGHT : natural  :=  7 ;
constant POLY_TAP    : natural  :=  6 ;
constant INV_PATTERN : boolean := false;


signal inj_error_vector : std_logic_vector (0 downto 0);
signal prbs_out : std_logic_vector(0 downto 0);
signal prbs_8bits : std_logic_vector(7 downto 0) := (others => '1');
signal prbs_9bits : std_logic_vector(8 downto 0) := (others => '1');
signal sp8_cnt : std_logic_vector (2 downto 0) := (others => '0');
signal sp9_cnt : std_logic_vector (3 downto 0) := (others => '0');


signal chk_en_8 : std_logic := '0';
signal chk_en_9 : std_logic := '0';
signal err_out_8 : std_logic_vector (7 downto 0);
signal err_out_9 : std_logic_vector (8 downto 0);

component PRBS_ANY 
   generic (      
      CHK_MODE: boolean := false; 
      INV_PATTERN : boolean := false;
      POLY_LENGHT : natural range 0 to 63 := 31 ;
      POLY_TAP : natural range 0 to 63 := 3 ;
      NBITS : natural range 0 to 512 := 16
   );
   port (
      RST             : in  std_logic;                               -- sync reset active high
      CLK             : in  std_logic;                               -- system clock
      DATA_IN         : in  std_logic_vector(NBITS - 1 downto 0); -- inject error/data to be checked
      EN              : in  std_logic;                               -- enable/pause pattern generation
      DATA_OUT        : out std_logic_vector(NBITS - 1 downto 0)  -- generated prbs pattern/errors found
   );
end component;

begin

   inj_error_vector(0) <= INJ_ERR;

   ----------------------------------------------		
	-- Instantiate the PRBS generator
   ----------------------------------------------		
	I_PRBS_ANY_GEN: PRBS_ANY 
   GENERIC MAP(
      CHK_MODE =>  FALSE,
      INV_PATTERN => INV_PATTERN,
      POLY_LENGHT => POLY_LENGHT,              
      POLY_TAP => POLY_TAP,
      NBITS => 1

   )
   PORT MAP(
		RST => '0',
		CLK => CLK,
		DATA_IN => inj_error_vector,
		EN => '1',
		DATA_OUT => prbs_out
	);
   
   ----------------------------------------------		
   -- Serial to parallel converters
   ----------------------------------------------		
   
   SER_TO_PAR8 : process(CLK)
   begin
      if rising_edge(CLK) Then
        prbs_8bits <= prbs_out &  prbs_8bits(7 downto 1) ;
      end if;
   end process;
   
   SER_TO_PAR9 : process(CLK)
   begin
      if rising_edge(CLK) Then
        prbs_9bits <= prbs_out &  prbs_9bits(8 downto 1) ;
      end if;
   end process;
   
   ----------------------------------------------		
	-- Instantiate the checker with 8 bits input
   ----------------------------------------------
	I_PRBS_ANY_CHK8: PRBS_ANY 
   GENERIC MAP(
      CHK_MODE =>  TRUE,
      INV_PATTERN =>INV_PATTERN,
      POLY_LENGHT => POLY_LENGHT,              
      POLY_TAP => POLY_TAP,
      NBITS => 8
   )
   PORT MAP(
		RST => '0',
		CLK => CLK,
		DATA_IN => prbs_8bits,
		EN => chk_en_8,
		DATA_OUT => err_out_8
	);	
   
   
  ----------------------------------------------		
	-- Instantiate the checker with 9 bits input
   ----------------------------------------------
	I_PRBS_ANY_CHK9: PRBS_ANY 
   GENERIC MAP(
      CHK_MODE =>  TRUE,
      INV_PATTERN =>INV_PATTERN,
      POLY_LENGHT => POLY_LENGHT,              
      POLY_TAP => POLY_TAP,
      NBITS => 9
   )
   PORT MAP(
		RST => '0',
		CLK => CLK,
		DATA_IN => prbs_9bits,
		EN => chk_en_9,
		DATA_OUT => err_out_9
	);	   
  
  ----------------------------------------------		
	-- Generate the enable for the 8 bit checker 
   ----------------------------------------------     
   GEN_EN8 : process(CLK)
   begin
      if rising_edge(CLK) then
         sp8_cnt <= sp8_cnt + 1;
         if sp8_cnt = 7 then
            chk_en_8 <= '1';
         else
            chk_en_8 <= '0';
         end if;
      end if;
   end process;
   
  ----------------------------------------------		
	-- Generate the enable for the 9 bit checker 
   ----------------------------------------------     
   GEN_EN9 : process(CLK)
   begin
      if rising_edge(CLK) then
         sp9_cnt <= sp9_cnt + 1;
         if sp9_cnt = 8 then
            chk_en_9 <= '1';
            sp9_cnt <= (others => '0');
         else
            chk_en_9 <= '0';
         end if;
      end if;
   end process;
 

  ----------------------------------------------		
	-- Error detect from the 8 bit checker 
   ----------------------------------------------     
   ERROR_DETECT_8 : process(CLK)
   begin
      if rising_edge(CLK) then
         if chk_en_8 = '1' then
            err_detect_8  <= OR_REDUCE(err_out_8);
         end if;
      end if;
   end process;
         
  ----------------------------------------------		
	-- Error detect from the 9 bit checker 
   ----------------------------------------------     
   ERROR_DETECT_9 : process(CLK)
   begin
      if rising_edge(CLK) then
         if chk_en_9 = '1' then
            err_detect_9  <= OR_REDUCE(err_out_9);
         end if;
      end if;
   end process;
  
end Behavioral;

