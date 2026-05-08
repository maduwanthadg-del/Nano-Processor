library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.all;
use work.processor_components.all;

entity TB_Processor is
end TB_Processor;

architecture Behavioral of TB_Processor is

    signal Clock          : std_logic := '0';
    signal Reset          : std_logic := '1';

    signal Data           : data_bus;
    signal Overflow, Zero : std_logic;
    signal seg            : std_logic_vector(6 downto 0);
    signal addr           : instruction_address;
    signal anode          : bus_4_bit;
    signal input_switches : data_bus := (others => '0');
    signal input_ready    : std_logic := '0';

begin

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

    clk_proc: process
    begin
        while true loop
            Clock <= '0'; wait for 10 ns;
            Clock <= '1'; wait for 10 ns;
        end loop;
    end process clk_proc;

    reset_proc: process
    begin
        Reset <= '1';
        wait for 80 ns;
        Reset <= '0';
        wait;
    end process reset_proc;

    stim_proc: process
    begin
        wait until Reset = '0';
        wait until rising_edge(Clock);

        input_switches <= "1010";
        wait for 15 ns;
        input_ready    <= '1';
        wait for 20 ns;
        input_ready    <= '0';

        wait for 200 ns;
        wait;
    end process stim_proc;

end Behavioral;
