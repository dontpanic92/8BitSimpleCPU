LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.std_logic_arith.ALL; 
entity ALU is  
	port(
	clk: in std_logic;
	DataInOut: inout std_logic_vector(15 downto 0);
	cSetA: in std_logic;
	cSetB: in std_logic;
	cOut: in std_logic;
	c16Bit: in std_logic;
	
	CyIn: in std_logic;
	CyOut: out std_logic;
	ZOut: out std_logic;
	Card: in std_logic_vector(4 downto 0)
);
end ALU;

architecture arch of ALU is
signal ALUOut: std_logic_vector(15 downto 0);
signal ALUA: std_logic_vector(15 downto 0);
signal ALUB: std_logic_vector(15 downto 0);
component ALUCalcUnit
	port(
	Card: in std_logic_vector(4 downto 0);  
	A: in std_logic_vector(15 downto 0);
	B: in std_logic_vector(15 downto 0);
	Cin: in std_logic;
	Cout: out std_logic;
	F:out std_logic_vector(15 downto 0);
	c16Bit: in std_logic
	);
end component;
begin
	alucalc: ALUCalcUnit port map(Card, ALUA, ALUB, CyIn, CyOut, ALUOut, c16Bit);
	
	process(clk, cSetA)
	begin
		if(clk'event and clk = '0' and cSetA = '1') then
			ALUA(7 downto 0) <= DataInOut(7 downto 0);
			if(c16Bit = '0') then
				ALUA(15 downto 8) <= "00000000";
			else
				ALUA(15 downto 8) <= DataInOut(15 downto 8);
			end if;
		end if;
	end process;

	process(clk, cSetB)
	begin
		if(clk'event and clk = '0' and cSetB = '1') then
			ALUB(7 downto 0) <= DataInOut(7 downto 0);
			if(c16Bit = '0') then
				ALUB(15 downto 8) <= "00000000";
			else
				ALUB(15 downto 8) <= DataInOut(15 downto 8);
			end if;
		end if;
	end process;

--	ALUA(7 downto 0) <= DataInOut(7 downto 0) when cSetA = '1' else ALUA(7 downto 0);
--	ALUA(15 downto 8) <= "00000000" when cSetA = '1' and c16Bit = '0' else
--								DataInOut(15 downto 8) when cSetA = '1' else ALUA(15 downto 8);
--	
--	ALUB(7 downto 0) <= DataInOut(7 downto 0) when cSetB = '1' else ALUB(7 downto 0);
--	ALUB(15 downto 8) <= "00000000" when cSetB = '1' and c16Bit = '0'
--								else DataInOut(15 downto 8) when cSetB = '1' else ALUB(15 downto 8);
	DataInOut <= "00000000" & ALUOut(7 downto 0) when cOut = '1' and c16Bit = '0'
					else ALUOut when cOut = '1' and c16Bit = '1' else (others => 'Z');
					
	ZOut <= '1' when (c16Bit = '1' and ALUOut = "0000000000000000") or (c16Bit = '0' and ALUOut(7 downto 0) = "00000000")
				else '0';
end arch;