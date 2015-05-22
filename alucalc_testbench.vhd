--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:52:10 11/13/2013
-- Design Name:   
-- Module Name:   D:/vhdl/cpu/ise_project/alucalc_testbench.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALUCalcUnit
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
 
ENTITY alucalc_testbench IS
END alucalc_testbench;
 
ARCHITECTURE behavior OF alucalc_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALUCalcUnit
    PORT(
         Card : IN  std_logic_vector(4 downto 0);
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         Cin : IN  std_logic;
         Cout : OUT  std_logic;
         F : OUT  std_logic_vector(15 downto 0);
			c16Bit: IN std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Card : std_logic_vector(4 downto 0) := (others => '0');
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal Cin : std_logic := '0';
	signal c16Bit: std_logic := '0';

 	--Outputs
   signal Cout : std_logic;
   signal F : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALUCalcUnit PORT MAP (
          Card => Card,
          A => A,
          B => B,
          Cin => Cin,
          Cout => Cout,
          F => F,
			 c16Bit => c16Bit
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		c16Bit <= '0';
		A<= "0000000000001111";
		B<= "0000000011110000";
		Card<="00000";
		wait for 20 ns;
		Card <= "00001";
		Cin <= '1';
		wait for 20 ns;
		Cin <= '0';
		Card <= "11000";
		wait for 20 ns;
      -- insert stimulus here 
		
		c16Bit <= '1';
		A<= "0001000000001111";
		B<= "0000100011110000";
		Card<="00000";
		wait for 20 ns;
		Card <= "00001";
		Cin <= '1';
		wait for 20 ns;
		Cin <= '0';
		Card <= "11000";
		wait for 20 ns;
      wait;
   end process;

END;
