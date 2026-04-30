library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity AddSub4bit_tb is
end AddSub4bit_tb;

architecture Behavioral of AddSub4bit_tb is
    component AddSub4bit
        Port (A, B : in STD_LOGIC_VECTOR(3 downto 0);
              AddSub   : in  STD_LOGIC;
              Result   : out STD_LOGIC_VECTOR(3 downto 0);
              Carry    : out STD_LOGIC;
              Overflow : out STD_LOGIC;
              Zero     : out STD_LOGIC);
    end component;
    signal A, B, Result : STD_LOGIC_VECTOR(3 downto 0);
    signal AddSub, Carry, Overflow, Zero : STD_LOGIC;
begin
    UUT: AddSub4bit port map (A=>A, B=>B, AddSub=>AddSub,
                               Result=>Result, Carry=>Carry,
                               Overflow=>Overflow, Zero=>Zero);
    process
    begin
        -- ============================================================
        -- Standard test cases (program-relevant values)
        -- ============================================================
        -- Test 1: 1 + 2 = 3 (used in our program, line 3)
        A <= "0001"; B <= "0010"; AddSub <= '0'; wait for 20 ns;
        -- Test 2: 3 + 3 = 6 (used in our program, line 4)
        A <= "0011"; B <= "0011"; AddSub <= '0'; wait for 20 ns;
        -- Test 3: 6 - 3 = 3
        A <= "0110"; B <= "0011"; AddSub <= '1'; wait for 20 ns;
        -- Test 4: 3 - 3 = 0, Zero flag should be 1
        A <= "0011"; B <= "0011"; AddSub <= '1'; wait for 20 ns;
        -- Test 5: NEG simulation: 0 - 3 = -3 = 1101 in two's complement
        A <= "0000"; B <= "0011"; AddSub <= '1'; wait for 20 ns;

        A <= "0001"; B <= "0001"; AddSub <= '0'; wait for 20 ns;  -- 1 + 1 = 2  (0010), Carry=0
        A <= "0000"; B <= "0010"; AddSub <= '1'; wait for 20 ns;  -- 0 - 2 = -2 (1110), Carry=0
        A <= "0001"; B <= "0000"; AddSub <= '0'; wait for 20 ns;  -- 1 + 0 = 1  (0001), Carry=0
        A <= "0010"; B <= "0001"; AddSub <= '1'; wait for 20 ns;  -- 2 - 1 = 1  (0001), Carry=1
        wait;
    end process;
end Behavioral;