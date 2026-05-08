# 🚀 4-Bit Nano-Processor — Extended Version

![VHDL](https://img.shields.io/badge/Language-VHDL-blue.svg)
![FPGA](https://img.shields.io/badge/FPGA-Basys%203-orange.svg)
![Vivado](https://img.shields.io/badge/Tool-Xilinx%20Vivado-red.svg)
![Version](https://img.shields.io/badge/Version-Extended-green.svg)

An enhanced 4-bit Nano-Processor implemented in VHDL for the **Digilent Basys 3 FPGA (Xilinx Artix-7)**. This extended version builds on the base processor with a wider instruction set, external input support via switches, and a modular package-based architecture.

> **What does it do?** It runs a hardcoded program that computes `1 + 2 + 3 = 6` and displays the result on LEDs and a 7-segment display — one instruction per second, so you can watch it think!

---

## ✨ What's New in the Extended Version

| Feature | Base Version | Extended Version |
| :--- | :---: | :---: |
| Instruction Width | 12-bit | **13-bit** |
| Opcode Width | 2-bit (4 instructions) | **3-bit (6 instructions)** |
| Instructions | ADD, NEG, MOVI, JZR | ADD, NEG, MOVI, JZR, **INP**, **HLT** |
| External Input | ❌ | ✅ via switches + button |
| Architecture | Flat component declarations | **VHDL Packages** |
| Data Source MUX | 2-way | **3-way** (ALU / Immediate / Switches) |
| PC Address on LEDs | ❌ | ✅ LD9-LD12 |

---

## 🕹️ How to Use It on the Board

### Buttons

| Button | Location | What It Does |
| :--- | :--- | :--- |
| **BTNC** (Center) | Pin U18 | **Reset** — Press to restart the program from the beginning. All registers clear to zero. |
| **BTNR** (Right) | Pin T17 | **Input Confirm** — When the processor hits an `INP` instruction, it waits. Set your value on the switches, then press this to continue. |

### Switches (Input)

| Switch | Signal | Purpose |
| :--- | :--- | :--- |
| **SW0** | `input_switches[0]` | Input Bit 0 (LSB) |
| **SW1** | `input_switches[1]` | Input Bit 1 |
| **SW2** | `input_switches[2]` | Input Bit 2 |
| **SW3** | `input_switches[3]` | Input Bit 3 (MSB) |

> 💡 **Example:** To input the number **5** (binary `0101`), flip SW0 UP, SW1 DOWN, SW2 UP, SW3 DOWN, then press BTNR.

### LEDs (Output)

| LEDs | What They Show |
| :--- | :--- |
| **LD0 – LD3** | The current value of **Register 7** (the output register) in binary |
| **LD9 – LD12** | The current **Program Counter address** — which instruction is running |
| **LD14** | **Overflow Flag** — lights up if the ALU overflows |
| **LD15** | **Zero Flag** — lights up if the ALU result is exactly zero |

### 7-Segment Display

The **rightmost digit** of the 7-segment display continuously shows the value of Register 7 in hex (0–F). Only one digit is active (`anode = "1110"`).

---

## 💻 Instruction Set (ISA)

All instructions are **13 bits wide**: `[12:10] Opcode | [9:7] Reg B | [6:4] Reg A | [3:0] Data`

| Opcode | Name | Binary | What It Does |
| :---: | :--- | :---: | :--- |
| `000` | **ADD** | `000_RRR_RRR_0000` | Adds Register A and Register B. Result goes into Register A. |
| `001` | **NEG** | `001_RRR_000_0000` | Negates the value in the register (2's complement). |
| `010` | **MOVI** | `010_RRR_000_IIII` | Loads a 4-bit immediate value directly into the register. |
| `011` | **JZR** | `011_RRR_000_0AAA` | If the register is zero, jump to address `AAA`. Used for loops. |
| `100` | **INP** | `100_RRR_000_0000` | Reads the value from switches SW0–SW3 into the register. Processor halts until BTNR is pressed. |
| `111` | **HLT** | `111_000_000_0000` | Halts the processor. Stops the Program Counter until BTNR is pressed. |

---

## 📜 The Loaded Program

The ROM contains 8 instructions that compute `1 + 2 + 3 = 6`:

```
Address  Binary (13-bit)    Description
------   ----------------   ---------------------------------
  0      1110000000000      Setup / Initialize
  1      1001110000000      Setup / Initialize
  2      1110000000000      Setup / Initialize
  3      1001100000000      Setup / Initialize
  4      0001111100000      ADD operation
  5      1110000000000      Setup / Initialize
  6      0110000000000      JZR (conditional jump / loop)
  7      0000000000000      NOP / End
```

**Final Result:** Register 7 holds the value **6**, shown on LEDs (binary `0110`) and 7-segment display.

---

## 📂 Project Architecture

Built using **25 VHDL source files** organized into 5 component groups:

```text
📦 src/
 ┣ 📂 alu/              # Arithmetic Logic Unit (Adders, RCA, Multiplexers)
 ┣ 📂 decoder/          # Instruction Decoding & Program ROM
 ┣ 📂 registers/        # Register Bank, Program Counter, Jump Selector
 ┣ 📂 top/              # Top Level Integration, Slow Clock, 7-Seg Driver
 ┗ 📂 packages/         # VHDL Packages (Bus types, Opcodes, Component declarations)
📦 testbenches/          # Simulation testbenches for individual components
📦 constraints/          # FPGA pin assignments (Basys3.xdc)
```

---

## ⚡ Quick Start

1. Open **Xilinx Vivado** and create a new RTL project.
2. Add `src/` as design sources, `testbenches/` as simulation sources, and `constraints/Basys3.xdc` as constraints.
3. Select part **`xc7a35tcpg236-1`** (Basys 3 Artix-7).
4. Set `Nanoprocessor.vhd` (entity `Processor`) as the **top module**.
5. Click **Generate Bitstream** and program your board.
6. Press **BTNC** to reset, then watch the LEDs count up to **6**!

> ⚠️ **For simulation:** Change the counter in `SlowClock.vhd` from `50000000` to `5` so you don't wait 50 million cycles per instruction. Remember to change it back before generating the bitstream!

---
