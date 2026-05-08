----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 01:29:20 AM
-- Design Name: 
-- Module Name: RCA_4 - Behavioral
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

entity RCA_4 is
    Port (
        A: in std_logic_vector (3 downto 0);
        B: in std_logic_vector (3 downto 0);
        C_in : in std_logic;
        S: out std_logic_vector (3 downto 0);
        C_out : out std_logic);
end RCA_4;

architecture Behavioral of RCA_4 is

    signal carry_0, carry_1, carry_2 : std_logic;

begin

    FA_0 : entity work.FA
        port map(
            A => A(0),
            B => B(0),
            C_in => C_in,
            S => S(0),
            C_out => Carry_0);
            
            
    FA_1 : entity work.FA
        port map (
            A => A(1),
            B => B(1),
            C_in => carry_0,
            S => S(1),
            C_out => carry_1);
            
     
     FA_2: entity work.FA
        port map (
            A => A(2),
            B => B(2),
            C_in => carry_1,
            S => S(2),
            C_out => carry_2);
            
            
     FA_3 : entity work.FA
        port map (
            A => A(3),
            B => B(3),
            C_in => carry_2,
            S => S(3),
            C_out => C_out);
            
 


end Behavioral;
