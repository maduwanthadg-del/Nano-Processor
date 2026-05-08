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
        "101110000001", -- 0: MOVI R7, 1 (Load 1 into Register 7)
        "100010000000", -- 1: MOVI R1, 0 (Load 0 into Register 1)
        "001110010000", -- 2: ADD R7, R1 (Add R1 to R7, store in R7)
        "100010000010", -- 3: MOVI R1, 2 (Load 2 into Register 1)
        "001110010000", -- 4: ADD R7, R1 (Add R1 to R7, store in R7)
        "100010000011", -- 5: MOVI R1, 3 (Load 3 into Register 1)
        "001110010000", -- 6: ADD R7, R1 (Add R1 to R7, store in R7)
        "110000000111"  -- 7: JZR R0, 7  (Jump to Instruction 7 if R0 is 0 - Infinite Loop/Halt)
    );




 

begin
	Instruction <= default_rom(to_integer(unsigned(address)));
end Behavioral;