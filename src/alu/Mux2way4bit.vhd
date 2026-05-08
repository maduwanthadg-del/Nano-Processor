

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.data_bus;


entity MUX_2_4 is
    Port ( D0 : in data_bus;
           D1 : in data_bus;
           S : in STD_LOGIC;
           D_out : out data_bus);
end MUX_2_4;

architecture Behavioral of MUX_2_4 is

begin

process(D0, D1, S)
begin
    if (S ='0') then
        D_out <= D0;   
    else
        D_out <= D1;
    end if;
end process;


end Behavioral;
