library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.buses.instruction_address;

entity program_counter_incrementor is   
    Port (
        in_address       : in  instruction_address;
        increment_enable : in  std_logic;
        out_address      : out instruction_address
    );
end program_counter_incrementor;

architecture Behavioral of program_counter_incrementor is
begin
    process(in_address, increment_enable)
        variable temp : unsigned(2 downto 0);
    begin
        if increment_enable = '1' then
            temp := unsigned(in_address) + 1;
        else
            temp := unsigned(in_address);  -- Hold the current address
        end if;
        out_address <= std_logic_vector(temp);
    end process;
end Behavioral;
