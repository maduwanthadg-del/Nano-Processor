
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.buses.all;
use work.processor_components.all;

entity Processor_tb is
end Processor_tb;

architecture Behavioral of Processor_tb is

    signal Clk            : std_logic := '0';
    signal Reset          : std_logic := '0';
    signal Overflow       : std_logic;
    signal Zero           : std_logic;
    signal Data           : data_bus;
    signal seg            : std_logic_vector(6 downto 0);
    signal addr           : instruction_address;
    signal anode          : bus_4_bit;
    signal input_switches : data_bus := "1111";
    signal input_ready    : std_logic := '0';

    constant clk_period : time := 20 ns;

begin

    -- Instantiate the Processor
    uut: entity work.Processor
        port map (
            Clk            => Clk,
            Reset          => Reset,
            Overflow       => Overflow,
            Zero           => Zero,
            Data           => Data,
            seg            => seg,
            addr           => addr,
            anode          => anode,
            input_switches => input_switches,
            input_ready    => input_ready
        );

    -- Clock generation
    clk_process :process
    begin
        while now < 5 ms loop
            Clk <= '0';
            wait for clk_period/2;
            Clk <= '1';
            wait for clk_period/2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Hold reset
        Reset <= '1';
        wait for 40 ns;
        Reset <= '0';

        -- Wait for some cycles
        wait for 200 ns;

        -- Trigger input wait (simulate that instruction has set internal_waiting high internally)
        -- We'll simulate input_ready being pressed for INP instruction
        input_ready <= '0';
        wait for 100 ns;

        -- Simulate input_ready button press
        input_ready <= '1';
        wait for 40 ns;
        input_ready <= '0';

        -- Wait to observe PC increment
        wait for 200 ns;

        -- Apply another press
        input_ready <= '1';
        wait for 40 ns;
        input_ready <= '0';

        wait for 400 ns;
        wait;
    end process;

end Behavioral;
