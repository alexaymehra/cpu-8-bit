# 8-bit CPU
Complete 8-bit CPU with simple ISA. Von Neumann Architecture.

## Toolchain:
- **Editor:** Visual Studio Code
- **Simulation:** Icarus Verilog 12.0
- **Platform:** Windows Subsystem for Linux 2 (WSL2)

## About
If the memory address that is decoded reads 0xFF then the CPU finishes running. 

## Todo
- Latch or recompute memory address, it can't be reset every cycle
- Store ALU results in a temporary register (or hold inputs stable / latch result)
