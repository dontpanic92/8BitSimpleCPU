LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.std_logic_arith.ALL; 
entity MemUnit is  
	port(
	clk: in std_logic;
	DataInOut: inout std_logic_vector(15 downto 0);
	DataR7: in std_logic_vector(7 downto 0);
	cMARinBus: in std_logic;
	cMARinR7:  in std_logic;
	cMDRin: in std_logic;
	cMDRout:in std_logic;
	cnRD: in std_logic;
	cnWR: in std_logic;
	cnBHE: in std_logic;
	cnBLE: in std_logic;
	
	ABus: out std_logic_vector(15 downto 0);
	DBus: inout std_logic_vector(15 downto 0);
	nRD: out std_logic;
	nWR: out std_logic;
	nBHE: out std_logic;
	nBLE: out std_logic
);
end MemUnit; 

architecture arch of MemUnit is
signal MAR: std_logic_vector(15 downto 0);
signal MDR: std_logic_vector(15 downto 0);
begin
	nBHE <= cnBHE;
	nBLE <= cnBLE;
	MAR(15 downto 8) <= DataR7 when cMARinR7 = '1' else DataInOut(15 downto 8) when cMARinBus = '1';
	
	process (clk, cMarinBus, cMARinR7)
	begin
		if (clk'event and clk = '0' and (cMARinBUS = '1' or cMARinR7 = '1')) then
			MAR(7 downto 0) <= DataInOut(7 downto 0);
		end if;
	end process;
	
--	process (clk, cMDRin, cnRD)
--	begin
--		if(cnRD = '0') then
--			MDR <= DBus;
--		elsif(clk'event and clk = '0' and cMDRin = '1') then
--			MDR <= DataInOut;
--		end if;
--	end process;
   MDR <= DataInOut when cMDRin = '1' else DBus when cnRD = '0';
	DataInOut <= MDR when cMDRout = '1' else (others => 'Z');
	
	ABus <= MAR when cnRD = '0' or cnWR = '0' else (others => 'Z');
	nRD <= cnRD;
	nWR <= cnWR;
	DBus <= MDR when cnWR = '0' else (others=>'Z');
	--process(cnRD, cnWR)
	--begin
		--if(cnRD = '0') then
			--ABus <= MAR;
			--nRD <= '0';
		--elsif(cnWR = '0') then
			--ABus <= MAR;
			--DBus <= MDR;
			--nWR <= '0';
		--else
			--DBus <= (others => 'Z');
		--end if;
	--end process;
end arch;