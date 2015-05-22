----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:04:34 12/02/2013 
-- Design Name: 
-- Module Name:    CPUMEM - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPUMEM is
port(
	rst: in std_logic;
	clk: in std_logic
);
end CPUMEM;

architecture Behavioral of CPUMEM is
	 
	 component Memory
	 Port(
	nBHE: in std_logic;
	nBLE: in std_logic;
	nRD: in std_logic;
	nWR: in std_logic;
	nMREQ: in std_logic;
	ABUS: in std_logic_vector(15 downto 0);
	DBUS: out std_logic_vector(15 downto 0)
	);
	end component;
	
	component CPU
	port(
	RST: in std_logic;
	CLK: in std_logic;
	ABUS: out std_logic_vector(15 downto 0);
	DBUS: inout std_logic_vector(15 downto 0);
	nMREQ: out std_logic;
	nRD: out std_logic;
	nWR: out std_logic;
	nBHE: out std_logic;
	nBLE: out std_logic
);
end component;
signal nMREQ: std_logic;
signal nBHE: std_logic;
signal nBLE: std_logic;
signal nRD: std_logic;
signal nWR: std_logic;
signal ABUS: std_logic_vector(15 downto 0);
signal DBUS: std_logic_vector(15 downto 0);
begin
	c: CPU port map(
		rst=>rst,
		clk=>clk,
		nMREQ => nMREQ,
		nBHE => nBHE,
		nBLE => nBLE,
		nRD => nRD,
		nWR => nWR,
		ABUS => ABUS,
		DBUS => DBUS
	);
	
	m: Memory port map(
		nMREQ=>nMREQ,
		nBHE => nBHE,
		nBLE => nBLE,
		nRD => nRD,
		nWR => nWR,
		ABUS => ABUS,
		DBUS => DBUS
	);
	
end Behavioral;

