# 🚀 4-Bit Nano-Processor in VHDL

![VHDL](https://img.shields.io/badge/Language-VHDL-blue.svg)
![FPGA](https://img.shields.io/badge/FPGA-Basys%203-orange.svg)
![Vivado](https://img.shields.io/badge/Tool-Xilinx%20Vivado-red.svg)

A complete, fully functional 4-bit Nano-Processor implemented in VHDL. Designed specifically for the **Digilent Basys 3 FPGA (Xilinx Artix-7)**, this project demonstrates a structural, component-based approach to CPU design. 

The processor executes a custom hardcoded assembly program that computes `1 + 0 + 2 + 3 = 6` and outputs the final result to the board's LEDs and 7-Segment display.

---

## ✨ Features

- **Custom 4-bit ALU**: Supports Addition and 2's Complement Subtraction.
- **8 General-Purpose Registers**: `R0` to `R7`, each storing 4-bit values.
- **Custom Instruction Set**: 12-bit instruction architecture supporting `MOVI`, `ADD`, `NEG`, and `JZR`.
- **Program ROM**: Stores an 8-line assembly program.
- **Slow Execution Mode**: Runs at ~1Hz (1 instruction per second) so execution can be visually tracked by humans.
- **Visual Output**: Live register states mapped to LEDs and Hex decoded to a 7-segment display.

---

## 🕹️ Hardware Setup & I/O (Basys 3)

| Component | Pin(s) | Description |
| :--- | :--- | :--- |
| **Clock** | `W5` | 100MHz onboard oscillator (divided down to ~1Hz). |
| **Reset Button** | `U18` (BTNC) | Active-high asynchronous reset. Clears all registers and resets Program Counter. |
| **LEDs [3:0]** | `V19`, `U19`, `E19`, `U16` | Continuously displays the binary value of the accumulator (`R7`). |
| **LED [14]** | `P1` | **Zero Flag**: Lights up if the ALU result is exactly `0000`. |
| **LED [15]** | `L1` | **Overflow Flag**: Lights up if the ALU addition/subtraction overflows. |
| **7-Segment** | `W7`-`U7` | Displays the Hex/Decimal value of the accumulator (`R7`). |

---

## 💻 Instruction Set Architecture (ISA)

The processor understands 4 basic instructions, encoded in a 12-bit format: `[11:10] Opcode | [9:7] Reg B | [6:4] Reg A | [3:0] Immediate/Address`

| Opcode | Mnemonic | Operation | Description |
| :---: | :--- | :--- | :--- |
| `00` | **ADD** | `ADD Ra, Rb` | Adds Register A to Register B. Stores result in Register B. |
| `01` | **NEG** | `NEG R` | Negates the value in Register (2's complement). |
| `10` | **MOVI** | `MOVI R, d` | Loads a 4-bit immediate value `d` into Register `R`. |
| `11` | **JZR** | `JZR R, addr`| Jumps to `addr` if the value in Register `R` is zero. |

---

## 📜 The Hardcoded Program

The processor executes the following hardcoded routine from its ROM. It incrementally sums numbers and stores the running total in `R7`.

```assembly
1. MOVI R7, 1      ; Load 1 into R7
2. MOVI R1, 0      ; Load 0 into R1
3. ADD  R7, R1     ; R7 = 1 + 0 = 1
4. MOVI R1, 2      ; Load 2 into R1
5. ADD  R7, R1     ; R7 = 1 + 2 = 3
6. MOVI R1, 3      ; Load 3 into R1
7. ADD  R7, R1     ; R7 = 3 + 3 = 6  (Final result displayed)
8. JZR  R0, 7      ; Infinite halt loop (R0 is always 0)
```
*Note: Because the clock is slowed to 1Hz, it takes exactly 7 seconds to reach the final answer of `6`.*

---

## 📂 Project Architecture

Built using 18 distinct VHDL components wired structurally:

```text
📦 src/
 ┣ 📂 alu/              # Arithmetic Logic Unit (Adder, RCA, Muxes)
 ┣ 📂 decoder/          # Instruction Decoding & Program ROM
 ┣ 📂 registers/        # Register Bank, DFFs, PC System
 ┗ 📂 top/              # Top Level Integration, Slow Clock, 7-Seg Driver
```

---

## 👥 Team

| Member | Index Number | Modules Developed |
| :--- | :--- | :--- |
| **Member A** | `240361V` | ALU & Multiplexers |
| **Member B** | `240331F` | Register Bank & Program Counter |
| **Member C** | `240362B` | Program ROM & Instruction Decoder |
| **Member D** | `240390H` | Top-Level Integration, Slow Clock & Display |

*CS1050 Lab 9–10 — Nanoprocessor Design*
