----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2026 09:26:05 PM
-- Design Name: 
-- Module Name: Mux8way4bit_tb - Behavioral
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

entity Mux8way4bit_tb is
--  Port ( );
end Mux8way4bit_tb;

architecture Behavioral of Mux8way4bit_tb is
    component Mux8way4bit
        Port (D0,D1,D2,D3,D4,D5,D6,D7 : in STD_LOGIC_VECTOR(3 downto 0);
              Sel : in STD_LOGIC_VECTOR(2 downto 0);
              Y   : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    signal D0,D1,D2,D3,D4,D5,D6,D7,Y : STD_LOGIC_VECTOR(3 downto 0);
    signal Sel : STD_LOGIC_VECTOR(2 downto 0);
begin
    UUT: Mux8way4bit port map (D0=>D0,D1=>D1,D2=>D2,D3=>D3,
                                D4=>D4,D5=>D5,D6=>D6,D7=>D7,Sel=>Sel,Y=>Y);
    process
    begin
        D0<="0000"; D1<="0001"; D2<="0010"; D3<="0011";
        D4<="0100"; D5<="0101"; D6<="0110"; D7<="0111";
        Sel<="000"; wait for 10 ns;  -- Y = 0000
        Sel<="001"; wait for 10 ns;  -- Y = 0001
        Sel<="010"; wait for 10 ns;  -- Y = 0010
        Sel<="110"; wait for 10 ns;  -- Y = 0110
        Sel<="111"; wait for 10 ns;  -- Y = 0111
        wait;
    end process;
end Behavioral;