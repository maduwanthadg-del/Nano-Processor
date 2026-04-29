----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2026 12:03:51 AM
-- Design Name: 
-- Module Name: ProgramCounter - Behavioral
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProgramCounter is
    Port (
        Clk   : in  STD_LOGIC;
        Reset : in  STD_LOGIC;
        D     : in  STD_LOGIC_VECTOR(2 downto 0);
        Q     : out STD_LOGIC_VECTOR(2 downto 0)
    );
end ProgramCounter;

architecture Behavioral of ProgramCounter is
    component DFF
        Port (D, Clk, Reset : in STD_LOGIC; Q : out STD_LOGIC);
    end component;
begin
    FF0: DFF port map (D=>D(0), Clk=>Clk, Reset=>Reset, Q=>Q(0));
    FF1: DFF port map (D=>D(1), Clk=>Clk, Reset=>Reset, Q=>Q(1));
    FF2: DFF port map (D=>D(2), Clk=>Clk, Reset=>Reset, Q=>Q(2));
end Behavioral;