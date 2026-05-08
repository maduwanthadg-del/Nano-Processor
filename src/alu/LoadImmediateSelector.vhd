

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.data_bus;


entity Load_Immediate_Selector is
      Port (
          ALU_value : in data_bus;
          immediate_value : in data_bus;
          Load_select: in std_logic;
          Out_value: out data_bus );
end Load_Immediate_Selector;

architecture Behavioral of Load_Immediate_Selector is

begin


    MUX : entity work.MUX_2_4
        port map (
            D0 => ALU_value,
            D1 => immediate_value,
            S  => Load_select,
            D_out  => Out_value);


end Behavioral;
