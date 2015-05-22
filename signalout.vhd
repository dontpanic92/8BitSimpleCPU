----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:41:56 11/22/2013 
-- Design Name: 
-- Module Name:    signalout - Behavioral 
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

entity signalout is
port(
	cMemUnit_AinFromR7: out std_logic;
	cMemUnit_AinFromBus: out std_logic;
	cMemUnit_Din: out std_logic;
	cMemUnit_Dout: out std_logic;
	cMemUnit_nBHE: out std_logic;
	cMemUnit_nBLE: out std_logic;
	cMemUnit_nRD: out std_logic;
	cMemUnit_nWR:out std_logic;
	
	cIr_in: out std_logic;
	cIr_out: out std_logic;
	
	cPc_in: out std_logic;
	cPc_out: out std_logic;
	cPc_step: out std_logic;
	
	cRegArr_isel: out std_logic_vector(2 downto 0);
	cRegArr_osel: out std_logic_vector(2 downto 0);
	cRegArr_in: out std_logic;
	cRegArr_out: out std_logic;
	
	cALU_Ain: out std_logic;
	cALU_Bin: out std_logic;
	cALU_Out: out std_logic;
	cALU_16Bit: out std_logic;
	
	control_signal: in std_logic_vector(24 downto 0)
);
end signalout;

architecture Behavioral of signalout is

begin
	cMemUnit_AinFromR7 <= control_signal(24);
	cMemUnit_AinFromBus <= control_signal(23);
	cMemUnit_Din <= control_signal(22);
	cMemUnit_Dout <= control_signal(21);
	cMemUnit_nBHE <= control_signal(20);
	cMemUnit_nBLE <= control_signal(19);
	cMemUnit_nRD <= control_signal(18);
	cMemUnit_nWR <= control_signal(17);
	
	cIr_in <= control_signal(16);
	cIr_out <= control_signal(15);
	
	cPc_in <= control_signal(14);
	cPc_out <= control_signal(13);
	cPc_step <= control_signal(12);
	
	cRegArr_isel <= control_signal(11 downto 9);
	cRegArr_osel <= control_signal(8 downto 6);
	cRegArr_in <= control_signal(5);
	cRegArr_out <= control_signal(4);
	
	cALU_Ain <= control_signal(3);
	cALU_Bin <= control_signal(2);
	cALU_Out <= control_signal(1);
	cALU_16Bit <= control_signal(0);
end Behavioral;

