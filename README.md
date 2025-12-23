# 8-bit CPU
This repository contains a custom-designed 8-bit multi-cycle CPU in verilog, including:
- A custom Instruction Set Architecture that is based on Von Neumann Architecture
- Modular datapath (ALU, PC, IR, general purpose registers, and memory interface)
- An seembler to convert human-readable assembly programs into machine code
- A makefile-based test workflow using Icarus Verilog and GTKWave

## Toolchain:
- **Editor:** Visual Studio Code
- **Simulation:** Icarus Verilog 12.0
- **Platform:** Windows Subsystem for Linux 2 (WSL2)

`code`

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
