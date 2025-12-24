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
Write a program using the [documented ISA](#instruction-set-architecture)

### 2. Assemble the Program
Run the assembler:
```bash
python3 assembler.py
```
When prompted, enter the name of the text file you created. When prompted again, enter the create the name of the binary file, making sure it ends with `.b` (`example.b`). Then inspect the binary file to see the line number of the last line of code.

### 3. Load the Program into Memory
Open the memory design module
```bash
code ../design/memory.v
```
At the end of the file, inside of the `$readmemb$` line, replace `test1.b` with the name of your program's binary file `example.b`. Inside of the last field, replace `15` with 1 less than the number of the last line of code in your binary file (if the last line is line 18, enter 17)

###4. Run the Program
Navigate to the testing directory and run make
```bash
cd ../testing
make
```
This will:
- Compile the CPU and testbench
- Run the simulation
- Generate and open the waveoform file
You can then view the text output and waveform to see the results of the program

## Viewing Simulations
To view the test smiulations, first navigate to the testing directory
```bash
cd testing
```
### Full program simulation:
```bash
make
```
### Adder simulation:
```bash
make adder
```
### ALU simulation:
```bash
make alu
```
### Control module reset:
```bash
make ctrl_reset
```
### Control module fetch:
```bash
make ctrl_fetch
```
### Control module decode:
```bash
make ctrl_decode
```
### Control module execute:
```bash
make ctrl_execute
```
### Control module memory:
```bash
make ctrl_memory
```
### Control module writeback:
```bash
make ctrl_writeback
```
### Control module halt:
```bash
make ctrl_halt
```
### Control module idle:
```bash
make ctrl_idle
```
### Memory:
```bash
make memory
```
### Memory load:
Ensure that the `$readmemb` line is `$readmemb("../programs/test1.b", mem, 8'd0, 8'd15);` then execute the command:
```bash
make memory_load
```
### Multiplexer:
```bash
make mux
```
### Register:
```bash
make register
```
### Zero Extender:
```bash
make zext
```
##### Clean up simulation files:
```bash
make clean
```





