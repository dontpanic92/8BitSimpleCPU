LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.std_logic_arith.ALL; 
entity ALUCalcUnit is  
	port(
	Card: in std_logic_vector(4 downto 0);  
	A: in std_logic_vector(15 downto 0);
	B: in std_logic_vector(15 downto 0);
	Cin: in std_logic;
	Cout: out std_logic;
	F:out std_logic_vector(15 downto 0);
	c16bit: in std_logic
);
end ALUCalcUnit;

architecture arch of ALUCalcUnit is
signal outF: std_logic_vector(16 downto 0):= "00000000000000000";
signal inA: std_logic_vector(16 downto 0):= "00000000000000000";
signal inB: std_logic_vector(16 downto 0):= "00000000000000000";
begin
	inA <= "0" & A when c16Bit = '1'
			else "000000000" & A(7 downto 0);
	inB <= "0" & B when c16Bit = '1'
			else "000000000" & B(7 downto 0);
	outF <= inA + inB when ( Card = "00000" )else
		inA + inB + Cin when ( Card = "00001" )else
		inA - inB when ( Card = "00010" )else
		inA - inB - Cin when ( Card = "00011" )else
		inB - inA when ( Card = "00100" )else
		inB - inA - Cin when ( Card = "00101" )else
		inA when ( Card = "10110" )else
		inB when ( Card = "10111" )else
		not inA when ( Card = "11000" )else
		not inB when ( Card = "11001" )else
		inA or inB when ( Card = "11010" )else
		inA and inB when ( Card = "11011" )else
		not (inA xor inB) when ( Card = "11100" )else
		inA xor inB when ( Card = "11101" )else
		not (inA and inB) when ( Card = "11110" )else
		"00000000000000000" when ( Card = "11111" )else
		"ZZZZZZZZZZZZZZZZZ";
	Cout <= outF(8) when Card(4) = '0' and c16Bit = '0'
			 else outF(16) when Card(4) = '0' and c16Bit = '1';
	F <= "00000000" & outF(7 downto 0) when c16Bit = '0' 
		else outF(15 downto 0) when c16Bit = '1';
end arch;