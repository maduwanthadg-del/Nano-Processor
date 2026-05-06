library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Program_ROM is
end TB_Program_ROM;

architecture Behavioral of TB_Program_ROM is
    component Program_ROM
        port (
            address: in std_logic_vector (2 downto 0);
            instruction: out std_logic_vector ( 11 downto 0));
   end component;
   
   
    component PC_System 
            Port ( reset : in STD_LOGIC;
                   clk : in STD_LOGIC;
                   jmp_addr : in STD_LOGIC_VECTOR (2 downto 0);
                   jmp_flag : in STD_LOGIC;
                   out_addr : out STD_LOGIC_VECTOR (2 downto 0));
    end component;
   
   signal address, jmp_address: std_logic_vector (2 downto 0):="000";
   signal instruction: std_logic_vector (11 downto 0);
   signal reset, clk, jmp_flag : std_logic := '0';
   
   
   
begin


PC_System_0 : PC_System
    port map (
        reset => reset,
        clk => clk,
        jmp_addr => jmp_address,
        jmp_flag => jmp_flag,
        out_addr => address );

UUT : Program_ROM
    port map (
        address => address,
        instruction => instruction);
        
 clk_process: process
 begin
    clk <= not clk;
    wait for 10ns;
 end process;
        
        
 sim_process : process
 begin
    reset <= '1';
    wait for 100ns;
    reset <= '0';
    wait for 250ns;
    
    
    reset <= '1';
    wait for 50ns;
    reset <= '0';
    
    wait;
end process;
    


end Behavioral;