----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:22:17 11/15/2013 
-- Design Name: 
-- Module Name:    cu - Behavioral 
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

entity cu is
port(
	clk : in std_logic;
	rst: in std_logic;
	
	ir_opcode: in std_logic_vector(4 downto 0);
	ir_AD1: in std_logic_vector(2 downto 0);
	ir_AD2: in std_logic_vector(2 downto 0);
	
	cALU_Card: out std_logic_vector(4 downto 0);
	cALU_CyIn: out std_logic;
	cALU_CyOut: in std_logic;
	cALU_ZOut: in std_logic;
	
	control_signal: out std_logic_vector(24 downto 0);
	debug_stateout: out std_logic_vector(7 downto 0)
);
end cu;

architecture Behavioral of cu is
type cpu_state is (RESET, T_FETCH, T_FETCH2, T_EXEC1, T_EXEC2, T_EXEC3, T_WRBCK, T_WRBCKJ);
signal current_state, next_state : cpu_state;
signal ZF : std_logic := '0';
signal CY : std_logic := '0';
signal CY_OUT: std_logic := '0';
signal cycin : std_logic := '0';
COMPONENT CYR
	port(
		clk: in std_logic;
		cin: in std_logic;
		cyin: in std_logic;
		cyout: out std_logic
	);
end component;
type outstatetype is array(cpu_state) of std_logic_vector(7 downto 0);
constant stateout : outstatetype := ("00000001", "00000010", "00000100", "00001000",
 "00010000", "00100000", "01000000", "10000000");
