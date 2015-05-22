--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:36:23 11/13/2013
-- Design Name:   
-- Module Name:   D:/vhdl/cpu/ise_project/TestBench/pc_testbench.vhd
-- Project Name:  cpu
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pc
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
 
ENTITY pc_testbench IS
END pc_testbench;
 
ARCHITECTURE behavior OF pc_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pc
    PORT(
         rst : IN  std_logic;
         cin : IN  std_logic;
         cout : IN  std_logic;
         step : IN  std_logic;
         DataInOut : INOUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal cin : std_logic := '0';
   signal cout : std_logic := '0';
   signal step : std_logic := '0';

	--BiDirs
   signal DataInOut : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pc PORT MAP (
          rst => rst,
          cin => cin,
          cout => cout,
          step => step,
          DataInOut => DataInOut
        );

   -- Clock process definitions
   rst_process :process
   begin
		rst <= '0';
		wait for 80 ns;
		rst <= '0';
		wait for 400 ns;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 20 ns;	

      DataInOut <= "0000000011111010";
		cin <= '1';
		wait for 20 ns;
		cin <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 10 ns;
		step  <= '1';
		wait for 20 ns;
		step<='0';
		wait for 10 ns;
		cout<='1';
--		cout <= '1'; <= '0';
--		DataInOut <= "ZZZZZZZZZZZZZZZZ";
--		wait for 40 ns;
--		cout <= '0';
--		DataInOut <= "0000000011111111";
--		cin <= '1';
--		wait for 20 ns;
--		DataInOut <= "ZZZZZZZZZZZZZZZZ";
--		cout <= '1';
--		cin <= '0';
--		wait for 20 ns;
--		step <= '1';
--		wait for 20 ns;
--		step <= '0';
--		wait for 20 ns;
      wait;
   end process;

END;
