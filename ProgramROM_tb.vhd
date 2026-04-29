library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProgramROM_tb is
end ProgramROM_tb;

architecture Behavioral of ProgramROM_tb is
    component ProgramROM
        Port (Addr : in STD_LOGIC_VECTOR(2 downto 0);
              Data : out STD_LOGIC_VECTOR(11 downto 0));
    end component;
    signal Addr : STD_LOGIC_VECTOR(2 downto 0);
    signal Data : STD_LOGIC_VECTOR(11 downto 0);
begin
    UUT: ProgramROM port map (Addr=>Addr, Data=>Data);
    process
    begin
        Addr <= "000"; wait for 10 ns;  -- Expect 100010000001
        Addr <= "001"; wait for 10 ns;  -- Expect 100100000010
        Addr <= "010"; wait for 10 ns;  -- Expect 100110000011
        Addr <= "011"; wait for 10 ns;  -- Expect 000010100000
        Addr <= "100"; wait for 10 ns;  -- Expect 000010110000
        Addr <= "101"; wait for 10 ns;  -- Expect 101110000000
        Addr <= "110"; wait for 10 ns;  -- Expect 000111001000
        Addr <= "111"; wait for 10 ns;  -- Expect 110000000111
        wait;
    end process;
end Behavioral;