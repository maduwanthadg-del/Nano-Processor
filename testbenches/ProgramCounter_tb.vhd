library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_PC is
end TB_PC;

architecture Behavioral of TB_PC is

component Program_counter is
    port ( PC_in : in STD_LOGIC_VECTOR(2 downto 0);
    Reset : in STD_LOGIC;
    Clk : in STD_LOGIC;
    PC_out : out STD_LOGIC_VECTOR(2 downto 0));
end component;

signal A : STD_LOGIC_VECTOR(2 downto 0);
signal Res : STD_LOGIC;
signal Clk : STD_LOGIC;
signal M : STD_LOGIC_VECTOR(2 downto 0);

constant clk_period : time := 10 ns;

begin

    uut : Program_counter  port map (
        PC_in => A, 
        Reset => Res, 
        Clk => Clk, 
        PC_Out => M);

    clock: process
    begin
        Clk <= '0';
        wait for clk_period/2;
        Clk <= '1';
        wait for clk_period/2;
    end process;
      
    stim: process
    begin
        Res <= '1';
        wait for clk_period/2;
        Res <= '0';
        A <= "010";
        wait for clk_period;
        A <= "001";
        wait for clk_period;
        A <= "000";
        wait for clk_period;
        A <= "100";
        wait for clk_period;
        A <= "111";
        wait for clk_period;
        Res <= '1';
        wait;
    end process;
end Behavioral;
