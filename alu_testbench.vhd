--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:57:13 11/13/2013
-- Design Name:   
-- Module Name:   D:/vhdl/cpu/ise_project/alu_testbench.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY alu_testbench IS
END alu_testbench;
 
ARCHITECTURE behavior OF alu_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
		clk: in std_logic;
         DataInOut : INOUT  std_logic_vector(15 downto 0);
         cSetA : IN  std_logic;
         cSetB : IN  std_logic;
         cOut : IN  std_logic;
			c16Bit: in std_logic;
         CyIn : IN  std_logic;
         CyOut : OUT  std_logic;
         ZOut : OUT  std_logic;
         Card : IN  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal cSetA : std_logic := '0';
   signal cSetB : std_logic := '0';
   signal cOut : std_logic := '0';
	signal c16Bit : std_logic := '0';
   signal CyIn : std_logic := '0';
   signal Card : std_logic_vector(4 downto 0) := (others => '0');
	signal clk : std_logic:='0';

	--BiDirs
   signal DataInOut : std_logic_vector(15 downto 0);

 	--Outputs
   signal CyOut : std_logic;
   signal ZOut : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
			clk=>clk,
          DataInOut => DataInOut,
          cSetA => cSetA,
          cSetB => cSetB,
          cOut => cOut,
          CyIn => CyIn,
          CyOut => CyOut,
          ZOut => ZOut,
          Card => Card,
			 c16Bit=> c16Bit
        );

clkp: process
begin
	clk <= '0';
	wait for 10 ns;
	clk <= '1';
	wait for 10 ns;
end process;

    stim_proc: process
    begin
	 -- hold reset state for 100 ns.
		c16Bit <= '0';
		wait for 10 ns;
      --wait for 20 ns;
		Card <= "00000";
      DataInOut <= "0000000011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0000000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		cOut <= '1';
		cSetB <= '0';
		wait for 20 ns;
		cout <= '0';
		CyIn <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		Card <= "00001";
		cout <= '1';
		wait for 20 ns;

		cout <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
      wait for 20 ns;
				
		Card <= "00001";
		DataInOut <= "1100101011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0101000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		csetB <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;

		cout <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
      wait for 20 ns;
		
		Card <= "00010";
		DataInOut <= "1100101011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0101000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		csetB <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;

		cout <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
      wait for 20 ns;
	
		Card <= "00011";
		DataInOut <= "1100101011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0101000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		csetB <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		
		cout <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
      wait for 20 ns;
		
		Card <= "00100";
		DataInOut <= "1100101011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0101000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		csetB <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		
		cout <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
      wait for 20 ns;
		
		Card <= "00101";
		DataInOut <= "1100101011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0101000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		csetB <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		
		cout <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
      wait for 20 ns;
		
		Card <= "10110";
		DataInOut <= "1100101011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0101000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		csetB <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		
				cout <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
      wait for 20 ns;
		
		Card <= "10111";
		DataInOut <= "1100101011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0101000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		csetB <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		
				cout <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
      wait for 20 ns;
		
		Card <= "11000";
		DataInOut <= "1100101011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0101000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		csetB <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		
				cout <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
      wait for 20 ns;
		
		Card <= "11001";
		DataInOut <= "1100101011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0101000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		csetB <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		
				cout <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
      wait for 20 ns;
		
		Card <= "11010";
		DataInOut <= "1100101011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0101000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		csetB <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		
				cout <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
      wait for 20 ns;
		
		Card <= "11011";
		DataInOut <= "1100101011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0101000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		csetB <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		
				cout <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
      wait for 20 ns;
		
		Card <= "11100";
		DataInOut <= "1100101011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0101000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		csetB <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		
				cout <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
      wait for 20 ns;
		
		Card <= "11101";
		DataInOut <= "1100101011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0101000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		csetB <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		
				cout <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
      wait for 20 ns;
		
		Card <= "11110";
		DataInOut <= "1100101011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0101000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		csetB <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		
				cout <= '0';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
      wait for 20 ns;
		
		Card <= "11111";
		DataInOut <= "1100101011110000";
		cSetA <= '1';
		cSetB <= '0';
		wait for 20 ns;
		DataInOut <= "0101000000001111";
		cSetA <= '0';
		cSetB <= '1';
		wait for 20 ns;
		csetB <= '0';
		cout <= '1';
		DataInOut <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		wait;
   end process;

END;
