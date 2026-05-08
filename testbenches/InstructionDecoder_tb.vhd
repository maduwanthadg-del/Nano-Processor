library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.processor_components.Instruction_Decoder;


entity TB_IDecoder is
    -- port();
end TB_IDecoder;

architecture Behavioral of TB_IDecoder is

signal I: std_logic_vector(11 downto 0);
signal RCJump: std_logic_vector(3 downto 0):="0001";
signal REn: std_logic_vector(2 downto 0);
signal RSA: std_logic_vector(2 downto 0);
signal RSB: std_logic_vector(2 downto 0);
signal AS:std_logic;
signal IM: std_logic_vector(3 downto 0);
signal J: std_logic;
signal JA: std_logic_vector(2 downto 0);
signal L: std_logic; 
signal Clk: std_logic; -- Clock
begin
    UUT: Instruction_Decoder port map(
        Instruction => I,
        Jump_register_value => RCJump,
        Register_enable => REn,
        Register_Select_A => RSA,
        Register_Select_B => RSB,
        Operation => AS,
        Immediate_value => IM,
        Jump_flag => J,
        Jump_address => JA,
        Load_select => L
    );

    clock: process
    begin
        Clk <= '1';
        wait for 50ns;
        Clk <= '0';
        wait for 50ns;
    end process clock;

    stim: process
    begin
        I <= "101010001111"; --MOVI 5, 15
        wait for 100ns;
        I <= "001111000000"; --ADD 7, 4
        wait for 100ns; 
        I <= "011100000000"; -- NEG 6
        wait for 100ns;
        I <= "110110000010"; -- JZR 3, 2
        wait for 100ns;
        RCJump <= "0000";
        I <= "110110000010"; -- JZR 3, 2
        wait for 100ns;
    end process stim;
        
end Behavioral;