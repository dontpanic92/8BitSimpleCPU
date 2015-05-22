----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:47:46 12/06/2013 
-- Design Name: 
-- Module Name:    cyr - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cyr is
	port(
		clk: in std_logic;
		cin: in std_logic;
		cyin: in std_logic;
		cyout: out std_logic
	);
end cyr;

architecture Behavioral of cyr is
signal cy: std_logic := '0';
begin
cyout <= cy;
process(clk, cin)
begin
	if(clk'event and clk = '0' and cin = '1') then
		cy <= cyin;
	end if;
end process;
end Behavioral;

