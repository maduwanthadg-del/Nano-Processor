----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2026 08:49:53 PM
-- Design Name: 
-- Module Name: Mux2way4bit - Behavioral
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

entity Mux2way4bit is
    Port (
        D0  : in  STD_LOGIC_VECTOR(3 downto 0);
        D1  : in  STD_LOGIC_VECTOR(3 downto 0);
        Sel : in  STD_LOGIC;
        Y   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Mux2way4bit;

architecture Behavioral of Mux2way4bit is
begin
    Y <= D0 when Sel = '0' else D1;
end Behavioral;
