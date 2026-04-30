library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity RCA4bit is
    Port (
        A    : in  STD_LOGIC_VECTOR(3 downto 0);
        B    : in  STD_LOGIC_VECTOR(3 downto 0);
        Cin  : in  STD_LOGIC;
        Sum  : out STD_LOGIC_VECTOR(3 downto 0);
        Cout : out STD_LOGIC
    );
end RCA4bit;

architecture Behavioral of RCA4bit is
    component FullAdder
        Port (A, B, Cin : in STD_LOGIC; Sum, Cout : out STD_LOGIC);
    end component;
    signal C : STD_LOGIC_VECTOR(4 downto 0);
begin
    C(0) <= Cin;
    FA0: FullAdder port map (A=>A(0), B=>B(0), Cin=>C(0), Sum=>Sum(0), Cout=>C(1));
    FA1: FullAdder port map (A=>A(1), B=>B(1), Cin=>C(1), Sum=>Sum(1), Cout=>C(2));
    FA2: FullAdder port map (A=>A(2), B=>B(2), Cin=>C(2), Sum=>Sum(2), Cout=>C(3));
    FA3: FullAdder port map (A=>A(3), B=>B(3), Cin=>C(3), Sum=>Sum(3), Cout=>C(4));
    Cout <= C(4);
end Behavioral;