----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:44:43 11/30/2013 
-- Design Name: 
-- Module Name:    Memory - Behavioral 
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
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.std_logic_arith.ALL; 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Memory is
Port(
	nBHE: in std_logic;
	nBLE: in std_logic;
	nRD: in std_logic;
	nWR: in std_logic;
	nMREQ: in std_logic;
	ABUS: in std_logic_vector(15 downto 0);
	DBUS: out std_logic_vector(15 downto 0)
);
end Memory;

architecture Behavioral of Memory is
type s is array(28 downto 0) of std_logic_vector(15 downto 0);
signal mem : s := (
"0000100011111111",
"0001000011111111",
"0000100100000001",
"0010000000000001",
"0001000011111111",
"0111100000000000",
					"0000101011111110" ,
					"1000101100000010",
					"0001001111111111",
					"0000111011110000",
					"0001011011111111",
					"1001000000001110",
					"0001000011111111",
					"0010100000010000",
					"0001000011111111",
					"0011000000000001",
					"0001000011111111",
					"0011100000010000",
					"0001000011111111",
					"0100000000010000",
					"0001000011111111",
					"0100100000000001",
					"0001000011111111",
					"0101100000010000",
					"0001000011111111",
					"0101000000000001",
					"0001000011111111",
					"0110100000000000",
					"1000000011111111"
);
begin
	DBUS<=mem(28 - conv_integer(ABUS)) when nRD = '0' and ABUS >=0 and ABUS <= 28
		else "0000000000000000" when nRD = '0' and ABUS > 28
		else "ZZZZZZZZZZZZZZZZ";
--		DBUS <= "0000100011111111"	--mov r7, 10100101b   0FA5
--				when ABUS = "0000000000000000" and nRD = '0' else
--				  "0001000011111111"	--mov r0, r7     0007
--				when ABUS = "0000000000000001" and nRD = '0' else
--				  --"00010" & "000" & "11111111"  --mov [r7//11111111b], r0 10FF
--				  "00001001000000010"   -- mov r2, [r7//10101010] 1AAA
--				when ABUS = "0000000000000010" and nRD = '0' else
--					--"01101" & "00000000000" --stc     6800
--					"0010000000000001" -- mov r1, [[r2]] 8902
--				when ABUS = "0000000000000011" and nRD = '0' else
--					--"00101" & "001" & "10101000" --adc r1, 10101000b
--					"0001000011111111" -- jc 0xFE 80FE
--				when ABUS = "0000000000000100" and nRD = '0' else
--					"0111100011111111" -- jmp 0x0
--				when ABUS = "0000000000000101" and nRD = '0' else
--					"0000101011111110" 
--					"1000101100000010"
--					"0001001111111111"
--					"0000111011110000"
--					"0001011011111111"
--					"1001000000001110"
--					"0001000011111111"
--					"0010100000010000"
--					"0001000011111111"
--					"0011000000000001"
--					"0001000011111111"
--					"0011100000010000"
--					"0001000011111111"
--					"0100000000010000"
--					"0001000011111111"
--					"0100100000000001"
--					"0001000011111111"
--					"0101100000010000"
--					"0001000011111111"
--					"0101000000000001"
--					"0001000011111111"
--					"0110100000000000"
--					"1000000011111111"
--					
--				when ABUS = "1010010110101010" and nRD = '0' else
--				"0000000011111111" 
--				when ABUS = "1010010111110000" and nRD = '0' else
--				"0000000000001111" 
--				when ABUS = "1010010111111111" and nRD = '0' else
--		        "ZZZZZZZZZZZZZZZZ";
end Behavioral;

