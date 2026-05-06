library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Adder_3 is
    Port (
        in_value  : in STD_LOGIC_VECTOR(2 downto 0);
        out_value : out STD_LOGIC_VECTOR(2 downto 0)
    );
end Adder_3;

architecture Behavioral of Adder_3 is
begin
    out_value <= std_logic_vector(unsigned(in_value) + 1);
end Behavioral;