

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.bus_3_bit;


entity MUX_2_3 is
    Port ( D0 : in bus_3_bit;
           D1 : in bus_3_bit;
           S : in STD_LOGIC;
           Y : out bus_3_bit);
end MUX_2_3;

architecture Behavioral of MUX_2_3 is

begin
    Y <= D0 when (S = '0') else
         D1 when (S = '1');
         
end Behavioral;
