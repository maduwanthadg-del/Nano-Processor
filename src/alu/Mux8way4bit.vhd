library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_8_way_4_Bit is
    Port ( S : in STD_LOGIC_VECTOR (2 downto 0);
           D0 : in STD_LOGIC_VECTOR (3 downto 0);
           D1 : in STD_LOGIC_VECTOR (3 downto 0);
           D2 : in STD_LOGIC_VECTOR (3 downto 0);
           D3 : in STD_LOGIC_VECTOR (3 downto 0);
           D4 : in STD_LOGIC_VECTOR (3 downto 0);
           D5 : in STD_LOGIC_VECTOR (3 downto 0);
           D6 : in STD_LOGIC_VECTOR (3 downto 0);
           D7 : in STD_LOGIC_VECTOR (3 downto 0);
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end MUX_8_way_4_Bit;

architecture Behavioral of MUX_8_way_4_Bit is

begin
    Y <= D0 when (S = "000") else
         D1 when (S = "001") else
         D2 when (S = "010") else
         D3 when (S = "011") else
         D4 when (S = "100") else
         D5 when (S = "101") else
         D6 when (S = "110") else
         D7 when (S = "111") else
         (others => '0');
         
end Behavioral;
