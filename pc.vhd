----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:36:02 11/11/2013 
-- Design Name: 
-- Module Name:    pc - Behavioral 
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

entity pc is
	port(
		clk: in std_logic;
		rst: in std_logic;
		cin: in std_logic;
		cout: in std_logic;
		step: in std_logic;
		ADDRFromR7: in std_logic_vector(7 downto 0);
		DataInOut: inout std_logic_vector(15 downto 0);
		debug_pcout: out std_logic_vector(15 downto 0)
	);
end pc;

architecture Behavioral of pc is
signal pcreg:std_logic_vector(15 downto 0):= "0000000000000000";
begin
	debug_pcout <= pcreg;
	process(rst, cin, cout, step, pcreg, DataInOut, clk)
	begin
		if (rst = '1') then
			pcreg <= "0000000000000000";
		elsif (clk'event and clk = '0')then
			if(cin = '1') then
				pcreg <= ADDRFromR7 & DataInOut(7 downto 0);
			elsif(step = '1') then
				pcreg <= pcreg + 1;
			end if;
		--elsif (clk'event and clk = '0' and) then
		end if;
		if (cout = '1') then
			DataInOut <= pcreg;
		else
			DataInOut <= (others => 'Z');
		end if;
	end process;
end Behavioral;

