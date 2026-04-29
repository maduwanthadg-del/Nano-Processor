# 💻 4-Bit Nanoprocessor in VHDL

**CS1050 — Computer Organisation and Digital Design**

**University of Moratuwa | Department of Computer Science and Engineering**

---

## What is This Project?

This project is a **4-bit nanoprocessor**, designed from scratch in VHDL and deployed on the **Digilent BASYS 3 FPGA board**. It is a working miniature CPU — built entirely from basic logic gates and flip-flops — that can fetch, decode, and execute instructions just like a real processor.

The processor runs a hard-coded program that computes **1 + 2 + 3 = 6** and displays the result on the board's LEDs and 7-segment display.

---

## The Big Picture

At its core, the nanoprocessor is a **clocked state machine** that repeats the classic CPU cycle:

```
Fetch → Decode → Execute → Write Back → Advance PC
```

Every **2 seconds** (driven by a slow clock derived from the board's 100 MHz oscillator), the processor reads one instruction from its built-in memory, figures out what to do, performs the operation, and saves the result — then moves to the next instruction.

After **8 instructions (~16 seconds)**, the answer `6` appears on the LEDs and 7-segment display, and the processor holds that result in an infinite loop.

---

## Instruction Set

The processor supports exactly **4 instructions**:

| Instruction | What it does |
|-------------|-------------|
| `MOVI R, d` | Load a constant value into a register |
| `ADD Ra, Rb` | Add register Rb into register Ra |
| `NEG R` | Negate a register (two's complement) |
| `JZR R, d` | Jump to address d if register R is zero |

Instructions are 12 bits wide. The top 2 bits are the opcode; the rest encode register selectors and immediate values.

---

## How the Program Runs

The processor executes this 8-line assembly program:

```
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

*CS1050 Lab 9–10 — Nanoprocessor Design | University of Moratuwa*
