library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegisterBank_tb is
end RegisterBank_tb;

architecture Behavioral of RegisterBank_tb is
    component RegisterBank
        Port (Clk, Reset : in STD_LOGIC;
              RegEn  : in STD_LOGIC_VECTOR(7 downto 0);
              DataIn : in STD_LOGIC_VECTOR(3 downto 0);
              R0out, R1out, R2out, R3out,
              R4out, R5out, R6out, R7out : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    signal Clk, Reset : STD_LOGIC := '0';
    signal RegEn   : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal DataIn  : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal R0out, R1out, R2out, R3out : STD_LOGIC_VECTOR(3 downto 0);
    signal R4out, R5out, R6out, R7out : STD_LOGIC_VECTOR(3 downto 0);
begin
    UUT: RegisterBank port map (
        Clk=>Clk, Reset=>Reset, RegEn=>RegEn, DataIn=>DataIn,
        R0out=>R0out, R1out=>R1out, R2out=>R2out, R3out=>R3out,
        R4out=>R4out, R5out=>R5out, R6out=>R6out, R7out=>R7out);

    Clk <= NOT Clk after 10 ns;

    process
    begin
        -- Apply reset
        Reset <= '1'; wait for 20 ns;
        Reset <= '0';
        -- Write 6 (0110) into R7
        DataIn <= "0110"; RegEn <= "10000000"; wait for 20 ns;
        RegEn <= "00000000"; wait for 20 ns;
        -- Write 1 (0001) into R1
        DataIn <= "0001"; RegEn <= "00000010"; wait for 20 ns;
        RegEn <= "00000000"; wait for 20 ns;
        -- Try to write 1111 into R0 -- R0out must stay 0000
        DataIn <= "1111"; RegEn <= "00000001"; wait for 20 ns;
        RegEn <= "00000000"; wait for 20 ns;
        -- R0out should still be 0000
        wait;
    end process;
end Behavioral;