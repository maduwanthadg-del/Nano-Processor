library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.all;               -- for data_bus, instruction_address, bus_4_bit
use work.processor_components.all;-- for your sub-components (slow clock, decoder, etc.)

entity TB_Processor is
--  No ports in a testbench
end TB_Processor;

architecture Behavioral of TB_Processor is

    -- Clock & Reset
    signal Clock          : std_logic := '0';
    signal Reset          : std_logic := '1';

    -- Top-level I/O to DUT
    signal Data           : data_bus;
    signal Overflow, Zero : std_logic;
    signal seg            : std_logic_vector(6 downto 0);
    signal addr           : instruction_address;
    signal anode          : bus_4_bit;
    signal input_switches : data_bus := (others => '0');
    signal input_ready    : std_logic := '0';

begin

    ----------------------------------------------------------------
    -- Instantiate the Device Under Test
    ----------------------------------------------------------------
    DUT: entity work.Processor
        port map (
            Clk            => Clock,
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

    ----------------------------------------------------------------
    -- Clock generation: 50 MHz (20 ns period)
    ----------------------------------------------------------------
    clk_proc: process
    begin
        while true loop
            Clock <= '0'; wait for 10 ns;
            Clock <= '1'; wait for 10 ns;
        end loop;
    end process clk_proc;

    ----------------------------------------------------------------
    -- Reset pulse
    ----------------------------------------------------------------
    reset_proc: process
    begin
        -- hold in reset for 4 clock cycles
        Reset <= '1';
        wait for 80 ns;
        Reset <= '0';
        wait;
    end process reset_proc;

    ----------------------------------------------------------------
    -- Stimulus: exercise an INP into R7
    ----------------------------------------------------------------
    stim_proc: process
    begin
        -- wait for reset release
        wait until Reset = '0';
        wait until rising_edge(Clock);

        -- Issue an INP instruction at ROM address 0
        -- (You should have your Program_ROM initialized accordingly.)
        -- Now drive switches and pulse input_ready
        input_switches <= "1010";      -- example data
        wait for 15 ns;                -- sometime during the clock high
        input_ready    <= '1';
        wait for 20 ns;                -- one full clock
        input_ready    <= '0';

        -- Observe Data, seg, etc.
        wait for 200 ns;
        wait;  -- finish
    end process stim_proc;

end Behavioral;
