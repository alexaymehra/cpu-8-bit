# 8-bit CPU
This repository contains a custom-design 8-bit multi-cycle CPU implemented in Verilog, build from the ground up. The verilog design is written at the Register Transfer Level (RTL) and each instruction executes in 4 clock cycles.

**Features**
- Custom Instruction Set Architecture (ISA) implemented on a Von Neumann architecture
- Multi-cycle instruction execution with FSM-based control
- Modular datapath including:
  - Arithmetic Logic Unit (ALU)
  - Program Counter (PC)
  - Instruction Register (IR)
  - Two general-purpose registers
  - Memory interface
- Simple assembler to convert assembly into machine code
- Makefile-based simulation workflow using Icarus Verilog and GTKWave

## Toolchain:
- **Editor:** Visual Studio Code
- **Simulation:** Icarus Verilog 12.0
- **Waveform Viewer:** GTKWave
- **Assembler:** Python
- **Platform:** Windows Subsystem for Linux 2 (WSL2)

> ⚠️ **Windows users:** This project is designed to be run in **Linux**.  
> If you are on Windows, **WSL2 is strongly recommended**.


## Instruction Set Architecture

<p align = "center">
  <br>
  <a href="./docs/isa_manual.pdf">
    <img src="./docs/isa_manual_cover.png" width="550" alt="Manual Preview">
  </a>
  <br>
</p>

*Click the image above to open the full PDF specification.*

## Schematic
<p align = "center">
  <br>
  <a href="./docs/8_bit_cpu_schematic.png">
    <img src="./docs/8_bit_cpu_schematic.png" width="900" alt="Schematic">
  </a>
  <br>
</p>

*Click the image above to open the schematic in full size.*


## Todo
- Add usage guide and polish README
