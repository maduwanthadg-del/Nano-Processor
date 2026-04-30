library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Nanoprocessor_tb is
end Nanoprocessor_tb;

architecture Behavioral of Nanoprocessor_tb is
    component Nanoprocessor
        Port (Clk_100MHz : in STD_LOGIC;
              Reset : in STD_LOGIC;
              LED : out STD_LOGIC_VECTOR(15 downto 0);
              Seg : out STD_LOGIC_VECTOR(6 downto 0);
              AN  : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    signal Clk   : STD_LOGIC := '0';
    signal Reset : STD_LOGIC := '1';
    signal LED   : STD_LOGIC_VECTOR(15 downto 0);
    signal Seg   : STD_LOGIC_VECTOR(6 downto 0);
    signal AN    : STD_LOGIC_VECTOR(3 downto 0);
begin
    UUT: Nanoprocessor port map (
        Clk_100MHz => Clk, Reset => Reset,
        LED => LED, Seg => Seg, AN => AN);

    -- 100 MHz clock
    Clk <= NOT Clk after 5 ns;

    process
    begin
        Reset <= '1';
        wait for 200 ns;
        Reset <= '0';
        -- With DIVIDER=5: slow_clk toggles every 50ns -> period = 100ns
        -- 8 instructions * 100ns + margin = 1500ns
        wait for 1500 ns;
        -- LED(3:0) should now show "0110" (= decimal 6)
        -- Verify in waveform viewer
        wait;
    end process;
end Behavioral;