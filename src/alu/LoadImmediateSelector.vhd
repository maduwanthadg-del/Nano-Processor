----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 03:49:06 AM
-- Design Name: 
-- Module Name: Load_Immediate_Selector - Behavioral
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
use work.buses.data_bus;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Load_Immediate_Selector is
      Port (
          ALU_value : in data_bus;
          immediate_value : in data_bus;
          Load_select: in std_logic;
          Out_value: out data_bus );
end Load_Immediate_Selector;

architecture Behavioral of Load_Immediate_Selector is

begin


    MUX : entity work.MUX_2_4
        port map (
            D0 => ALU_value,
            D1 => immediate_value,
            S  => Load_select,
            D_out  => Out_value);


end Behavioral;
