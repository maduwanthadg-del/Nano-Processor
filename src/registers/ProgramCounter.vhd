library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.instruction_address;

entity Program_counter is
    Port (
        Reset   : in  STD_LOGIC;
        Clk     : in  STD_LOGIC;
        PC_in   : in  instruction_address;
        PC_out  : out instruction_address
    );
end Program_counter;

architecture Behavioral of Program_counter is
    signal PC_reg : instruction_address;
begin

    process(Clk, Reset)  -- Reset added to sensitivity list
    begin
        if Reset = '1' then
            PC_reg <= "000";  -- Asynchronous reset
        elsif rising_edge(Clk) then
            PC_reg <= PC_in;
        end if;
    end process;

    PC_out <= PC_reg;

end Behavioral;
