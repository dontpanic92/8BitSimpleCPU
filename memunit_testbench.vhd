--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:29:16 11/14/2013
-- Design Name:   
-- Module Name:   D:/vhdl/cpu/ise_project/memunit_testbench.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MemUnit
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
 
ENTITY memunit_testbench IS
END memunit_testbench;
 
ARCHITECTURE behavior OF memunit_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MemUnit
    PORT(
         DataInOut : INOUT  std_logic_vector(15 downto 0);
         DataR7 : IN  std_logic_vector(7 downto 0);
         cMARinBus : IN  std_logic;
         cMARinR7 : IN  std_logic;
         cMDRin : IN  std_logic;
         cMDRout : IN  std_logic;
         cnRD : IN  std_logic;
         cnWR : IN  std_logic;
         cnBHE : IN  std_logic;
			cnBLE : IN  std_logic;
         ABus : OUT  std_logic_vector(15 downto 0);
         DBus : INOUT  std_logic_vector(15 downto 0);
         nRD : OUT  std_logic;
         nWR : OUT  std_logic;
         nBHE : OUT  std_logic;
         nBLE : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal DataR7 : std_logic_vector(7 downto 0) := (others => '0');
   signal cMARinBus : std_logic := '0';
   signal cMARinR7 : std_logic := '0';
   signal cMDRin : std_logic := '0';
   signal cMDRout : std_logic := '0';
   signal cRD : std_logic := '0';
   signal cWR : std_logic := '0';
   signal cnBHE : std_logic := '0';
 signal cnBLE : std_logic := '0';

	--BiDirs
   signal DataInOut : std_logic_vector(15 downto 0);
   signal DBus : std_logic_vector(15 downto 0);

 	--Outputs
   signal ABus : std_logic_vector(15 downto 0);
   signal nRD : std_logic;
   signal nWR : std_logic;
   signal nBHE : std_logic;
   signal nBLE : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MemUnit PORT MAP (
          DataInOut => DataInOut,
          DataR7 => DataR7,
          cMARinBus => cMARinBus,
          cMARinR7 => cMARinR7,
          cMDRin => cMDRin,
          cMDRout => cMDRout,
          cnRD => cRD,
          cnWR => cWR,
			 cnBHE=>cnBHE,
			 cnBLE=>cnBLE,
          ABus => ABus,
          DBus => DBus,
          nRD => nRD,
          nWR => nWR,
          nBHE => nBHE,
          nBLE => nBLE
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		
      wait;
   end process;

END;