begin

	cy1: CYR port map(clk, cycin, CY, CY_OUT);
	debug_stateout <= stateout(current_state);
	cALU_CyIn <= CY_OUT;
	process (rst, clk)
	begin
		if(rst = '1') then
			current_state <= RESET;
		elsif(clk'event and clk = '1') then
			if(current_state = RESET) then
				current_state <= T_FETCH;
			else
				current_state <= next_state;
			end if;
		end if;
	end process;

	process(current_state, ir_opcode, clk, ir_AD1, ir_AD2, ZF, CY)
	begin
		case current_state is
			when RESET=>
				  control_signal <= "0000111100000000000000000"; 
			when T_FETCH =>
					cycin <= '0';
					control_signal <= "0100000100010000000000000"; 
					next_state <= T_FETCH2;
			when T_FETCH2=>
					control_signal <= "0001111110001000000000000";
					next_state <= T_EXEC1;
			when T_EXEC1 =>
				case ir_opcode is
					when "00000" =>
							 --      mu		            |  IR |  PC   |  RegArr                 | ALU
					   --ai7/aib/di/do/nbh/nbl/nr/nw | i/o | i/o/s | is3/os3/i/o             | Ai/Bi/o/16
					 
						control_signal <= "00001111" & "00" & "000" & ir_AD1 & ir_AD2 & "11" & "0000"; --mov r1, r2
						next_state <= T_FETCH;
					when "00001" =>
						control_signal <= "00001111" & "01" & "000" & ir_AD1 & "00010"       & "0000"; --mov r1, INS
						next_state <= T_FETCH;
					when "00010" =>
						if(clk = '1') then
							control_signal <= "10001011" & "01" & "000" & "00000000" & "0000";          --mov [addr], r1
						else
							control_signal <= "00100010" & "00" & "000" & "000" & ir_AD1 & "01" & "0000";
						end if;
						next_state <= T_FETCH;
					when "00011" => 																				--mov r1, [addr]
						control_signal <= "10000001" & "01" & "000" & "00000000" & "0000"; 
						next_state <= T_EXEC2;
					when "00100" =>
						cALU_Card <= "00001";        														 --adc r1, r2
						control_signal <= "00001111" & "00" & "000" & "000" & ir_AD2 & "01" & "0100";
						next_state <= T_EXEC2;
					when "00101" =>
						cALU_Card <= "00001";
						control_signal <= "00001111" & "01" & "000" & "00000000" & "0100";          --adc r1, INS
						next_state <= T_EXEC2;
					when "00110" =>
						cALU_Card <= "00011";
						control_signal <= "00001111" & "00" & "000" & "000" & ir_AD2 & "01" & "0100";--sbb r1, r2
						next_state <= T_EXEC2;
					when "00111" =>
						cALU_Card <= "00011";        --sbb r1, INS
						control_signal <= "00001111" & "01" & "000" & "00000000" & "0100";
						next_state <= T_EXEC2;
					when "01000" =>
						cALU_Card <= "11011";        --and r1, r2
						control_signal <= "00001111" & "00" & "000" & "000" & ir_AD2 & "01" & "0100";
						next_state <= T_EXEC2;
					when "01001" =>
						cALU_Card <= "11011";     --and r1, INS
						control_signal <= "00001111" & "01" & "000" & "00000000" & "0100";
						next_state <= T_EXEC2;
					when "01010" =>
						cALU_Card <= "11010";     --or r1, r2
						control_signal <= "00001111" & "00" & "000" & "000" & ir_AD2 & "01" & "0100";
						next_state <= T_EXEC2;
					when "01011" =>
						cALU_Card <= "11010";       --or r1, INS
						control_signal <= "00001111" & "01" & "000" & "00000000" & "0100";
						next_state <= T_EXEC2;
					when "01100" =>
						control_signal <= "00001111" & "00" & "000" & "00000000" & "0000";
						--CY_OUT := '0';							--clc
						CY <= '0';
						cycin <= '1';
						next_state <= T_FETCH;
					when "01101" =>
						control_signal <= "00001111" & "00" & "000" & "00000000" & "0000";
						--CY_OUT := '1';							--stc
						CY <= '1';
						cycin <= '1';
						next_state <= T_FETCH;
					when "01110" =>							--jmp INS
							 --      mu		            |  IR |  PC   |  RegArr                 | ALU
					   --ai7/aib/di/do/nbh/nbl/nr/nw | i/o | i/o/s | is3/os3/i/o             | Ai/Bi/o/16
						control_signal <= "00001111" & "01" & "100" & "00000000" & "0000";
						next_state <= T_FETCH;
					when "01111" => --jz
						cALU_Card <= "00000";
						if(ZF = '0') then
							control_signal <= "00001111" & "00" & "000" & "00000000" & "0000";
							next_state <= T_FETCH;
						else
							control_signal <= "00001111" & "01" & "000" & "00000000" & "0100";
							next_state <= T_EXEC2;
						end if;
					when "10000" => --jc
						cALU_Card <= "00000";
						if(CY_OUT = '0') then
							control_signal <= "00001111" & "00" & "000" & "00000000" & "0000";
							next_state <= T_FETCH;
						else
							control_signal <= "00001111" & "01" & "000" & "00000000" & "0100";
							next_state <= T_EXEC2;
						end if;
					when "10001" => --   mov r1, [[r2]]
					
							 --      mu		            |  IR |  PC   |  RegArr                 | ALU
					   --ai7/aib/di/do/nbh/nbl/nr/nw | i/o | i/o/s | is3/os3/i/o             | Ai/Bi/o/16
						control_signal <= "10000001" & "00" & "000" & "000" & ir_AD2 &"01" & "0000"; 
						next_state <= T_EXEC2;
						
					when "10010" => -- mov r1, INS(r6)
						cALU_Card <= "00000";
						control_signal <= "00001111" & "01" & "000" & "00000000" & "0100";
						next_state <= T_EXEC2;
					when others=>
						control_signal <= "00001111" & "00" & "000" & "00000000" & "0000";
						next_state <= T_FETCH;
					end case;
				when T_EXEC2=>
					case ir_opcode is
					when "00011" => 																				--mov r1, [addr]
						control_signal <= "00011111" & "00" & "000" & ir_AD1 & "000" & "10" & "0000"; 
						next_state <= T_FETCH;
					when "00101" =>
						control_signal <= "00001111" & "00" & "000" & "000" & ir_AD1 &"01" & "1000"; --adc r1, INS
						next_state <= T_WRBCK;
					when "00100" =>
						control_signal <= "00001111" & "00" & "000" & "000" & ir_AD1 &"01" & "1000"; --adc r1, r2
						next_state <= T_WRBCK;
					when "00110" =>
						control_signal <= "00001111" & "00" & "000" & "000" & ir_AD1 &"01" & "1000"; --sbb r1, r2
						next_state <= T_WRBCK;
					when "00111" =>
						control_signal <= "00001111" & "00" & "000" & "000" & ir_AD1 &"01" & "1000"; --sbb r1, INS
						next_state <= T_WRBCK;	
					when "01000" =>
						control_signal <= "00001111" & "00" & "000" & "000" & ir_AD1 &"01" & "1000"; --and r1, r2
						next_state <= T_WRBCK;	
					when "01001" =>
						control_signal <= "00001111" & "00" & "000" & "000" & ir_AD1 &"01" & "1000"; --and r1, INS
						next_state <= T_WRBCK;	
					when "01010" =>
						control_signal <= "00001111" & "00" & "000" & "000" & ir_AD1 &"01" & "1000"; --or r1, r2
						next_state <= T_WRBCK;	
					when "01011" =>
						control_signal <= "00001111" & "00" & "000" & "000" & ir_AD1 &"01" & "1000"; --or r1, INS
						next_state <= T_WRBCK;
					
							 --      mu		            |  IR |  PC   |  RegArr                 | ALU
					   --ai7/aib/di/do/nbh/nbl/nr/nw | i/o | i/o/s | is3/os3/i/o             | Ai/Bi/o/16
					when "01111" => --jz
						control_signal <= "00001111" & "00" & "010" & "00000000" & "1000";
						next_state <= T_WRBCKJ;
					when "10000" => --jc
						control_signal <= "00001111" & "00" & "010" & "00000000" & "1000";
						next_state <= T_WRBCKJ;
					when "10001" => --   mov r1, [[r2]]
					
							 --      mu		            |  IR |  PC   |  RegArr                 | ALU
					   --ai7/aib/di/do/nbh/nbl/nr/nw | i/o | i/o/s | is3/os3/i/o             | Ai/Bi/o/16
						control_signal <= "10010001" & "00" & "000" & "00000000" & "0000"; 
						next_state <= T_EXEC3;
					when "10010" => -- mov r1, INS(r6)
						control_signal <= "00001111" & "00" & "000" & "00011001" & "1000";
						next_state <= T_EXEC3;
					when others=>
							NULL;
					end case;
				when T_EXEC3 =>
					case ir_OpCode is
						when "10001" => --mov r1, [[r2]]
							control_signal <= "00011111" & "00" & "000" & ir_AD1 & "00010" & "0000"; 
							next_state <= T_FETCH;
						when "10010" => -- mov r1, INS(r6)
							control_signal <= "10000001" & "00" & "000" & "00011000" & "0010";
							next_state <= T_WRBCK;
						when others => NULL;
					end case;
				when T_WRBCK =>
				case ir_OpCode is
					when "10010" => -- mov r1, INS(r6)
						control_signal <= "00011111" & "00" & "000" & ir_AD1 &"00010" & "0000";
						next_state <= T_FETCH;
					when others =>
						control_signal <= "00001111" & "00" & "000" & ir_AD1 & "00010" & "0010";
						--CY_OUT := cALU_CyOut;
						CY<=cALU_CyOut;
						cycin <= '1';
						ZF <= cALU_ZOut;
						next_state <= T_FETCH;
					end case;
				when T_WRBCKJ =>
					control_signal <= "00001111" & "00" & "100" & "00000000" & "0010";
					next_state <= T_FETCH;
				when others=>
						NULL;
			end case;
	end process;
end Behavioral;

