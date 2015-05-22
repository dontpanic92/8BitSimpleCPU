LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.std_logic_arith.ALL; 
entity CPU is  
port(
	RST: in std_logic;
	CLK: in std_logic;
	ABUS: out std_logic_vector(15 downto 0);
	DBUS: inout std_logic_vector(15 downto 0);
	nMREQ: out std_logic;
	nRD: out std_logic;
	nWR: out std_logic;
	nBHE: out std_logic;
	nBLE: out std_logic;
	sir: out std_logic_vector(15 downto 0);
	pcout: out std_logic_vector(15 downto 0);
	stateout: out std_logic_vector(7 downto 0);
	sDBUS: out std_logic_vector(15 downto 0);
	sABUS: out std_logic_vector(15 downto 0);
	
	snbh : out std_logic;
	snbl : out std_logic;
	snm : out std_logic;
	snr: out std_logic;
	snw: out std_logic

);
end CPU; 

architecture arch of CPU is

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
         control_signal : OUT  std_logic_vector(24 downto 0);
			debug_stateout: out std_logic_vector(7 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT signalout
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
	 END COMPONENT;
	 
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
	 
	 COMPONENT ir
    PORT(
			clk : in std_logic;
         DataInOut : INOUT  std_logic_vector(15 downto 0);
         cout : IN  std_logic;
         cin : IN  std_logic;
         OpOut : OUT  std_logic_vector(4 downto 0);
         AD1Out : OUT  std_logic_vector(2 downto 0);
         AD2Out : OUT  std_logic_vector(2 downto 0);
         rst : IN  std_logic;
			debug_irout: out std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT MemUnit
    PORT(
		clk: in std_logic;
         DataInOut : INOUT  std_logic_vector(15 downto 0);
         DataR7 : IN  std_logic_vector(7 downto 0);
         cMARinBus : IN  std_logic;
         cMARinR7 : IN  std_logic;
         cMDRin : IN  std_logic;
         cMDRout : IN  std_logic;
         cnRD : IN  std_logic;
         cnWR : IN  std_logic;
         cnBHE: in std_logic;
			cnBLE: in std_logic;
         ABus : OUT  std_logic_vector(15 downto 0);
         DBus : INOUT  std_logic_vector(15 downto 0);
         nRD : OUT  std_logic;
         nWR : OUT  std_logic;
         nBHE : OUT  std_logic;
         nBLE : OUT  std_logic
        );
    END COMPONENT;
	 
	 COMPONENT pc
    PORT(
			clk: in std_logic;
         rst : IN  std_logic;
         cin : IN  std_logic;
         cout : IN  std_logic;
         step : IN  std_logic;
			ADDRFromR7: in std_logic_vector(7 downto 0);
         DataInOut : INOUT  std_logic_vector(15 downto 0);
			debug_pcout: out std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT RegArr
    PORT(
			clk : in std_logic;
         DataInOut : INOUT  std_logic_vector(15 downto 0);
         R7Out : OUT  std_logic_vector(7 downto 0);
         isel : IN  std_logic_vector(2 downto 0);
			osel : IN std_logic_vector(2 downto 0);
         cin : IN  std_logic;
         cout : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
	 
	 
	 signal inner_dbus: std_logic_vector(15 downto 0);
	 
	 signal cu_ir_opcode: std_logic_vector(4 downto 0);
	 signal cu_ir_AD1: std_logic_vector(2 downto 0);
	 signal cu_ir_AD2: std_logic_vector(2 downto 0);
	 
	 signal cu_ALU_Card: std_logic_vector(4 downto 0);
	 signal cu_ALU_CyIn: std_logic;
	 signal cu_ALU_CyOut: std_logic;
	 signal cu_ALU_ZOut: std_logic;
	 
	 signal cu_so_control: std_logic_vector(24 downto 0);
	 
	 signal so_MemUnit_AinFromR7: std_logic;
	 signal so_MemUnit_AinFromBus: std_logic;
	 signal so_MemUnit_Din: std_logic;
	 signal so_MemUnit_Dout: std_logic;
	 signal so_MemUnit_nBHE: std_logic;
	 signal so_MemUnit_nBLE: std_logic;
	 signal so_MemUnit_nRD: std_logic;
    signal so_MemUnit_nWR: std_logic;
	
    signal so_Ir_in: std_logic;
    signal so_Ir_out: std_logic;
	
	 signal so_Pc_in: std_logic;
	 signal so_Pc_out: std_logic;
	 signal so_Pc_step: std_logic;
	
	 signal so_RegArr_isel: std_logic_vector(2 downto 0);
	 signal so_RegArr_osel: std_logic_vector(2 downto 0);
	 signal so_RegArr_in: std_logic;
	 signal so_RegArr_out: std_logic;
	
	 signal so_ALU_Ain: std_logic;
	 signal so_ALU_Bin: std_logic;
	 signal so_ALU_Out: std_logic;
	 signal so_ALU_16Bit: std_logic;
	 
	 signal mu_ra_R7: std_logic_vector(7 downto 0);
	 
	 signal tmpABUS: std_logic_vector(15 downto 0);
	 signal tmpnbh : std_logic;
	 signal tmpnbl : std_logic;
	 signal tmpnr: std_logic;
	 signal tmpnw: std_logic;
	 
begin
	nMREQ <= '0';
	snm <= '0';
	sDBUS <= DBUS;
	ABUS <= tmpABUS;
	sABUS <= tmpABUS;
	nBHE <= tmpnbh;
	snbh <= tmpnbh;
	nBLE <= tmpnbl;
	snbl <= tmpnbl;
	nRD <= tmpnr;
	snr <= tmpnr;
	nWR <= tmpnw;
	snw <= tmpnw;
	
	cu1: cu port map(
							rst => RST, 
							clk=>CLK, 
							ir_opcode => cu_ir_opcode,
							ir_AD1 => cu_ir_AD1,
							ir_AD2 => cu_ir_AD2,
							cALU_Card => cu_ALU_Card,
							cALU_CyIn => cu_ALU_CyIn,
							cALU_CyOut => cu_ALU_CyOut,
							cALU_ZOut => cu_ALU_ZOut,
							control_signal => cu_so_control,
							debug_stateout => stateout
							);
	
	so1: signalout port map(
							cMemUnit_AinFromR7 => so_MemUnit_AinFromR7,
							cMemUnit_AinFromBus => so_MemUnit_AinFromBus,
							cMemUnit_Din => so_MemUnit_Din,
							cMemUnit_Dout => so_MemUnit_Dout,
							cMemUnit_nBHE => so_MemUnit_nBHE,
							cMemUnit_nBLE => so_MemUnit_nBLE,
							cMemUnit_nRD => so_MemUnit_nRD,
							cMemUnit_nWR => so_MemUnit_nWR,
							
							cIr_in => so_Ir_in,
							cIr_out => so_Ir_out,
							
							cPc_in => so_Pc_in,
							cPc_out => so_Pc_out,
							cPc_step => so_Pc_step,
							
							cRegArr_isel => so_RegArr_isel,
							cRegArr_osel => so_RegArr_osel,
							cRegArr_in => so_RegArr_in,
							cRegArr_out => so_RegArr_out,
							
							cALU_Ain => so_ALU_Ain,
							cALU_Bin => so_ALU_Bin,
							cALU_Out => so_ALU_Out,
							cALU_16Bit => so_ALU_16Bit,
							
							control_signal => cu_so_control
							);
	
	alu1 : ALU port map(
							clk => CLK,
							DataInOut => inner_dbus,
							cSetA => so_ALU_Ain,
							cSetB => so_ALU_Bin,
							cOut => so_ALU_Out,
							c16Bit => so_ALU_16Bit,
							CyIn => cu_ALU_CyIn,
							CyOut => cu_ALU_CyOut,
							ZOut => cu_ALU_ZOut,
							Card => cu_ALU_Card
							);
	pc1 : pc port map(
							clk => CLK,
							rst => RST,
							ADDRFromR7 => mu_ra_R7,
							cin => so_Pc_in,
							cout => so_Pc_out,
							step => so_Pc_step,
							DataInOut => inner_dbus,
							debug_pcout => pcout
							);
							
	ir1 : ir port map(
							clk => CLK,
							rst => RST,
							cout => so_ir_out,
							cin => so_ir_in,
							OpOut => cu_ir_opcode,
							AD1Out => cu_ir_AD1,
							AD2Out => cu_ir_AD2,
							DataInOut => inner_dbus,
							debug_irout => sir
							);
	regarr1 : regarr port map(
							clk => CLK,
							DataInOut => inner_dbus,
							R7Out => mu_ra_R7,
							isel => so_RegArr_isel,
							osel => so_RegArr_osel,
							cin => so_RegArr_in,
							cout => so_RegArr_out,
							rst => RST
							);
	memunit1 : memunit port map(
							clk => CLK,
							DataInOut => inner_dbus,
							DataR7 => mu_ra_R7,
							cMARinBus => so_MemUnit_AinFromBus,
							cMARinR7 => so_MemUnit_AinFromR7,
							cMDRin => so_MemUnit_Din,
							cMDRout => so_MemUnit_Dout,
							cnRD => so_MemUnit_nRD,
							cnWR => so_MemUnit_nWR,
							cnBHE => so_MemUnit_nBHE,
							cnBLE => so_MemUnit_nBLE,
							
							ABus => tmpABUS,
							DBus => DBUS,
							nRD => tmpnr,
							nWR => tmpnw,
							nBHE => tmpnbh,
							nBLE => tmpnbl
							);
end arch;