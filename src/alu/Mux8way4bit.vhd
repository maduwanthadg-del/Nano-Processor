library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Mux8way4bit is
    Port (
        D0, D1, D2, D3,
        D4, D5, D6, D7 : in  STD_LOGIC_VECTOR(3 downto 0);
        Sel             : in  STD_LOGIC_VECTOR(2 downto 0);
        Y               : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Mux8way4bit;

architecture Behavioral of Mux8way4bit is
begin
    with Sel select
        Y <= D0 when "000",
             D1 when "001",
             D2 when "010",
             D3 when "011",
             D4 when "100",
             D5 when "101",
             D6 when "110",
             D7 when "111",
             "0000" when others;
end Behavioral;
