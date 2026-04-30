----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2026 10:51:09 AM
-- Design Name: 
-- Module Name: InstructionDecoder_tb - Behavioral
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

entity InstructionDecoder_tb is
end InstructionDecoder_tb;

architecture Behavioral of InstructionDecoder_tb is
    component InstructionDecoder
        Port (Instr : in STD_LOGIC_VECTOR(11 downto 0);
              RegSel_A, RegSel_B : out STD_LOGIC_VECTOR(2 downto 0);
              LoadSel, AddSubSel, JumpFlag, RegWrite : out STD_LOGIC;
              ImmVal   : out STD_LOGIC_VECTOR(3 downto 0);
              JumpAddr : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    signal Instr                              : STD_LOGIC_VECTOR(11 downto 0);
    signal RegSel_A, RegSel_B, JumpAddr      : STD_LOGIC_VECTOR(2 downto 0);
    signal LoadSel, AddSubSel, JumpFlag, RegWrite : STD_LOGIC;
    signal ImmVal                             : STD_LOGIC_VECTOR(3 downto 0);
begin
    UUT: InstructionDecoder port map (
        Instr=>Instr, RegSel_A=>RegSel_A, RegSel_B=>RegSel_B,
        LoadSel=>LoadSel, AddSubSel=>AddSubSel, ImmVal=>ImmVal,
        JumpFlag=>JumpFlag, JumpAddr=>JumpAddr, RegWrite=>RegWrite);

    process
    begin
        -- MOVI R1, 1 -> LoadSel=1, RegWrite=1, RegSel_A=001, ImmVal=0001
        Instr <= "100010000001"; wait for 20 ns;
        -- ADD R1, R2 -> AddSubSel=0, RegWrite=1, RegSel_A=001, RegSel_B=010
        Instr <= "000010100000"; wait for 20 ns;
        -- NEG R3     -> AddSubSel=1, RegWrite=1, RegSel_A=011
        Instr <= "010110000000"; wait for 20 ns;
        -- JZR R0, 7  -> JumpFlag=1, RegWrite=0, JumpAddr=111
        Instr <= "110000000111"; wait for 20 ns;
        -- MOVI R7, 0 -> LoadSel=1, RegWrite=1, RegSel_A=111, ImmVal=0000
        Instr <= "101110000000"; wait for 20 ns;
        wait;
    end process;
end Behavioral;