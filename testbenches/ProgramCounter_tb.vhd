----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2026 12:05:30 AM
-- Design Name: 
-- Module Name: ProgramCounter_tb - Behavioral
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

entity ProgramCounter_tb is
end ProgramCounter_tb;

architecture Behavioral of ProgramCounter_tb is
    component ProgramCounter
        Port (Clk, Reset : in STD_LOGIC;
              D : in STD_LOGIC_VECTOR(2 downto 0);
              Q : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    signal Clk, Reset : STD_LOGIC := '0';
    signal D, Q : STD_LOGIC_VECTOR(2 downto 0) := "000";
begin
    UUT: ProgramCounter port map (Clk=>Clk, Reset=>Reset, D=>D, Q=>Q);
    Clk <= NOT Clk after 10 ns;
    process
    begin
        Reset <= '1'; wait for 20 ns;
        Reset <= '0';
        D <= "001"; wait for 20 ns;  -- Q should become 001
        D <= "010"; wait for 20 ns;  -- Q should become 010
        D <= "111"; wait for 20 ns;  -- Q should become 111
        Reset <= '1'; wait for 20 ns; -- Q should reset to 000
        Reset <= '0';
        wait;
    end process;
end Behavioral;