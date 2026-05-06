library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2_way_3_Bit is
    Port ( D0 : in STD_LOGIC_VECTOR (2 downto 0);
           D1 : in STD_LOGIC_VECTOR (2 downto 0);
           S : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (2 downto 0));
end MUX_2_way_3_Bit;

architecture Behavioral of MUX_2_way_3_Bit is

begin
    Y <= D0 when (S = '0') else
         D1 when (S = '1');
         
end Behavioral;