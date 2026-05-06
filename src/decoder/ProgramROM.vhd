library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Program_ROM is
	port (
		address : in STD_LOGIC_VECTOR (2 downto 0);
		instruction : out STD_LOGIC_VECTOR (11 downto 0)
	);
end Program_ROM;

architecture Behavioral of Program_ROM is
	type rom_type is array (0 to 7) of std_logic_vector(11 downto 0);
signal default_rom : rom_type := (
        "101110000001",
        "100010000000",
        "001110010000",
        "100010000010",
        "001110010000",
        "100010000011",
        "001110010000",
        "110000000111"
    );




 

begin
	Instruction <= default_rom(to_integer(unsigned(address)));
end Behavioral;