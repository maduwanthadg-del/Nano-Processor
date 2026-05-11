library IEEE;                               -- Include standard IEEE library
use IEEE.STD_LOGIC_1164.all;                -- Use standard logic types for VHDL

entity processor is                         -- Define the main processor component
	port (
		Reset : in STD_LOGIC;               -- Input button to reset the processor
		Clk : in STD_LOGIC;                 -- Main clock input from the board
		Overflow : out STD_LOGIC;           -- Output flag indicating math overflow
		Zero : out STD_LOGIC;               -- Output flag indicating math result is zero
		led : out STD_LOGIC_VECTOR (3 downto 0); -- 4 LEDs to show output data
		seg : out STD_LOGIC_VECTOR (6 downto 0); -- 7-segment display data lines
		Anode : out STD_LOGIC_VECTOR (3 downto 0) -- 7-segment display anode (digit select)
	);
end processor;                              -- End of entity definition

architecture Behavioral of processor is     -- Describe how the processor works
	component Instruction_decoder           -- Declare the Instruction Decoder machine
		port (
			Instruction_bus : in STD_LOGIC_VECTOR (11 downto 0); -- 12-bit instruction from ROM
			Jump_Check : in STD_LOGIC_VECTOR (3 downto 0);       -- Data to check if we should jump
			Immediate_val : out STD_LOGIC_VECTOR (3 downto 0);   -- Extracted number from instruction
			Load_sel : out STD_LOGIC;                            -- Selects between ALU and Immediate val
			Add_sub_sel : out STD_LOGIC;                         -- Tells ALU to add or subtract
			Reg_Sel_A : out STD_LOGIC_VECTOR (2 downto 0);       -- Selects first register to read
			Reg_Sel_B : out STD_LOGIC_VECTOR (2 downto 0);       -- Selects second register to read
			Reg_en : out STD_LOGIC_VECTOR (2 downto 0);          -- Selects register to write data to
			Jmp_flag : out STD_LOGIC;                            -- Tells PC whether to jump
			Jmp_Addr : out STD_LOGIC_VECTOR (2 downto 0)         -- Address to jump to
		);
 
	end component;                          -- End of Instruction_decoder declaration
 
	component Slow_Clk                      -- Declare the Slow Clock machine
		port (
			Clk_in : in std_logic;          -- Fast board clock input
			Clk_out : out std_logic         -- Slowed down clock output
		);
	end component;                          -- End of Slow_Clk declaration
 
 
	component MUX_2_4                       -- Declare a 2-way 4-bit multiplexer
		port (
			D0 : in STD_LOGIC_VECTOR (3 downto 0); -- First data path
			D1 : in STD_LOGIC_VECTOR (3 downto 0); -- Second data path
			S : in STD_LOGIC;                      -- Switch to choose between paths
			D_out : out STD_LOGIC_VECTOR (3 downto 0) -- Chosen data output
		);
	end component;                          -- End of MUX_2_4 declaration
 
 
	component PC_System                     -- Declare Program Counter (Bookmark)
		port (
			reset : in STD_LOGIC;           -- Reset button
			clk : in STD_LOGIC;             -- Clock to trigger next step
			jmp_addr : in STD_LOGIC_VECTOR (2 downto 0); -- Where to jump
			jmp_flag : in STD_LOGIC;        -- Should we jump?
			out_addr : out STD_LOGIC_VECTOR (2 downto 0) -- Current line number to read
		);
 
	end component;                          -- End of PC_System declaration
 
 
	component MUX_8_way_4_Bit               -- Declare an 8-way 4-bit multiplexer
		port (
			S : in STD_LOGIC_VECTOR (2 downto 0); -- 3-bit switch to choose 1 of 8 paths
			D0 : in STD_LOGIC_VECTOR (3 downto 0); -- Locker 0 data
			D1 : in STD_LOGIC_VECTOR (3 downto 0); -- Locker 1 data
			D2 : in STD_LOGIC_VECTOR (3 downto 0); -- Locker 2 data
			D3 : in STD_LOGIC_VECTOR (3 downto 0); -- Locker 3 data
			D4 : in STD_LOGIC_VECTOR (3 downto 0); -- Locker 4 data
			D5 : in STD_LOGIC_VECTOR (3 downto 0); -- Locker 5 data
			D6 : in STD_LOGIC_VECTOR (3 downto 0); -- Locker 6 data
			D7 : in STD_LOGIC_VECTOR (3 downto 0); -- Locker 7 data
			Y : out STD_LOGIC_VECTOR (3 downto 0)  -- Chosen locker's data output
		);
 
 
	end component;                          -- End of MUX_8_way_4_Bit declaration
 
	component Reg_Bank                      -- Declare the 8 Register Lockers
		port (
			Clk : in STD_LOGIC;             -- Clock to trigger writing
			Reg_sel : in STD_LOGIC_VECTOR (2 downto 0); -- Which locker to open for writing
			Input_val : in STD_LOGIC_VECTOR (3 downto 0); -- Data to save in locker
			Reset : in STD_LOGIC;           -- Clear all lockers
			Q0 : out STD_LOGIC_VECTOR (3 downto 0); -- Locker 0 contents out
			Q1 : out STD_LOGIC_VECTOR (3 downto 0); -- Locker 1 contents out
			Q2 : out STD_LOGIC_VECTOR (3 downto 0); -- Locker 2 contents out
			Q3 : out STD_LOGIC_VECTOR (3 downto 0); -- Locker 3 contents out
			Q4 : out STD_LOGIC_VECTOR (3 downto 0); -- Locker 4 contents out
			Q5 : out STD_LOGIC_VECTOR (3 downto 0); -- Locker 5 contents out
			Q6 : out STD_LOGIC_VECTOR (3 downto 0); -- Locker 6 contents out
			Q7 : out STD_LOGIC_VECTOR (3 downto 0)  -- Locker 7 contents out
		);
 
	end component;                          -- End of Reg_Bank declaration
 
	component RCA_4                         -- Declare the 4-bit Calculator (ALU)
		port (
			A : in STD_LOGIC_VECTOR (3 downto 0); -- First number
			B : in STD_LOGIC_VECTOR (3 downto 0); -- Second number
			CTR : in STD_LOGIC;                   -- 0 to add, 1 to subtract
			Overflow : out STD_LOGIC;             -- Lights up if answer is too big
			Zero : out STD_LOGIC;                 -- Lights up if answer is zero
			S : inout STD_LOGIC_VECTOR (3 downto 0) -- Answer output
		);
 
	end component;                          -- End of RCA_4 declaration
 
	component LUT_16_7                      -- Declare the Display Translator
		port (
			address : in STD_LOGIC_VECTOR (3 downto 0); -- Number to translate
			data : out STD_LOGIC_VECTOR (6 downto 0)    -- Pattern for 7-segment display
		);
 
	end component;                          -- End of LUT_16_7 declaration
 
 
	component Program_ROM                   -- Declare the Instruction Manual (ROM)
		port (
			address : in STD_LOGIC_VECTOR (2 downto 0); -- Page number
			instruction : out STD_LOGIC_VECTOR (11 downto 0) -- Code on that page
		);
 
	end component;                          -- End of Program_ROM declaration
 
 
 
	signal instruction_bus : std_logic_vector (11 downto 0); -- Wire carrying the current instruction code
	signal program_rom_address : std_logic_vector (2 downto 0); -- Wire carrying the current instruction address
	signal immediate_val : std_logic_vector (3 downto 0); -- Wire carrying extracted numbers
	signal reg_sel_a, reg_sel_b, reg_en, jmp_addr : std_logic_vector (2 downto 0); -- Wires for register and jump addresses
	signal load_sel, add_sub_sel, jmp_flag, rca_overflow, rca_sign, slow_clock_out, zero_flag : std_logic; -- 1-bit control wires
	signal q0, q1, q2, q3, q4, q5, q6, q7, mux_a_out, mux_b_out, rca_out, mux_2_4_out : std_logic_vector (3 downto 0); -- Data wires between machines
 
 
 
 
 
