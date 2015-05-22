--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:38:39 11/13/2013
-- Design Name:   
-- Module Name:   D:/vhdl/cpu/ise_project/TestBench/regarr_testbench.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegArr
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
 
ENTITY regarr_testbench IS
END regarr_testbench;
 
ARCHITECTURE behavior OF regarr_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegArr
    PORT(
         DataInOut : INOUT  std_logic_vector(15 downto 0);
         R7Out : OUT  std_logic_vector(7 downto 0);
         isel : IN  std_logic_vector(2 downto 0);
			osel : IN  std_logic_vector(2 downto 0);
         cin : IN  std_logic;
         cout : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal isel : std_logic_vector(2 downto 0) := (others => '0');
 signal osel : std_logic_vector(2 downto 0) := (others => '0');
   signal cin : std_logic := '0';
   signal cout : std_logic := '0';
   signal rst : std_logic := '0';

	--BiDirs
   signal DataInOut : std_logic_vector(15 downto 0);

 	--Outputs
   signal R7Out : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegArr PORT MAP (
          DataInOut => DataInOut,
          R7Out => R7Out,
          isel => isel,
			 osel => osel,
          cin => cin,
          cout => cout,
          rst => rst
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 20 ns;	
		isel <= "111";
		osel <= "111";
      DataInOut <= "0000000011111010";
		cin <= '1';
		wait for 20 ns;
		cin <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		cout <= '0';
		DataInOut <= "0000000011111111";
		cin <= '1';
		wait for 20 ns;
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		cout <= '1';
		cin <= '0';
		wait for 20 ns;
      wait;
   end process;

END;
