library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder_Subtractor_tb is
end Adder_Subtractor_tb;

architecture Behavioral of Adder_Subtractor_tb is

    -- Component declaration
    component Adder_Subtractor is
        Port (
            A        : in std_logic_vector(3 downto 0);
            B        : in std_logic_vector(3 downto 0);
            CTRL     : in std_logic;
            S        : out std_logic_vector(3 downto 0);
            Zero     : out std_logic;
            Overflow : out std_logic
        );
    end component;

    -- Signals for testbench
    signal A_tb        : std_logic_vector(3 downto 0) := (others => '0');
    signal B_tb        : std_logic_vector(3 downto 0) := (others => '0');
    signal CTRL_tb     : std_logic := '0';
    signal S_tb        : std_logic_vector(3 downto 0);
    signal Zero_tb     : std_logic;
    signal Overflow_tb : std_logic;

begin

    -- Instantiate the UUT (Unit Under Test)
    UUT: Adder_Subtractor
        port map (
            A        => A_tb,
            B        => B_tb,
            CTRL     => CTRL_tb,
            S        => S_tb,
            Zero     => Zero_tb,
            Overflow => Overflow_tb
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test 1: 3 + 2 = 5
        CTRL_tb <= '0';
        A_tb <= "0011";
        B_tb <= "0010";
        wait for 100 ns;


        A_tb <= "0101";
        B_tb <= "0010";
        wait for 100 ns;

        -- Test 3: 4 - 4 = 0
        CTRL_tb <= '1';
        A_tb <= "0100";
        B_tb <= "0100";
        wait for 100 ns;

        -- Test 4: 7 + 9 = 16 (Overflow expected)
        A_tb <= "0111";
        B_tb <= "1001";
        wait for 100 ns;

        -- Test 5: 2 - 5 = (negative, expect underflow/overflow flag)

        A_tb <= "0000";
        B_tb <= "0101";
        wait for 100 ns;

        -- End of simulation
        wait;
    end process;

end Behavioral;
