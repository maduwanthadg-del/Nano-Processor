library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder3to8 is
    Port (
        En : in  STD_LOGIC;
        A  : in  STD_LOGIC_VECTOR(2 downto 0);
        Y  : out STD_LOGIC_VECTOR(7 downto 0)
    );
end Decoder3to8;

architecture Behavioral of Decoder3to8 is
begin
    process(En, A)
    begin
        Y <= "00000000";
        if En = '1' then
            case A is
                when "000" => Y <= "00000001";
                when "001" => Y <= "00000010";
                when "010" => Y <= "00000100";
                when "011" => Y <= "00001000";
                when "100" => Y <= "00010000";
                when "101" => Y <= "00100000";
                when "110" => Y <= "01000000";
                when "111" => Y <= "10000000";
                when others => Y <= "00000000";
            end case;
        end if;
    end process;
end Behavioral;