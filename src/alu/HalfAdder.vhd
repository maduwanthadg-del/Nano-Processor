

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity HA is
   Port (
        A : in std_logic;
        B : in std_logic;
        S : out std_logic;
        C : out std_logic );
end HA;

architecture Behavioral of HA is

begin

    S <= A XOR B;
    C <= A AND B;


end Behavioral;
