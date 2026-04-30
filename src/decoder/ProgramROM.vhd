----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2026 10:50:06 AM
-- Design Name: 
-- Module Name: ProgramROM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProgramROM is
    Port (
        Addr : in  STD_LOGIC_VECTOR(2 downto 0);
        Data : out STD_LOGIC_VECTOR(11 downto 0)
    );
end ProgramROM;

architecture Behavioral of ProgramROM is
begin
    process(Addr)
    begin
        case Addr is
            when "000" => Data <= "100010000001";  -- MOVI R1, 1
            when "001" => Data <= "100100000010";  -- MOVI R2, 2
            when "010" => Data <= "100110000011";  -- MOVI R3, 3
            when "011" => Data <= "000010100000";  -- ADD  R1, R2
            when "100" => Data <= "000010110000";  -- ADD  R1, R3
            when "101" => Data <= "101110000000";  -- MOVI R7, 0
            when "110" => Data <= "000111001000";  -- ADD  R7, R1
            when "111" => Data <= "110000000111";  -- JZR  R0, 7
            when others => Data <= "000000000000";
        end case;
    end process;
end Behavioral;