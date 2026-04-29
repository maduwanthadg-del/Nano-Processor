----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2026 08:48:07 PM
-- Design Name: 
-- Module Name: Adder3bit - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Adder3bit is
    Port (
        A      : in  STD_LOGIC_VECTOR(2 downto 0);
        B      : in  STD_LOGIC_VECTOR(2 downto 0);
        Result : out STD_LOGIC_VECTOR(2 downto 0)
    );
end Adder3bit;

architecture Behavioral of Adder3bit is
    component FullAdder
        Port (A, B, Cin : in STD_LOGIC; Sum, Cout : out STD_LOGIC);
    end component;
    signal C : STD_LOGIC_VECTOR(3 downto 0);
begin
    C(0) <= '0';
    FA0: FullAdder port map (A=>A(0), B=>B(0), Cin=>C(0), Sum=>Result(0), Cout=>C(1));
    FA1: FullAdder port map (A=>A(1), B=>B(1), Cin=>C(1), Sum=>Result(1), Cout=>C(2));
    FA2: FullAdder port map (A=>A(2), B=>B(2), Cin=>C(2), Sum=>Result(2), Cout=>C(3));
end Behavioral;