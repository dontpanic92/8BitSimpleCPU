--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:12:35 11/29/2013
-- Design Name:   
-- Module Name:   D:/vhdl/cpu/ise_project/cu_testbench.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cu
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
 
ENTITY cu_testbench IS
END cu_testbench;
 
ARCHITECTURE behavior OF cu_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cu
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         ir_opcode : IN  std_logic_vector(4 downto 0);
         ir_AD1 : IN  std_logic_vector(2 downto 0);
         ir_AD2 : IN  std_logic_vector(2 downto 0);
         cALU_Card : OUT  std_logic_vector(4 downto 0);
         cALU_CyIn : OUT  std_logic;
         cALU_CyOut : IN  std_logic;
         cALU_ZOut : IN  std_logic;
         control_signal : OUT  std_logic_vector(23 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal ir_opcode : std_logic_vector(4 downto 0) := (others => '0');
   signal ir_AD1 : std_logic_vector(2 downto 0) := (others => '0');
   signal ir_AD2 : std_logic_vector(2 downto 0) := (others => '0');
   signal cALU_CyOut : std_logic := '0';
   signal cALU_ZOut : std_logic := '0';

 	--Outputs
   signal cALU_Card : std_logic_vector(4 downto 0);
   signal cALU_CyIn : std_logic;
   signal control_signal : std_logic_vector(23 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cu PORT MAP (
          clk => clk,
          rst => rst,
          ir_opcode => ir_opcode,
          ir_AD1 => ir_AD1,
          ir_AD2 => ir_AD2,
          cALU_Card => cALU_Card,
          cALU_CyIn => cALU_CyIn,
          cALU_CyOut => cALU_CyOut,
          cALU_ZOut => cALU_ZOut,
          control_signal => control_signal
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		rst <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		rst <= '0';
		ir_opcode <= "00000";
		ir_AD1 <= "000";
		ir_AD2 <= "001";
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
