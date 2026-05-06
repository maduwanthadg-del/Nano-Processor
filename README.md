# 4-Bit Nanoprocessor in VHDL

This project implements a 4-bit nanoprocessor in VHDL, designed for the Digilent BASYS 3 FPGA board. The processor executes a simple program to compute 1 + 2 + 3 = 6 and displays the result on LEDs and 7-segment display.

## Project Structure

### Source Files (`src/`)

#### ALU (`src/alu/`)
- `Adder3bit.vhd` - 3-bit adder
- `FullAdder.vhd` - Full adder component
- `HalfAdder.vhd` - Half adder component
- `Mux2way3bit.vhd` - 2-way 3-bit multiplexer
- `Mux2way4bit.vhd` - 2-way 4-bit multiplexer
- `Mux8way4bit.vhd` - 8-way 4-bit multiplexer
- `RCA4bit.vhd` - 4-bit ripple carry adder

#### Decoder (`src/decoder/`)
- `InstructionDecoder.vhd` - Decodes instructions into control signals
- `ProgramROM.vhd` - Program memory storing the instruction set

#### Registers (`src/registers/`)
- `Decoder3to8.vhd` - 3-to-8 decoder
- `DFF.vhd` - D flip-flop
- `ProgramCounter.vhd` - Program counter
- `ProgramCounterSystem.vhd` - Program counter system
- `Reg4bit.vhd` - 4-bit register
- `RegisterBank.vhd` - Bank of 8 registers (R0-R7)

#### Top Level (`src/top/`)
- `Nanoprocessor.vhd` - Main processor module
- `SevenSegDisplay.vhd` - 7-segment display driver
- `SlowClock.vhd` - Clock divider for visible execution

### Testbenches (`testbenches/`)
- `AddSub4bit_tb.vhd` - Testbench for adder/subtractor
- `InstructionDecoder_tb.vhd` - Testbench for instruction decoder
- `Mux8way4bit_tb.vhd` - Testbench for 8-way multiplexer
- `Nanoprocessor_tb.vhd` - Testbench for the complete processor
- `ProgramCounter_tb.vhd` - Testbench for program counter
- `ProgramROM_tb.vhd` - Testbench for program ROM
- `RegisterBank_tb.vhd` - Testbench for register bank

### Constraints (`constraints/`)
- `Basys3.xdc` - FPGA pin constraints for BASYS 3 board

## Instruction Set

The processor supports 4 instructions:
- `MOVI R, d` - Load immediate value into register
- `ADD Ra, Rb` - Add Rb to Ra
- `NEG R` - Negate register (two's complement)
- `JZR R, d` - Jump if register is zero

## Program Execution

The processor runs a hardcoded program:
1. MOVI R1, 1
2. MOVI R2, 2
3. MOVI R3, 3
4. ADD R1, R2  (R1 = 3)
5. ADD R1, R3  (R1 = 6)
6. MOVI R7, 0
7. ADD R7, R1  (R7 = 6 - result on display)
8. JZR R0, 7  (infinite loop)

## Tools
- HDL: VHDL
- FPGA: Digilent BASYS 3 (Xilinx Artix-7)
- EDA: Xilinx Vivado
- Clock: 100 MHz → 0.5 Hz (slow clock for visibility)
MOVI R1, 1      ; R1 = 1
MOVI R2, 2      ; R2 = 2
MOVI R3, 3      ; R3 = 3
ADD  R1, R2     ; R1 = 1 + 2 = 3
ADD  R1, R3     ; R1 = 3 + 3 = 6
MOVI R7, 0      ; R7 = 0  (clear output register)
ADD  R7, R1     ; R7 = 0 + 6 = 6  ← result appears on LEDs
JZR  R0, 7      ; R0 is always 0, so jump back to line 7 (halt loop)
```

At tick 7 (~14 seconds in), **R7 becomes 6**, the LEDs light up to show `0110` in binary, and the 7-segment display shows **`6`**. The final `JZR` instruction keeps jumping to itself forever, freezing the display.

Pressing **BTNC** (centre button) resets the processor and restarts the computation.

---

## How It Is Built

The processor is constructed from **18 individual VHDL components**, each built and tested separately before being wired together:

- **ALU** — a 4-bit ripple-carry adder/subtractor built from half adders and full adders
- **Register Bank** — 8 × 4-bit registers (R0 is hardwired to zero; R1–R7 are writable)
- **Program Counter** — a 3-bit counter that advances each clock tick or jumps on branch
- **Program ROM** — stores the 8 machine code instructions (combinational lookup)
- **Instruction Decoder** — translates a 12-bit instruction into control signals
- **Multiplexers** — route data between components based on control signals
- **Slow Clock** — divides 100 MHz down to 0.5 Hz so execution is visible to the eye
- **7-Segment Display Driver** — converts R7's value to the correct segment pattern
- **Top-Level Module** — wires all 18 components together into a working processor

---

## Tools & Hardware

| | |
|-|-|
| **Board** | Digilent BASYS 3 (Xilinx Artix-7 FPGA) |
| **HDL** | VHDL (fully structural design) |
| **EDA Tool** | Xilinx Vivado |
| **Clock** | 100 MHz on-board oscillator → divided to 0.5 Hz |
| **Reset** | BTNC push button (active high, asynchronous) |

---

## Team

| Member | Index Number | Module |
|--------|-------------|--------|
| Member A | 240361V | ALU & Multiplexers |
| Member B | 240331F | Register Bank & Program Counter |
| Member C | 240362B | Program ROM & Instruction Decoder |
| Member D | 240390H | Top-Level Integration, Slow Clock & Display |

---

*CS1050 Lab 9–10 — Nanoprocessor Design*
