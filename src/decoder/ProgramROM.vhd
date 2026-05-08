library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.buses.all; 
use work.buses.instruction_address;



entity Program_ROM is
    port(ROM_address : in instruction_address;
         I: out instruction_bus
         ); 

end Program_ROM;

architecture Behavioral of Program_ROM is

type rom_type is array (0 to 7) of instruction_bus;

    signal add_1_to_3 : rom_type := (
    "1110000000000",
    "1001110000000",
    "1110000000000",
    "1001100000000",
    "0001111100000",
    "1110000000000",
    "0110000000000",
    "0000000000000"





    );
        
begin
    I <= add_1_to_3(to_integer(unsigned(ROM_address)));
end Behavioral;