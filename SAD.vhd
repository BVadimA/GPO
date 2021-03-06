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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
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

	signal Sadsum :std_logic_vector(9 downto 0):= (others =>'0');
	signal SADBlock :std_logic_vector(15 downto 0):= (others =>'0');
	signal count:std_logic_vector (5 downto 0):= (others =>'0');


component SADcount is
	
	port (  
		ref : in  STD_LOGIC_VECTOR (31 downto 0);
		src : in  STD_LOGIC_VECTOR (31 downto 0);
		Sadsum :out std_logic_vector(9 downto 0):= (others =>'0')		
		  );
end component;


begin
	Com_logo : SADcount
 port map (
			ref	=> ref,
			src		=> src,
			Sadsum=> Sadsum
);			



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