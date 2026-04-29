----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2026 12:02:14 AM
-- Design Name: 
-- Module Name: Reg4bit - Behavioral
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

entity Reg4bit is
    Port (
        D     : in  STD_LOGIC_VECTOR(3 downto 0);
        Clk   : in  STD_LOGIC;
        Reset : in  STD_LOGIC;
        En    : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Reg4bit;

architecture Behavioral of Reg4bit is
    component DFF
        Port (D, Clk, Reset : in STD_LOGIC; Q : out STD_LOGIC);
    end component;
    signal D_gated    : STD_LOGIC_VECTOR(3 downto 0);
    signal Q_internal : STD_LOGIC_VECTOR(3 downto 0);
begin
    -- Gate the data input with the enable signal
    -- When En=0 the register holds its current value
    D_gated(0) <= (D(0) AND En) OR (Q_internal(0) AND NOT En);
    D_gated(1) <= (D(1) AND En) OR (Q_internal(1) AND NOT En);
    D_gated(2) <= (D(2) AND En) OR (Q_internal(2) AND NOT En);
    D_gated(3) <= (D(3) AND En) OR (Q_internal(3) AND NOT En);

    FF0: DFF port map (D=>D_gated(0), Clk=>Clk, Reset=>Reset, Q=>Q_internal(0));
    FF1: DFF port map (D=>D_gated(1), Clk=>Clk, Reset=>Reset, Q=>Q_internal(1));
    FF2: DFF port map (D=>D_gated(2), Clk=>Clk, Reset=>Reset, Q=>Q_internal(2));
    FF3: DFF port map (D=>D_gated(3), Clk=>Clk, Reset=>Reset, Q=>Q_internal(3));

    Q <= Q_internal;
end Behavioral;