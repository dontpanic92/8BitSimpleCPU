----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:11:57 11/11/2013 
-- Design Name: 
-- Module Name:    ir - Behavioral 
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

entity ir is
	port(
		clk: in std_logic;
		DataInOut: inout std_logic_vector(15 downto 0);
		cout: in std_logic;
		cin: in std_logic;
		OpOut: out std_logic_vector(4 downto 0);
		AD1Out: out std_logic_vector(2 downto 0);
		AD2Out: out std_logic_vector(2 downto 0);
		rst: in std_logic;
		debug_irout: out std_logic_vector(15 downto 0)
	);
end ir;

architecture Behavioral of ir is
signal irreg: std_logic_vector(15 downto 0);
begin
	debug_irout<=irreg;
	process(rst, cout, irreg, cin, DataInOut, clk)
	begin
		if(rst = '1') then
			irreg <= "0000000000000000";
		elsif (clk'event and clk = '0' and cin = '1') then
			irreg <= DataInOut;
		end if;
		if(cout = '1') then
			DataInOut <= "00000000" & irreg(7 downto 0);
		else
			DataInOut <= "ZZZZZZZZZZZZZZZZ";
		end if;
	end process;
	
	OpOut <= irreg(15 downto 11);
	AD1Out <= irreg(10 downto 8);
	AD2Out <= irreg(2 downto 0);
end Behavioral;

