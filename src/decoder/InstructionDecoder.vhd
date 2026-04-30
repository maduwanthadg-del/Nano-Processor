----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2026 10:50:41 AM
-- Design Name: 
-- Module Name: InstructionDecoder - Behavioral
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

entity InstructionDecoder is
    Port (
        Instr     : in  STD_LOGIC_VECTOR(11 downto 0);
        RegSel_A  : out STD_LOGIC_VECTOR(2 downto 0);
        RegSel_B  : out STD_LOGIC_VECTOR(2 downto 0);
        LoadSel   : out STD_LOGIC;
        AddSubSel : out STD_LOGIC;
        ImmVal    : out STD_LOGIC_VECTOR(3 downto 0);
        JumpFlag  : out STD_LOGIC;
        JumpAddr  : out STD_LOGIC_VECTOR(2 downto 0);
        RegWrite  : out STD_LOGIC
    );
end InstructionDecoder;

architecture Behavioral of InstructionDecoder is
    signal opcode : STD_LOGIC_VECTOR(1 downto 0);
begin
    opcode <= Instr(11 downto 10);

    -- These fields are always extracted the same way
    RegSel_A <= Instr(9 downto 7);
    RegSel_B <= Instr(6 downto 4);
    ImmVal   <= Instr(3 downto 0);
    JumpAddr <= Instr(2 downto 0);

    process(opcode)
    begin
        LoadSel   <= '0';
        AddSubSel <= '0';
        JumpFlag  <= '0';
        RegWrite  <= '0';

        case opcode is
            when "10" =>  -- MOVI: load immediate into register
                LoadSel  <= '1';
                RegWrite <= '1';

            when "00" =>  -- ADD: Ra <- Ra + Rb
                LoadSel   <= '0';
                AddSubSel <= '0';
                RegWrite  <= '1';

            when "01" =>  -- NEG: Ra <- 0 - Ra
                -- In top-level: ALU_A = R0 (always 0), ALU_B = Ra
                -- So ALU computes 0 - Ra = -Ra (two's complement)
                LoadSel   <= '0';
                AddSubSel <= '1';
                RegWrite  <= '1';

            when "11" =>  -- JZR: conditional jump, no register write
                JumpFlag <= '1';
                RegWrite <= '0';

            when others =>
                null;
        end case;
    end process;
end Behavioral;