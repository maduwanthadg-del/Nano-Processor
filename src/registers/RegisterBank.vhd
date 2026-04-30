library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegisterBank is
    Port (
        Clk    : in  STD_LOGIC;
        Reset  : in  STD_LOGIC;
        RegEn  : in  STD_LOGIC_VECTOR(7 downto 0);
        DataIn : in  STD_LOGIC_VECTOR(3 downto 0);
        R0out  : out STD_LOGIC_VECTOR(3 downto 0);
        R1out  : out STD_LOGIC_VECTOR(3 downto 0);
        R2out  : out STD_LOGIC_VECTOR(3 downto 0);
        R3out  : out STD_LOGIC_VECTOR(3 downto 0);
        R4out  : out STD_LOGIC_VECTOR(3 downto 0);
        R5out  : out STD_LOGIC_VECTOR(3 downto 0);
        R6out  : out STD_LOGIC_VECTOR(3 downto 0);
        R7out  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end RegisterBank;

architecture Behavioral of RegisterBank is
    component Reg4bit
        Port (D : in STD_LOGIC_VECTOR(3 downto 0);
              Clk, Reset, En : in STD_LOGIC;
              Q : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
begin
    -- R0 is permanently hardwired to 0000 (read-only, never written)
    R0out <= "0000";

    R1: Reg4bit port map (D=>DataIn, Clk=>Clk, Reset=>Reset, En=>RegEn(1), Q=>R1out);
    R2: Reg4bit port map (D=>DataIn, Clk=>Clk, Reset=>Reset, En=>RegEn(2), Q=>R2out);
    R3: Reg4bit port map (D=>DataIn, Clk=>Clk, Reset=>Reset, En=>RegEn(3), Q=>R3out);
    R4: Reg4bit port map (D=>DataIn, Clk=>Clk, Reset=>Reset, En=>RegEn(4), Q=>R4out);
    R5: Reg4bit port map (D=>DataIn, Clk=>Clk, Reset=>Reset, En=>RegEn(5), Q=>R5out);
    R6: Reg4bit port map (D=>DataIn, Clk=>Clk, Reset=>Reset, En=>RegEn(6), Q=>R6out);
    R7: Reg4bit port map (D=>DataIn, Clk=>Clk, Reset=>Reset, En=>RegEn(7), Q=>R7out);
end Behavioral;