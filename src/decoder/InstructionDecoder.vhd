library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.all;
use work.op_codes.all;

entity Instruction_Decoder is
    Port (
        Instruction            : in  instruction_bus;
        Jump_Register_Value    : in  data_bus;
        Register_Enable        : out register_address;
        Register_Select_A      : out register_address;
        Register_Select_B      : out register_address;
        Operation              : out std_logic;
        Immediate_value        : out data_bus;
        Jump_flag              : out std_logic;
        Jump_Address           : out instruction_address;
        Load_select            : out std_logic_vector (1 downto 0);
        Waiting_flag : out std_logic
    );
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is
    signal op_code : std_logic_vector(2 downto 0);
begin

    op_code <= Instruction(12 downto 10); -- Extract 3-bit opcode from top of 13-bit instruction

    process(op_code, Jump_Register_Value, Instruction)
    begin
        Register_Enable        <= (others => '0');
        Register_Select_A      <= (others => '0');
        Register_Select_B      <= (others => '0');
        Immediate_value        <= (others => '0');
        Operation              <= '0';
        Jump_flag              <= '0';
        Jump_Address           <= (others => '0');
        Load_select            <= "00";
        Waiting_flag <= '0';

        case op_code is

            when MOVI => -- Load immediate value into target register
                Register_Enable   <= Instruction(9 downto 7); -- Target register
                Immediate_value   <= Instruction(3 downto 0); -- 4-bit immediate data
                Load_select       <= "01"; -- Select immediate path through 3-way MUX

            when ADD => -- Add two registers, store result in Register A
                Register_Select_A <= Instruction(9 downto 7); -- Destination & operand A
                Register_Select_B <= Instruction(6 downto 4); -- Operand B
                Register_Enable   <= Instruction(9 downto 7);
                Operation         <= '0'; -- ALU mode: Addition

            when NEG => -- Negate register value (2's complement)
                Register_Select_B <= Instruction(9 downto 7);
                Register_Enable   <= Instruction(9 downto 7);
                Operation         <= '1'; -- ALU mode: Subtraction

            when JZR => -- Jump to address if register value is zero
                Register_Select_A <= Instruction(9 downto 7);
                if Jump_Register_Value = "0000" then
                    Jump_flag    <= '1'; -- Trigger jump
                    Jump_Address <= Instruction(2 downto 0); -- 3-bit target address
                end if;

            when INP => -- Read external switch input into target register
                Register_Enable <= Instruction (9 downto 7);
                Load_select <= "10"; -- Select switch input path through 3-way MUX
                
            when HLT => -- Halt processor execution
                Waiting_flag <= '1'; -- Signal the top-level to stop the PC

            when others =>
                null;
        end case;
    end process;

end Behavioral;
