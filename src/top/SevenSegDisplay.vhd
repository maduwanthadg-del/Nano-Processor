library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity LUT_16_7 is
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (6 downto 0));
end LUT_16_7;

architecture Behavioral of LUT_16_7 is

    type rom_type is array (0 to 15) of std_logic_vector (6 downto 0);
    
        signal sevenSegment_ROM : rom_type := (
        "1000000", -- 0: segments a,b,c,d,e,f (active low)
        "1111001", -- 1: segments b,c
        "0100100", -- 2: segments a,b,d,e,g
        "0110000", -- 3: segments a,b,c,d,g
        "0011001", -- 4: segments b,c,f,g
        "0010010", -- 5: segments a,c,d,f,g
        "0000010", -- 6: segments a,c,d,e,f,g
        "1111000", -- 7: segments a,b,c
        "0000000", -- 8: all segments on
        "0010000", -- 9: segments a,b,c,d,f,g
        "0001000", -- A
        "0000011", -- b
        "1000110", -- C
        "0100001", -- d
        "0000110", -- E
        "0001110"  -- F
    );

            
begin

    -- Decode the 4-bit address into a 7-segment display pattern
    data <= sevenSegment_Rom(to_integer(unsigned(address)));



end Behavioral;