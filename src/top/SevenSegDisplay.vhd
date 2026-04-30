library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SevenSegDisplay is
    Port (
        Num : in  STD_LOGIC_VECTOR(3 downto 0);
        Seg : out STD_LOGIC_VECTOR(6 downto 0);
        AN  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end SevenSegDisplay;

architecture Behavioral of SevenSegDisplay is
begin
    -- Enable only the rightmost digit, disable the others
    AN <= "1110";

    process(Num)
    begin
        case Num is
            --              GFEDCBA
            when "0000" => Seg <= "1000000";  -- 0
            when "0001" => Seg <= "1111001";  -- 1
            when "0010" => Seg <= "0100100";  -- 2
            when "0011" => Seg <= "0110000";  -- 3
            when "0100" => Seg <= "0011001";  -- 4
            when "0101" => Seg <= "0010010";  -- 5
            when "0110" => Seg <= "0000010";  -- 6
            when "0111" => Seg <= "1111000";  -- 7
            when "1000" => Seg <= "0000000";  -- 8
            when "1001" => Seg <= "0010000";  -- 9
            when "1010" => Seg <= "0001000";  -- A
            when "1011" => Seg <= "0000011";  -- b
            when "1100" => Seg <= "1000110";  -- C
            when "1101" => Seg <= "0100001";  -- d
            when "1110" => Seg <= "0000110";  -- E
            when "1111" => Seg <= "0001110";  -- F
            when others => Seg <= "1111111";  -- All off
        end case;
    end process;
end Behavioral;