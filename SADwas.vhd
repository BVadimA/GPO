----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:12:01 02/27/2014 
-- Design Name: 
-- Module Name:    SAD - Behavioral 
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
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SAD is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           src : in  STD_LOGIC_VECTOR (31 downto 0);
           valid_src : in  STD_LOGIC;
           valid_ref : in  STD_LOGIC;
           ref : in  STD_LOGIC_VECTOR (31 downto 0);
           valid_SAD : out  STD_LOGIC;
           SAD_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end SAD;

architecture Behavioral of SAD is
	signal Sad0 :std_logic_vector(8 downto 0):= (others =>'0');
	signal Spix1	: std_LOGIC_VECTOR(8 DOWNTO 0);
	signal Rpix1	: std_LOGIC_VECTOR(8 DOWNTO 0);
	signal Spix0	: std_LOGIC_VECTOR(8 DOWNTO 0);
	signal Rpix0	: std_LOGIC_VECTOR(8 DOWNTO 0);
	signal Spix2	: std_LOGIC_VECTOR(8 DOWNTO 0);
	signal Rpix2	: std_LOGIC_VECTOR(8 DOWNTO 0);
	signal Spix3	: std_LOGIC_VECTOR(8 DOWNTO 0);
	signal Rpix3	: std_LOGIC_VECTOR(8 DOWNTO 0);
	signal Sad1 :std_logic_vector(8 downto 0):= (others =>'0');
	signal Sad2 :std_logic_vector(8 downto 0):= (others =>'0');
	signal Sad3 :std_logic_vector(8 downto 0):= (others =>'0');
	signal Sadsum1 :std_logic_vector(8 downto 0):= (others =>'0');
	signal Sadsum2 :std_logic_vector(8 downto 0):= (others =>'0');
	signal Sadsum :std_logic_vector(9 downto 0):= (others =>'0');
	signal SADBlock :std_logic_vector(15 downto 0):= (others =>'0');
	signal count:std_logic_vector (5 downto 0):= (others =>'0');

begin
	Spix0	<= '0' & src(7 downto 0);
	Rpix0	<= '0' & ref(7 downto 0);
	Sad0 	<= abs(Spix0 - Rpix0);
	
	Spix1	<= '0' & src(15 downto 8);
	Rpix1	<= '0' & ref(15 downto 8);
	Sad1 	<= abs(Spix1 - Rpix1);
	
	Spix2	<= '0' & src(23 downto 16);
	Rpix2	<= '0' & ref(23 downto 16);
	Sad2 	<= abs(Spix2 - Rpix2);
	
	Spix3	<= '0' & src(31 downto 24);
	Rpix3	<= '0' & ref(31 downto 24);
	Sad3 	<= abs(Spix3 - Rpix3);
	
	Sadsum1<= ('0' & Sad0(7 downto 0)) + ('0' & Sad1(7 downto 0));
	Sadsum2<=('0' & Sad2(7 downto 0)) + ('0' & Sad3(7 downto 0));
	Sadsum<= ('0' & Sadsum1) +('0'& Sadsum2);
	
Process(clk,reset)
begin
	if reset = '1' then  
		SADBlock<= (others =>'0');
	elsif rising_edge (clk) then
		if valid_src='1' and valid_ref ='1' then
			if count= "111111" then
				count		<= (others =>'0');
				SADBlock <=(others =>'0');
				valid_SAD<= '1';
			else
				valid_SAD<= '0';
				Count		<= count+1;
				SADBlock	<= SADBlock + Sadsum;			
			end if;
		end if;
	end if;
end process;
SAD_OUT<= SADBlock;
end Behavioral;