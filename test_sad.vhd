--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:17:20 02/27/2014
-- Design Name:   
-- Module Name:   D:/example/ME/test_sad.vhd
-- Project Name:  ME
-- Target Device:  
-- Tool versions:  
-- Desrciption:   
-- 
-- VHDL Test Bench Created by ISE for module: SAD
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
 use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_sad IS
END test_sad;
 
ARCHITECTURE behavior OF test_sad IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SAD
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         src : IN  std_logic_vector(31 downto 0);
         valid_src : IN  std_logic;
         valid_ref : IN  std_logic;
         ref : IN  std_logic_vector(31 downto 0);
         valid_SAD : OUT  std_logic;
         SAD_OUT : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal src : std_logic_vector(31 downto 0) := (others => '0');
   signal valid_src : std_logic := '0';
   signal valid_ref : std_logic := '0';
   signal ref : std_logic_vector(31 downto 0) := (others => '1');

 	--Outputs
   signal valid_SAD : std_logic;
   signal SAD_OUT : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SAD PORT MAP (
          clk => clk,
          reset => reset,
          src => src,
          valid_src => valid_src,
          valid_ref => valid_ref,
          ref => ref,
          valid_SAD => valid_SAD,
          SAD_OUT => SAD_OUT
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 90 ns;	
		valid_src	<= '1';
		valid_ref	<= '1';
      wait for clk_period*64;
		valid_src	<= '0';
		valid_ref	<= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
