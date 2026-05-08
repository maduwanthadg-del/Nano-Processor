library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package op_codes is


    constant ADD  : std_logic_vector(2 downto 0) := "000"; -- Add two registers
    constant NEG  : std_logic_vector(2 downto 0) := "001"; -- Negate register (2's complement)
    constant MOVI : std_logic_vector(2 downto 0) := "010"; -- Load immediate value into register
    constant JZR  : std_logic_vector(2 downto 0) := "011"; -- Jump if register is zero
    constant INP  : std_logic_vector(2 downto 0) := "100"; -- Read value from external switches
    constant HLT  : std_logic_vector(2 downto 0) := "111"; -- Halt processor execution

end package op_codes;
