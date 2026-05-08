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
        Waiting_flag : out std_logic  -- New output for input wait
    );
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is
    signal op_code : std_logic_vector(2 downto 0);
begin

    op_code <= Instruction(12 downto 10);

    process(op_code, Jump_Register_Value, Instruction)
    begin
        -- Default/reset values for outputs
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

            when MOVI =>
                Register_Enable   <= Instruction(9 downto 7);
                Immediate_value   <= Instruction(3 downto 0);
                Load_select       <= "01";

            when ADD =>
                Register_Select_A <= Instruction(9 downto 7);
                Register_Select_B <= Instruction(6 downto 4);
                Register_Enable   <= Instruction(9 downto 7);
                Operation         <= '0'; -- Add

            when NEG =>
                Register_Select_B <= Instruction(9 downto 7); -- Operand B is input
                Register_Enable   <= Instruction(9 downto 7);
                Operation         <= '1'; -- Negate

            when JZR =>
                Register_Select_A <= Instruction(9 downto 7);
                if Jump_Register_Value = "0000" then
                    Jump_flag    <= '1';
                    Jump_Address <= Instruction(2 downto 0);
                end if;

            when INP =>
                Register_Enable <= Instruction (9 downto 7);
                Load_select <= "10";
                
            when HLT =>
                Waiting_flag <= '1';

            when others =>
                null;
        end case;
    end process;

end Behavioral;
