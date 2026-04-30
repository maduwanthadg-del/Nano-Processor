library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity AddSub4bit is
    Port (
        A        : in  STD_LOGIC_VECTOR(3 downto 0);
        B        : in  STD_LOGIC_VECTOR(3 downto 0);
        AddSub   : in  STD_LOGIC;   -- 0 = Add, 1 = Subtract
        Result   : out STD_LOGIC_VECTOR(3 downto 0);
        Carry    : out STD_LOGIC;   -- spec-required flag (LD15)
        Overflow : out STD_LOGIC;   -- bonus: signed-overflow indicator
        Zero     : out STD_LOGIC    -- spec-required flag (LD14)
    );
end AddSub4bit;

architecture Behavioral of AddSub4bit is
    component RCA4bit
        Port (A, B : in STD_LOGIC_VECTOR(3 downto 0);
              Cin  : in  STD_LOGIC;
              Sum  : out STD_LOGIC_VECTOR(3 downto 0);
              Cout : out STD_LOGIC);
    end component;
    signal B_effective   : STD_LOGIC_VECTOR(3 downto 0);
    signal Sum_internal  : STD_LOGIC_VECTOR(3 downto 0);
    signal Cout_internal : STD_LOGIC;
begin
    -- When AddSub=1: invert B bits. Carry-in=AddSub adds the +1
    B_effective <= B XOR (AddSub & AddSub & AddSub & AddSub);

    ADDER: RCA4bit port map (
        A    => A,
        B    => B_effective,
        Cin  => AddSub,
        Sum  => Sum_internal,
        Cout => Cout_internal
    );

    Result   <= Sum_internal;
    Zero     <= '1' when Sum_internal = "0000" else '0';

    -- Carry flag: bit shifted out of the MSB. For ADD this signals
    -- unsigned overflow. For SUB it signals "no borrow" (in 2's complement
    -- subtraction, Cout=1 means A >= B).
    Carry    <= Cout_internal;

    -- Overflow flag: signed overflow, computed as Cin_to_MSB XOR Cout_from_MSB.
    -- (Kept as a bonus indicator. Not used on LD15 because spec says LD15 = carry.)
    Overflow <= A(3) XOR B_effective(3) XOR Sum_internal(3) XOR Cout_internal;
end Behavioral;