LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.std_logic_arith.ALL; 
entity RegArr is  
	port(
	clk: in std_logic;
	DataInOut: inout std_logic_vector(15 downto 0);
	R7Out: out std_logic_vector(7 downto 0);
	isel: in std_logic_vector(2 downto 0);
	osel: in std_logic_vector(2 downto 0);
	cin: in std_logic;
	cout: in std_logic;
	rst: in std_logic
);
end RegArr; 

architecture arch of RegArr is
type reg_arr is array(7 downto 0) of std_logic_vector(7 downto 0);
signal reg: reg_arr;
begin
	process(rst, cin, cout, DataInOut, isel, osel, reg, clk)
	begin
		if(rst = '1') then
			reg(0) <= "00000000";
			reg(1) <= "00000000";
			reg(2) <= "00000000";
			reg(3) <= "00000000";
			reg(4) <= "00000000";
			reg(5) <= "00000000";
			reg(6) <= "00000000";
			reg(7) <= "00000000";
		elsif(clk'event and clk = '0')then
			if (cout = '1' and cin = '1') then
				reg(conv_integer(isel)) <= reg(conv_integer(osel));
			elsif (cin = '1' and isel >= 0 and isel <= 7) then
				reg(conv_integer(isel)) <= DataInOut(7 downto 0);
			end if;
		end if;
		if (cout = '1' and osel >= 0 and osel <= 7) then
			DataInOut <= "00000000" & reg(conv_integer(osel));
		else
			DataInOut <= (others => 'Z');
		end if;
	end process;
	
	--reg(conv_integer(isel)) <= reg(conv_integer(osel)) when cout = '1' and cin = '1' and 
	--								else DataInOut(7 downto 0) when cin = '1' and isel >=0 and isel <= 7;
	--DataInOut <= "00000000" & reg(conv_integer(osel)) when cout = '1' and cin = '0' and osel >= 0 and osel <= 7 else
	--				(others => 'Z');
	R7Out <= reg(7);
end arch;