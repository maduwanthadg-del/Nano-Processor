----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 01:59:13 AM
-- Design Name: 
-- Module Name: Adder_Subtractor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Adder/Subtractor using 4-bit Ripple Carry Adder
-- 
-- Dependencies: RCA_4 (4-bit Ripple Carry Adder)
-- 
-- Revision:
-- Revision 0.02 - Added subtraction logic by XORing B with CTRL
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder_Subtractor is
      Port (
          A : in std_logic_vector(3 downto 0);
          B : in std_logic_vector(3 downto 0);
          CTRL : in std_logic; -- 0 = Add, 1 = Subtract
          S : out std_logic_vector(3 downto 0);
          Zero : out std_logic;
          Overflow : out std_logic
      );
end Adder_Subtractor;

architecture Behavioral of Adder_Subtractor is

    signal internal_s : std_logic_vector(3 downto 0);
    signal B_mod : std_logic_vector(3 downto 0);

begin

    -- XOR each bit of B with CTRL to invert B if CTRL=1 (subtraction)
    B_mod(0) <= B(0) xor CTRL;
    B_mod(1) <= B(1) xor CTRL;
    B_mod(2) <= B(2) xor CTRL;
    B_mod(3) <= B(3) xor CTRL;


    RCA_4_0: entity work.RCA_4
        port map (
            A => A,
            B => B_mod,
            C_in => CTRL,
            S => internal_s,
            C_out => Overflow
        );

    Zero <= NOT(internal_s(0) OR internal_s(1) OR internal_s(2) OR internal_s(3));

    S <= internal_s;

end Behavioral;
