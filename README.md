# 8-bit CPU

## Table of Contents
* [Overview](#overview)
* [Toolchain](#toolchain)
* [Instruction Set Architecture](#instruction-set-architecture)
* [CPU Schematic](#cpu-schematic)
* [Getting Started](#getting-started)
* [Writing and Running Programs](#writing-and-running-programs)
* [Viewing Simulations](#viewing-simulations)

## Overview
This repository contains a custom-designed 8-bit multi-cycle CPU implemented in Verilog, built from the ground up. The verilog design is written at the Register Transfer Level (RTL), with each instruction executing in four clock cycles with finite state machine (FSM) control.

**Features**
- Custom Instruction Set Architecture (ISA) implemented on a Von Neumann architecture
- Modular datapath including:
  - Arithmetic Logic Unit (ALU)
  - Program Counter (PC)
  - Instruction Register (IR)
  - Two general-purpose registers
  - Unified memory interface
- Simple assembler to convert assembly programs into machine code
- Makefile-based simulation workflow using Icarus Verilog and GTKWave

## Toolchain
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

*Click the image above to open the full ISA specification.*

## CPU Schematic
<p align = "center">
  <br>
  <a href="./docs/8_bit_cpu_schematic.png">
    <img src="./docs/8_bit_cpu_schematic.png" width="900" alt="Schematic">
  </a>
  <br>
</p>

*Click the image above to open the schematic in full resolution.*

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
Write a program using the [documented ISA](#instruction-set-architecture).

### 2. Assemble the Program
Run the assembler:
```bash
python3 assembler.py
```
When prompted:
1. Enter the name of the source file (e.g. `example.txt`)
2. Enter the name of the output binary file, ensuring it ends with `.b` (e.g. `example.b`)
After assembly, inspect the generated `.b` file and note the line number of the final instruction.

### 3. Load the Program into Memory
Open the memory module:
```bash
code ../design/memory.v
```
Locate the `$readmemb` line and update it as follows:
- Replace `test1.b` with your program file (e.g. `example.b`)
- Replace 15 with one less than the number of lines in your binary file (e.g. if the last line is line 18, use `17`)

Example:
```verilog
$readmemb("../programs/example.b", mem, 8'd0, 8'd17);
```

### 4. Run the Program
Navigate to the testing directory and run:
```bash
cd ../testing
make
```
This will:
- Compile the CPU and testbench
- Run the simulation
- Generate and open the waveform file

You can view both the console output and GTKWave waveforms to verify program execution.

## Viewing Simulations
Navigate to the testing directory:
```bash
cd testing
```
### Full Program Simulation
```bash
make
```
### Component-Level Simulations
#### Adder
```bash
make adder
```
#### ALU 
```bash
make alu
```
#### Control Module
```bash
make ctrl_reset
make ctrl_fetch
make ctrl_decode
make ctrl_execute
make ctrl_memory
make ctrl_writeback
make ctrl_halt
make ctrl_idle
```
#### Memory
```bash
make memory
```
#### Memory Load Test
Ensure the `$readmemb` line is:
```verilog
$readmemb("../programs/test1.b", mem, 8'd0, 8'd15);
```
Then run:
```bash
make memory_load
```
#### Multiplexer
```bash
make mux
```
#### Register
```bash
make register
```
#### Zero Extender
```bash
make zext
```
---
#### Clean up simulation files:
```bash
make clean
```
---





