library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Mux2way4bit is
    Port (
        D0  : in  STD_LOGIC_VECTOR(3 downto 0);
        D1  : in  STD_LOGIC_VECTOR(3 downto 0);
        Sel : in  STD_LOGIC;
        Y   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Mux2way4bit;

architecture Behavioral of Mux2way4bit is
begin
    Y <= D0 when Sel = '0' else D1;
end Behavioral;
