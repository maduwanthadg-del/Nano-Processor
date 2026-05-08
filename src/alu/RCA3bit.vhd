----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 02:26:43 AM
-- Design Name: 
-- Module Name: RCA_3 - Behavioral
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

entity RCA_3 is

    Port ( 
        A: in std_logic_vector(2 downto 0);
        B : in std_logic_vector (2 downto 0);
        C_in : in std_logic;
        S: out  std_logic_vector(2 downto 0);
        C_out : out std_logic);
        
end RCA_3;

architecture Behavioral of RCA_3 is


    signal carry0, carry1 : std_logic;

begin

    FA0: entity work.FA
        port map (
            A => A(0),
            B => B(0),
            C_in => C_in,
            S => S(0),
            C_out => carry0);
            
     FA1: entity work.FA
         port map (
             A => A(1),
             B => B(1),
             C_in => carry0,
             S => S(1),
             C_out => carry1);       
        
        
     FA2: entity work.FA
         port map (
             A => A(2),
             B => B(2),
             C_in => carry1,
             S => S(2),
             C_out => C_out);


end Behavioral;
