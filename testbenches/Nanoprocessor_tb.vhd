library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_processor is
end TB_processor;

architecture Behavioral of TB_processor is

    component  processor
    Port ( Reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC;
           led : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           Anode : out STD_LOGIC_VECTOR (3 downto 0));
                    
    end component; 



signal reset, clk, overflow, zero, sign : std_logic := '0';
signal led_out, anode : std_logic_vector (3 downto 0) := "0000";
signal Disp_out: std_logic_vector (6 downto 0);
signal ins: std_logic_vector (11 downto 0);
 signal q0, q1, q2, q3, q4, q5, q6, q7 : std_logic_vector (3 downto 0);

begin

    clock_process: process
    begin
        clk <= not clk;
        wait for 5ns;
    end process;
    
    UUT: processor
    port map (
        Reset => reset,
        Clk => clk,
        Overflow => overflow,
        Zero => zero,
        led => led_out,
        seg => disp_out,
        Anode => anode
   );
        
        
    sim_process : process
    begin
        reset <= '1';
        wait for 10ns;
        reset <= '0';
        wait;
        
        
   end process;




end Behavioral;