----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 03:00:36 AM
-- Design Name: 
-- Module Name: jump_pc_selector - Behavioral
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
use work.buses.instruction_address;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity jump_pc_selector is
      Port ( 
        program_counter_address: in instruction_address;
        jump_address : in instruction_address;
        jump_flag : in std_logic;
        jump_pc_selector_out: out instruction_address);
end jump_pc_selector;

architecture Behavioral of jump_pc_selector is

begin

    MUX : entity work.MUX_2_3 
        port map (
            D0 => program_counter_address,
            D1 => jump_address,
            S => jump_flag,
            Y => jump_pc_selector_out);


end Behavioral;
