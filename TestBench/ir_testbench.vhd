--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:34:43 11/13/2013
-- Design Name:   
-- Module Name:   D:/vhdl/cpu/ise_project/TestBench/ir_testbench.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ir
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
 
ENTITY ir_testbench IS
END ir_testbench;
 
ARCHITECTURE behavior OF ir_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ir
    PORT(
         DataInOut : INOUT  std_logic_vector(15 downto 0);
         cout : IN  std_logic;
         cin : IN  std_logic;
         OpOut : OUT  std_logic_vector(4 downto 0);
         AD1Out : OUT  std_logic_vector(2 downto 0);
         AD2Out : OUT  std_logic_vector(2 downto 0);
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal cout : std_logic := '0';
   signal cin : std_logic := '0';
   signal rst : std_logic := '0';

	--BiDirs
   signal DataInOut : std_logic_vector(15 downto 0);

 	--Outputs
   signal OpOut : std_logic_vector(4 downto 0);
   signal AD1Out : std_logic_vector(2 downto 0);
   signal AD2Out : std_logic_vector(2 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ir PORT MAP (
          DataInOut => DataInOut,
          cout => cout,
          cin => cin,
          OpOut => OpOut,
          AD1Out => AD1Out,
          AD2Out => AD2Out,
          rst => rst
        );

rst_process :process
   begin
		rst <= '1';
		wait for 80 ns;
		rst <= '0';
		wait for 400 ns;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		wait for 100 ns;
      wait for 20 ns;	

      DataInOut <= "0000000011111010";
		cin <= '1';
		wait for 20 ns;
		cin <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 40 ns;
		cout <= '0';
		DataInOut <= "1000100011111111";
		cin <= '1';
		wait for 20 ns;
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		cout <= '1';
		cin <= '0';
		wait for 20 ns;
      wait;
   end process;


END;
