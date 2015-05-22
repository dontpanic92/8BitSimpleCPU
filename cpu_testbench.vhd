--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:03:27 11/29/2013
-- Design Name:   
-- Module Name:   D:/vhdl/cpu/ise_project/cpu_testbench.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY cpu_testbench IS
END cpu_testbench;
 
ARCHITECTURE behavior OF cpu_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU
    PORT(
         RST : IN  std_logic;
         CLK : IN  std_logic;
         ABUS : OUT  std_logic_vector(15 downto 0);
         DBUS : INOUT  std_logic_vector(15 downto 0);
         nMREQ : OUT  std_logic;
         nRD : OUT  std_logic;
         nWR : OUT  std_logic;
         nBHE : OUT  std_logic;
         nBLE : OUT  std_logic
        );
    END COMPONENT;
    
   
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

   --Inputs
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

	--BiDirs
   signal DBUS : std_logic_vector(15 downto 0);

 	--Outputs
   signal ABUS : std_logic_vector(15 downto 0);
   signal nMREQ : std_logic;
   signal nRD : std_logic;
   signal nWR : std_logic;
   signal nBHE : std_logic;
   signal nBLE : std_logic;
   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU PORT MAP (
          RST => RST,
          CLK => CLK,
          ABUS => ABUS,
          DBUS => DBUS,
          nMREQ => nMREQ,
          nRD => nRD,
          nWR => nWR,
          nBHE => nBHE,
          nBLE => nBLE
        );
   uut1: Memory PORT MAP (
          ABUS => ABUS,
          DBUS => DBUS,
          nMREQ => nMREQ,
          nRD => nRD,
          nWR => nWR,
          nBHE => nBHE,
          nBLE => nBLE
        );
   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '1';
		wait for CLK_period/2;
		CLK <= '0';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 10 ns;
		rst <= '0';
		wait for 1000 ns;
      -- insert stimulus here 
      wait;
   end process;

END;
