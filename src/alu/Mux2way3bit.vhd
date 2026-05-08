----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 02:32:43 PM
-- Design Name: 
-- Module Name: MUX_2_way_3_Bit - Behavioral
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
use work.buses.bus_3_bit;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_2_3 is
    Port ( D0 : in bus_3_bit;
           D1 : in bus_3_bit;
           S : in STD_LOGIC;
           Y : out bus_3_bit);
end MUX_2_3;

architecture Behavioral of MUX_2_3 is

begin
    Y <= D0 when (S = '0') else
         D1 when (S = '1');
         
end Behavioral;