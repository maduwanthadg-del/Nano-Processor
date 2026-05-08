library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_3_4 is
    Port (
        A : in std_logic_vector(3 downto 0);  -- Input 0
        B : in std_logic_vector(3 downto 0);  -- Input 1
        C : in std_logic_vector(3 downto 0);  -- Input 2
        Sel : in std_logic_vector(1 downto 0); -- 2-bit selector
        Y : out std_logic_vector(3 downto 0)  -- Output
    );
end MUX_3_4;

architecture Behavioral of MUX_3_4 is
begin
    process(A, B, C, Sel)
    begin
        case Sel is
            when "00" =>
                Y <= A;
            when "01" =>
                Y <= B;
            when "10" =>
                Y <= C;
            when others =>
                Y <= (others => '0'); -- Default case
        end case;
    end process;
end Behavioral;
