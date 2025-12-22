# 8-bit CPU
Complete 8-bit CPU with simple ISA. Von Neumann Architecture.

## Toolchain:
- **Editor:** Visual Studio Code
- **Simulation:** Icarus Verilog 12.0
- **Platform:** Windows Subsystem for Linux 2 (WSL2)

## About

<p align = "center">
  <br>
  <a href="./docs/isa_manual.pdf">
    <img src="./docs/isa_manual_cover.png" width="550" alt="Manual Preview">
  </a>
  <br>
</p>

*Click the image above to open the full PDF specification.*

## Todo
- Write test programs for CPU module
- Verify correction function of full CPU
- Document how to use this repo
- Update and insert schematic
- Add simple compiler to turn text into binary program file

## Bug Fixes
- Fixed race condition between Memory Unit and Instruction Register after a STORE instruction. Added an IDLE state after STORE instructions to allow memory data output to settle.
