

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.instruction_address;


entity jump_pc_selector is
      Port ( 
        program_counter_address: in instruction_address;
        jump_address : in instruction_address;
        jump_flag : in std_logic;
        jump_pc_selector_out: out instruction_address);
end jump_pc_selector;

architecture Behavioral of jump_pc_selector is

begin

    MUX : entity work.MUX_2_3 
        port map (
            D0 => program_counter_address,
            D1 => jump_address,
            S => jump_flag,
            Y => jump_pc_selector_out);


end Behavioral;
