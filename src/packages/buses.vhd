

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


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
            
            
