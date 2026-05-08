library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package op_codes is


    constant MOVI : std_logic_vector(2 downto 0) := "010";
    constant ADD : std_logic_vector(2 downto 0) := "000";
    constant NEG : std_logic_vector(2 downto 0) := "001";
    constant JZR : std_logic_vector(2 downto 0) := "011";
    constant INP : std_logic_vector(2 downto 0) := "100";
    constant HLT : std_logic_vector (2 downto 0) :="111";

end package op_codes;