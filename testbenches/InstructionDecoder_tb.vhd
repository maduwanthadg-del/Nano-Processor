library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Instruction_Decoder is
end TB_Instruction_Decoder;

architecture Behavioral of TB_Instruction_Decoder is

    component Instruction_Decoder
        port (
            Instruction_bus : in STD_LOGIC_VECTOR (11 downto 0);
                   Jmp_check_flags : in STD_LOGIC_VECTOR (3 downto 0);
                   Immediate_val : out STD_LOGIC_VECTOR (3 downto 0);
                   Load_sel : out STD_LOGIC;
                   Add_sub_sel : out STD_LOGIC;
                   Reg_Sel_A : out STD_LOGIC_VECTOR (2 downto 0);
                   Reg_Sel_B : out STD_LOGIC_VECTOR (2 downto 0);
                   Reg_en : out STD_LOGIC_VECTOR (2 downto 0);
                   Jmp_flag : out STD_LOGIC;
                   Jmp_Addr : out STD_LOGIC_VECTOR (2 downto 0));
        end component;
   
   
        component PC_System 
               Port ( reset : in STD_LOGIC;
                      clk : in STD_LOGIC;
                      jmp_addr : in STD_LOGIC_VECTOR (2 downto 0);
                      jmp_flag : in STD_LOGIC;
                      out_addr : out STD_LOGIC_VECTOR (2 downto 0));
       end component;
       
       
       component Program_ROM
               port (
                   address: in std_logic_vector (2 downto 0);
                   instruction: out std_logic_vector ( 11 downto 0));
        end component;
            
   
   signal load_sel, add_sub_sel, jmp, reset, clk  : std_logic := '0';
   signal regsela, regselb, regen, jmp_addr, pc_out: std_logic_vector (2 downto 0);
   signal instruction : std_logic_vector (11 downto 0);
   signal immediate_val : std_logic_vector (3 downto 0);
   
   
   

begin

PC_System_0 : PC_System
    port map (
        reset => reset,
        clk => clk,
        jmp_addr => jmp_addr,
        jmp_flag => jmp,
        out_addr => pc_out );
        
        
        PROM : Program_ROM
            port map (
                address => pc_out,
                instruction => instruction);
                
                
         clk_process: process
                begin
                   clk <= not clk;
                   wait for 50ns;
                end process;
        
        
   

    UUT : Instruction_Decoder
       port map (
            Instruction_bus => instruction,
            jmp_check_flags => "1111",
            Load_sel => load_sel,
            Add_sub_sel => Add_sub_sel,
            Reg_sel_a => regsela,
            Reg_sel_b => regselb,
            reg_en => regen,
            jmp_flag => jmp,
            jmp_addr => jmp_addr,
            immediate_val => immediate_val);
            
    
            
           
            

end Behavioral;