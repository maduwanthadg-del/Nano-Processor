library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.all;
use work.processor_components.all;

entity Processor is
    Port (
        Clk             : in std_logic;
        Reset           : in std_logic;
        Overflow        : out std_logic;
        Zero            : out std_logic;
        Data            : out data_bus;
        seg             : out std_logic_vector(6 downto 0);
        addr            : out instruction_address;
        anode           : out bus_4_bit;
        input_switches  : in data_bus;
        input_ready     : in std_logic
    );
end Processor;

architecture Behavioral of Processor is

    signal clk_slow          : std_logic;

    signal next_addr         : instruction_address;
    signal current_addr      : instruction_address;
    signal selected_addr     : instruction_address;
    signal jmp_address       : instruction_address;
    signal jmp_flag          : std_logic;

    signal Instruction       : instruction_bus;
    signal load_sel          : std_logic_vector (1 downto 0);

    signal oprA_addr         : register_address;
    signal oprB_addr         : register_address;
    signal oprA_val          : data_bus;
    signal oprB_val          : data_bus;
    signal au_result         : data_bus;
    signal reg_enable        : register_address;
    signal load_in_im_out      : data_bus;
    signal add_sub_sel       : std_logic;
    signal register_data     : data_buses;
    signal immediate_val     : data_bus;

    signal internal_waiting   : std_logic := '0';
    signal im_in_sel_out      : data_bus;

    signal waiting_state       : std_logic := '0';
    signal clear_waiting_next : std_logic := '0';
    signal input_ready_prev    : std_logic := '0';
    signal input_ready_rising  : std_logic := '0';

    signal increment_enable    : std_logic;

begin

    -- Divide 100MHz board clock down to ~1Hz for visible execution
    CLK_0 : Slow_Clk
        port map (
            Clk_in  => Clk,
            Clk_out => clk_slow
        );

    -- Rising edge detector: detects when BTNR is freshly pressed
    process(clk_slow, Reset)
    begin
        if Reset = '1' then
            input_ready_prev   <= '0';
            input_ready_rising <= '0';
        elsif rising_edge(clk_slow) then
            input_ready_rising <= input_ready and not input_ready_prev; -- High for one cycle on press
            input_ready_prev   <= input_ready;
        end if;
    end process;

    -- Waiting state FSM: enters on INP/HLT, exits one cycle after BTNR press
    process(clk_slow, Reset)
    begin
        if Reset = '1' then
            waiting_state       <= '0';
            clear_waiting_next  <= '0';
        elsif rising_edge(clk_slow) then
            if internal_waiting = '1' then
                waiting_state      <= '1'; -- Halt the processor
                clear_waiting_next <= '0';
            elsif input_ready = '1' and waiting_state = '1' then
                if clear_waiting_next = '1' then
                    waiting_state <= '0'; -- Resume execution
                else
                    clear_waiting_next <= '1';
                end if;
            end if;
        end if;
    end process;

    -- PC only advances on button press when waiting, otherwise advances freely
    increment_enable <= input_ready_rising when waiting_state = '1'
                    else '1' when waiting_state = '0'
                    else '0';

    Data <= register_data(7); -- Output Register 7 value to LEDs

    ID: Instruction_decoder
        port map (
            Instruction             => Instruction,
            Jump_Register_Value     => oprA_val,
            Register_enable         => reg_enable,
            Register_select_A       => oprA_addr,
            Register_select_B       => oprB_addr,
            Operation               => add_sub_sel,
            Immediate_value         => immediate_val,
            Jump_flag               => jmp_flag,
            Jump_address            => jmp_address,
            Load_select             => load_sel,
            Waiting_flag  => internal_waiting
        );

    PC_IN: program_counter_incrementor
        port map (
            in_address        => current_addr,
            increment_enable  => increment_enable,
            out_address       => next_addr
        );
        
        
    -- 3-way MUX: selects ALU result (00), immediate value (01), or switch input (10)
    load_im_in_sel : MUX_3_4
        port map (
            A => au_result,        -- Sel=00: ALU output (ADD/NEG)
            B => immediate_val,    -- Sel=01: Immediate value (MOVI)
            C => input_switches,   -- Sel=10: External switch input (INP)
            Sel => load_sel,
            Y => load_in_im_out);

    
    -- 7-Segment Display: decode R7 value to segment pattern
    LUT_16_7_0: LUT_16_7
        port map (
            address => register_data(7),
            data    => seg
        );

    OPR_A: MUX_8_4
        port map (
            S => oprA_addr,
            D => register_data,
            Y => oprA_val
        );

    OPR_B: MUX_8_4
        port map (
            S => oprB_addr,
            D => register_data,
            Y => oprB_val
        );

    PROM: Program_ROM
        port map (
            ROM_address => current_addr,
            I           => Instruction
        );

    jump_pc_selector_0: jump_pc_selector
        port map (
            program_counter_address => next_addr,
            jump_address            => jmp_address,
            jump_flag               => jmp_flag,
            jump_pc_selector_out    => selected_addr
        );

    PC: Program_counter
        port map (
            Reset  => Reset,
            Clk    => clk_slow,
            PC_in  => selected_addr,
            PC_out => current_addr
        );

    Registet_Bank_0: Register_bank
        port map (
            Reg_En     => reg_enable,
            Res        => Reset,
            Clk        => clk_slow,
            Data       => load_in_im_out,
            Data_Buses => register_data
        );

    Adder_subtractor_0: Adder_subtractor
        port map (
            A        => oprA_val,
            B        => oprB_val,
            CTRL     => add_sub_sel,
            S        => au_result,
            Zero     => Zero,
            Overflow => Overflow
        );

    addr  <= current_addr; -- Display current PC address on LEDs LD9-LD12
    anode <= "1110"; -- Activate only the rightmost 7-segment display digit

end Behavioral;
