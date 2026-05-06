library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Program_counter is
    Port ( Reset   : in  STD_LOGIC;
           Clk     : in  STD_LOGIC;
           PC_in   : in  STD_LOGIC_VECTOR (2 downto 0);
           PC_out  : out STD_LOGIC_VECTOR (2 downto 0));
end Program_counter;

architecture Behavioral of Program_counter is
    signal PC_reg : STD_LOGIC_VECTOR(2 downto 0);
begin

    process(Clk)
    begin
        if rising_edge(Clk) then
            if Reset = '1' then
                PC_reg <= "000";
            else
                PC_reg <= PC_in;
            end if;
        end if;
    end process;

    PC_out <= PC_reg;

end Behavioral;