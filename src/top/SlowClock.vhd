library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SlowClock is
    Generic (
        DIVIDER : integer := 5
    );
    Port (
        Clk_in  : in  STD_LOGIC;
        Clk_out : out STD_LOGIC
    );
end SlowClock;

architecture Behavioral of SlowClock is
    signal count   : integer range 0 to 200000000 := 0;
    signal clk_reg : STD_LOGIC := '0';
begin
    process(Clk_in)
    begin
        if rising_edge(Clk_in) then
            if count = DIVIDER - 1 then
                count   <= 0;
                clk_reg <= NOT clk_reg;
            else
                count <= count + 1;
            end if;
        end if;
    end process;
    Clk_out <= clk_reg;
end Behavioral;