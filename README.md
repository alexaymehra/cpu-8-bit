# 8-bit CPU

## Table of Contents

## Overview
This repository contains a custom-designed 8-bit multi-cycle CPU implemented in Verilog, built from the ground up. The verilog design is written at the Register Transfer Level (RTL) and each instruction executes in 4 clock cycles.

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

## CPU Schematic
<p align = "center">
  <br>
  <a href="./docs/8_bit_cpu_schematic.png">
    <img src="./docs/8_bit_cpu_schematic.png" width="900" alt="Schematic">
  </a>
  <br>
</p>

*Click the image above to open the schematic in full size.*

## Getting Started
### 1. Clone the Repository
```bash
git clone https://github.com/alexaymehra/cpu-8-bit.git
cd cpu-8-bit
```

### 2. Set Up WSL (Windows Users Only)
Open PowerShell as Administrator and run:
```powershell
wsl --install
```
Restart when prompted, then open Ubuntu from the Start Menu.

### 3. Install Required Dependencies (Ubuntu / WSL)
```bash
sudo apt update
sudo apt install -y \
    iverilog \
    gtkwave \
    gcc \
    make \
    python3
```
Verify installations:
```bash
iverilog -V
gtkwave --version
gcc --version
python3 --version
```

## Writing and Running Programs
### 1. Write a Program
Navigate to the programs directory
```bash
cd programs
```
Create or edit a text file:
```bash
code example.txt
```
Write a program using the documented [ISA](#instruction_set_architecture)