begin                                       -- Start connecting everything together
	Clock : Slow_clk                        -- Create the Slow_Clk machine named "Clock"
	port map(
		clk_in => clk,                      -- Plug fast clock into its input
		clk_out => slow_clock_out           -- Slow down the main board clock for the processor
	);
	PC : PC_System                          -- Create the PC_System machine named "PC"
	port map(
		reset => Reset,                     -- Connect the big red reset button
		clk => slow_clock_out,              -- Connect the slow clock
		jmp_addr => jmp_addr,               -- Connect the jump address wire from decoder
		jmp_flag => jmp_flag,               -- Connect the jump signal from decoder
		out_addr => program_rom_address     -- Output the current line number to read
	);
 
	P_ROM : Program_ROM                     -- Create the Program_ROM machine named "P_ROM"
	port map(
		address => program_rom_address,     -- Plug in the line number from PC
		instruction => instruction_bus      -- Output the 12-bit instruction code
	);
 
 
	Instruction_Decoder_0 : Instruction_Decoder -- Create the Decoder machine
	port map(
		Instruction_bus => instruction_bus, -- Plug in the instruction code
		jump_check => mux_b_out,            -- Check the data from MUX B to see if it's zero
		Immediate_val => immediate_val,     -- Output any raw numbers in the code
		Load_sel => load_sel,               -- Output signal choosing between ALU or immediate number
		Add_sub_sel => add_sub_sel,         -- Output signal choosing add or subtract
		Reg_sel_A => reg_sel_a,             -- Output the first locker to read
		Reg_sel_B => reg_sel_b,             -- Output the second locker to read
		Reg_en => reg_en,                   -- Output the locker to save data to
		jmp_flag => jmp_flag,               -- Output signal telling PC to jump
		jmp_addr => jmp_addr                -- Output where the PC should jump to
	);
 
 
 
	Register_Bank : Reg_Bank                -- Create the 8 Lockers named "Register_Bank"
	port map(
		Clk => slow_clock_out,              -- Connect the slow clock to save data
		Reg_sel => reg_en,                  -- Connect the wire saying which locker to save to
		Reset => Reset,                     -- Connect the big red reset button to clear lockers
		Input_val => mux_2_4_out,           -- Data coming back to be saved
		Q0 => q0,                           -- Outputs of all 8 lockers below
		Q1 => q1, 
		Q2 => q2, 
		Q3 => q3, 
		Q4 => q4, 
		Q5 => q5, 
		Q6 => q6, 
		Q7 => q7 
	);
 
 
	MUX_A : Mux_8_way_4_bit                 -- Create Traffic Cop A
	port map(
		S => reg_sel_a,                     -- Connect wire from decoder choosing which locker to read
		D0 => q0,                           -- Connect all 8 lockers to its inputs below
		D1 => q1, 
		D2 => q2, 
		D3 => q3, 
		D4 => q4, 
		D5 => q5, 
		D6 => q6, 
		D7 => q7, 
		Y => mux_a_out                      -- Output the chosen locker's data
	);
 
	MUX_B : Mux_8_way_4_bit                 -- Create Traffic Cop B
	port map(
		S => reg_sel_b,                     -- Connect wire from decoder choosing second locker to read
		D0 => q0,                           -- Connect all 8 lockers to its inputs below
		D1 => q1, 
		D2 => q2, 
		D3 => q3, 
		D4 => q4, 
		D5 => q5, 
		D6 => q6, 
		D7 => q7, 
		Y => mux_b_out                      -- Output the chosen locker's data
	);
 
	Adder_subtractor : RCA_4                -- Create the Calculator
	port map(
		A => mux_a_out,                     -- Put data from Traffic Cop A here
		B => mux_b_out,                     -- Put data from Traffic Cop B here
		CTR => add_sub_sel,                 -- Connect wire telling it to add or subtract
		S => rca_out,                       -- Output the answer
		Zero => Zero_flag,                  -- Output if the answer is exactly zero
		Overflow => rca_overflow            -- Output if the answer is too big
	);
 
 
 
	MUX_2_way_4_bit : MUX_2_4               -- Create the final Traffic Cop
	port map(
		D0 => rca_out,                      -- Option 0: Answer from the calculator
		D1 => immediate_val,                -- Option 1: A raw number from the instruction
		S => load_sel,                      -- The Boss (decoder) chooses which option wins
		D_Out => mux_2_4_out                -- Send the winner to the Lockers to be saved
	);
 
 
 
	LUT : LUT_16_7                          -- Create the Display Translator
	port map(
		address => q7,                      -- Give it the data from locker 7
		data => seg                         -- Send translated light pattern to the display
	);
 
 
 
	Overflow <= rca_overflow;               -- Route ALU overflow to outside pin
	led <= q7;                              -- Continuously display the value of Register 7 on the LEDs
	zero <= zero_flag;                      -- Route ALU zero flag to outside pin
	Anode <= "1110";                        -- Activate the rightmost 7-segment display digit (0 means active)
 
 
 
 
end Behavioral;                             -- End of processor design