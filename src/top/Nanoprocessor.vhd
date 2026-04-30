library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Nanoprocessor is
    Port (
        Clk_100MHz : in  STD_LOGIC;
        Reset      : in  STD_LOGIC;
        LED        : out STD_LOGIC_VECTOR(15 downto 0);
        Seg        : out STD_LOGIC_VECTOR(6 downto 0);
        AN         : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Nanoprocessor;

architecture Behavioral of Nanoprocessor is

    component SlowClock
        Generic (DIVIDER : integer := 5);
        Port (Clk_in : in STD_LOGIC; Clk_out : out STD_LOGIC);
    end component;
    component ProgramCounter
        Port (Clk, Reset : in STD_LOGIC;
              D : in STD_LOGIC_VECTOR(2 downto 0);
              Q : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    component Adder3bit
        Port (A, B : in STD_LOGIC_VECTOR(2 downto 0);
              Result : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    component Mux2way3bit
        Port (D0, D1 : in STD_LOGIC_VECTOR(2 downto 0);
              Sel : in STD_LOGIC;
              Y   : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    component ProgramROM
        Port (Addr : in STD_LOGIC_VECTOR(2 downto 0);
              Data : out STD_LOGIC_VECTOR(11 downto 0));
    end component;
    component InstructionDecoder
        Port (Instr : in STD_LOGIC_VECTOR(11 downto 0);
              RegSel_A, RegSel_B : out STD_LOGIC_VECTOR(2 downto 0);
              LoadSel, AddSubSel, JumpFlag, RegWrite : out STD_LOGIC;
              ImmVal   : out STD_LOGIC_VECTOR(3 downto 0);
              JumpAddr : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    component Decoder3to8
        Port (En : in STD_LOGIC;
              A  : in STD_LOGIC_VECTOR(2 downto 0);
              Y  : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    component RegisterBank
        Port (Clk, Reset : in STD_LOGIC;
              RegEn  : in STD_LOGIC_VECTOR(7 downto 0);
              DataIn : in STD_LOGIC_VECTOR(3 downto 0);
              R0out, R1out, R2out, R3out,
              R4out, R5out, R6out, R7out : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    component Mux8way4bit
        Port (D0,D1,D2,D3,D4,D5,D6,D7 : in STD_LOGIC_VECTOR(3 downto 0);
              Sel : in STD_LOGIC_VECTOR(2 downto 0);
              Y   : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    component AddSub4bit
        Port (A, B   : in  STD_LOGIC_VECTOR(3 downto 0);
              AddSub : in  STD_LOGIC;
              Result : out STD_LOGIC_VECTOR(3 downto 0);
              Carry, Overflow, Zero : out STD_LOGIC);
    end component;
    component Mux2way4bit
        Port (D0, D1 : in STD_LOGIC_VECTOR(3 downto 0);
              Sel : in STD_LOGIC;
              Y   : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    component SevenSegDisplay
        Port (Num : in STD_LOGIC_VECTOR(3 downto 0);
              Seg : out STD_LOGIC_VECTOR(6 downto 0);
              AN  : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    signal slow_clk     : STD_LOGIC;
    signal PC_current   : STD_LOGIC_VECTOR(2 downto 0);
    signal PC_plus1     : STD_LOGIC_VECTOR(2 downto 0);
    signal PC_next      : STD_LOGIC_VECTOR(2 downto 0);
    signal Instr        : STD_LOGIC_VECTOR(11 downto 0);
    signal RegSel_A     : STD_LOGIC_VECTOR(2 downto 0);
    signal RegSel_B     : STD_LOGIC_VECTOR(2 downto 0);
    signal LoadSel      : STD_LOGIC;
    signal AddSubSel    : STD_LOGIC;
    signal ImmVal       : STD_LOGIC_VECTOR(3 downto 0);
    signal JumpFlag     : STD_LOGIC;
    signal JumpAddr     : STD_LOGIC_VECTOR(2 downto 0);
    signal RegWrite     : STD_LOGIC;
    signal RegEn        : STD_LOGIC_VECTOR(7 downto 0);
    signal R0, R1, R2, R3 : STD_LOGIC_VECTOR(3 downto 0);
    signal R4, R5, R6, R7 : STD_LOGIC_VECTOR(3 downto 0);
    signal ALU_A        : STD_LOGIC_VECTOR(3 downto 0);
    signal ALU_B        : STD_LOGIC_VECTOR(3 downto 0);
    signal ALU_A_final  : STD_LOGIC_VECTOR(3 downto 0);
    signal ALU_B_final  : STD_LOGIC_VECTOR(3 downto 0);
    signal ALU_result   : STD_LOGIC_VECTOR(3 downto 0);
    signal ALU_carry    : STD_LOGIC;
    signal ALU_ovf      : STD_LOGIC;
    signal ALU_zero     : STD_LOGIC;
    signal DataBus      : STD_LOGIC_VECTOR(3 downto 0);
    signal JumpReg      : STD_LOGIC_VECTOR(3 downto 0);
    signal Jump         : STD_LOGIC;

begin

    -- 1. Slow Clock
    -- DIVIDER = 5 for simulation (committed value, per submission spec)
    -- Override to 100_000_000 when generating the board bitstream (2-sec ticks)
    SC: SlowClock
        generic map (DIVIDER => 5)
        port map (Clk_in => Clk_100MHz, Clk_out => slow_clk);

    -- 2. Program Counter
    PC: ProgramCounter
        port map (Clk => slow_clk, Reset => Reset,
                  D => PC_next, Q => PC_current);

    -- 3. PC + 1
    PC_INC: Adder3bit
        port map (A => PC_current, B => "001", Result => PC_plus1);

    -- 4. Program ROM: fetch instruction at PC_current
    ROM: ProgramROM
        port map (Addr => PC_current, Data => Instr);

    -- 5. Instruction Decoder
    ID: InstructionDecoder
        port map (Instr => Instr,
                  RegSel_A => RegSel_A, RegSel_B => RegSel_B,
                  LoadSel => LoadSel, AddSubSel => AddSubSel,
                  ImmVal => ImmVal, JumpFlag => JumpFlag,
                  JumpAddr => JumpAddr, RegWrite => RegWrite);

    -- 6. Register Enable: 3-to-8 decoder produces one-hot enable
    DEC: Decoder3to8
        port map (En => RegWrite, A => RegSel_A, Y => RegEn);

    -- 7. Register Bank
    RB: RegisterBank
        port map (Clk => slow_clk, Reset => Reset,
                  RegEn => RegEn, DataIn => DataBus,
                  R0out=>R0, R1out=>R1, R2out=>R2, R3out=>R3,
                  R4out=>R4, R5out=>R5, R6out=>R6, R7out=>R7);

    -- 8. Operand A Mux: pick Ra
    MUX_A: Mux8way4bit
        port map (D0=>R0, D1=>R1, D2=>R2, D3=>R3,
                  D4=>R4, D5=>R5, D6=>R6, D7=>R7,
                  Sel => RegSel_A, Y => ALU_A);

    -- 9. Operand B Mux: pick Rb
    MUX_B: Mux8way4bit
        port map (D0=>R0, D1=>R1, D2=>R2, D3=>R3,
                  D4=>R4, D5=>R5, D6=>R6, D7=>R7,
                  Sel => RegSel_B, Y => ALU_B);

    -- 10a. NEG fix Mux on A:
    --      Normal (AddSubSel=0): ALU_A_final = ALU_A (= Ra)
    --      NEG    (AddSubSel=1): ALU_A_final = "0000"  (so 0 - Ra = -Ra)
    NEG_MUX_A: Mux2way4bit
        port map (D0 => ALU_A, D1 => "0000",
                  Sel => AddSubSel, Y => ALU_A_final);

    -- 10b. NEG fix Mux on B:
    --      Normal (AddSubSel=0): ALU_B_final = ALU_B (= Rb)
    --      NEG    (AddSubSel=1): ALU_B_final = ALU_A (= Ra)
    NEG_MUX_B: Mux2way4bit
        port map (D0 => ALU_B, D1 => ALU_A,
                  Sel => AddSubSel, Y => ALU_B_final);

    -- 11. ALU
    ALU: AddSub4bit
        port map (A => ALU_A_final, B => ALU_B_final,
                  AddSub => AddSubSel,
                  Result => ALU_result,
                  Carry  => ALU_carry,
                  Overflow => ALU_ovf,
                  Zero => ALU_zero);

    -- 12. Data Bus Mux: select between ALU result (ADD/NEG) and immediate (MOVI)
    DATA_MUX: Mux2way4bit
        port map (D0 => ALU_result, D1 => ImmVal,
                  Sel => LoadSel, Y => DataBus);

    -- 13. Jump check: select register to check for JZR
    JUMP_MUX: Mux8way4bit
        port map (D0=>R0, D1=>R1, D2=>R2, D3=>R3,
                  D4=>R4, D5=>R5, D6=>R6, D7=>R7,
                  Sel => RegSel_A, Y => JumpReg);

    Jump <= JumpFlag AND
            (NOT JumpReg(0)) AND (NOT JumpReg(1)) AND
            (NOT JumpReg(2)) AND (NOT JumpReg(3));

    -- 14. PC Next mux
    PC_MUX: Mux2way3bit
        port map (D0 => PC_plus1, D1 => JumpAddr,
                  Sel => Jump, Y => PC_next);

    -- 15. Outputs
    --   LD0-LD3 = R7 (lab spec page 4: result on LD0..LD3)
    --   LD13    = Overflow (bonus signed-overflow indicator, not required by spec)
    --   LD14    = Zero  (lab spec page 4: zero flag)
    --   LD15    = Carry (lab spec page 4: carry flag)
    --   LD4-LD12 = unused (always 0)
    LED(3 downto 0)  <= R7;
    LED(13)          <= ALU_ovf;
    LED(14)          <= ALU_zero;
    LED(15)          <= ALU_carry;
    LED(12 downto 4) <= (others => '0');

    DISP: SevenSegDisplay
        port map (Num => R7, Seg => Seg, AN => AN);

end Behavioral;