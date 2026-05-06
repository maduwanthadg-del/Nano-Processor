
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Instruction_decoder is
	port (
		Instruction_bus : in STD_LOGIC_VECTOR (11 downto 0);
		Jump_Check : in STD_LOGIC_VECTOR (3 downto 0);
		Immediate_val : out STD_LOGIC_VECTOR (3 downto 0);
		Load_sel : out STD_LOGIC;
		Add_sub_sel : out STD_LOGIC;
		Reg_Sel_A : out STD_LOGIC_VECTOR (2 downto 0);
		Reg_Sel_B : out STD_LOGIC_VECTOR (2 downto 0);
		Reg_en : out STD_LOGIC_VECTOR (2 downto 0);
		Jmp_flag : out STD_LOGIC;
		Jmp_Addr : out STD_LOGIC_VECTOR (2 downto 0)
	);
end Instruction_decoder;

architecture Behavioral of Instruction_decoder is

	component Decoder_2_to_4
		port (
			I : in std_logic_vector (1 downto 0);
			En : in std_logic;
			Y : out std_logic_vector (3 downto 0)
		);
	end component;
 
	signal ADD, NEG, MOVI, JZR : std_logic;
 
 

begin
   
	Decoder : Decoder_2_to_4
	port map(
		I => Instruction_bus(11 downto 10), 
		En => '1', 
		Y(0) => ADD, 
		Y(1) => NEG, 
		Y(2) => MOVI, 
		Y(3) => JZR
	);
 
 
	Load_sel <= MOVI;
	Add_sub_sel <= NEG;
	Reg_Sel_B <= Instruction_bus (9 downto 7);
	Reg_Sel_A <= Instruction_bus (6 downto 4);
	Reg_en <= Instruction_bus (9 downto 7);
	Immediate_val <= Instruction_bus (3 downto 0);
	Jmp_flag <= JZR AND (NOT(Jump_check(0) or Jump_check(1) or Jump_check(2) or Jump_check(3)));
	Jmp_Addr <= Instruction_bus (2 downto 0);
 
 
 
 
end Behavioral;