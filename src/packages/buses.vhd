----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 02:39:24 AM
-- Design Name: 
-- Module Name: buses - Behavioral
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

    package Buses is 
        
            subtype bus_3_bit is std_logic_vector (2 downto 0);
            subtype bus_4_bit is std_logic_vector (3 downto 0);
            subtype bus_8_bit is std_logic_vector (7 downto 0);
            subtype bus_13_bit is std_logic_vector (12 downto 0);
            
            type bus_8_4 is array (7 downto 0) of bus_4_bit;
            type bus_4_8 is array (3 downto 0) of bus_8_bit;
            
            
            subtype data_buses is bus_8_4;
            subtype instruction_address is bus_3_bit;
            subtype instruction_bus is bus_13_bit;
            subtype data_bus is bus_4_bit;
            subtype register_address is bus_3_bit;
            
            
    end package Buses;
            
            
            


