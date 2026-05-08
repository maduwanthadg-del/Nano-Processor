library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.all;

entity MUX_8_4 is
    Port (
        S : in bus_3_bit;
        D : in data_buses;
        Y : out bus_4_bit
    );
end MUX_8_4;

architecture Behavioral of MUX_8_4 is
begin
    process(S, D)
    begin
        case S is
            when "000" => Y <= D(0);
            when "001" => Y <= D(1);
            when "010" => Y <= D(2);
            when "011" => Y <= D(3);
            when "100" => Y <= D(4);
            when "101" => Y <= D(5);
            when "110" => Y <= D(6);
            when "111" => Y <= D(7);
            when others => Y <= (others => '0');
        end case;
    end process;
end Behavioral;
