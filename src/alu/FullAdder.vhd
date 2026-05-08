----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 01:33:52 AM
-- Design Name: 
-- Module Name: FA - Behavioral
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

entity FA is
     Port ( 
        A : in std_logic;
        B : in std_logic;
        C_in : in std_logic;
        S : out std_logic;
        C_out : out std_logic);
end FA;

architecture Behavioral of FA is



    signal ha0s,ha0c,ha1c: std_logic;
    
begin

    HA_0 : entity work.HA
        port map (
            A => A,
            B => B,
            S => ha0s,
            C => ha0c);
   
    HA_1 : entity work.HA
        port map (
            A => ha0s,
            B =>C_in,
            s => s,
            c => ha1c);
            
            
     C_out <= ha0c or ha1c;
   
          

end Behavioral;
