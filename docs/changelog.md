12/23/2025
- Added updated schematic
- Updated documentation (description, how to use, README organization)

12/22/2025
- Validated full function of CPU through the programs that exhaustively tested every instruction and directly tested consecutive load and store operations 
- Verified third full program execution (test3)
- Verified second full program execution (test2)
- Verified first full program execution (test1)
- Fixed race condition between Memory Unit and Instruction Register after a JUMP or JUMPz instruction by adding an IDLE state after JUMP and JUMPz instructions to allow memory data output to settle
- Fixed assembler not including offset for JUMP and JUMPz instructions in the binary file output

12/21/2025
- Fixed race condition between Memory Unit and Instruction Register after a STORE instruction by adding an IDLE state after STORE instructions to allow memory data output to settle
- Added simple assembler to convert text to binary instructions
- Added complete Instruction Set Architecture (ISA) manual

12/20/2025
- Verified basic module function
- Verified control unit function through exhaustive testing
- Verified correct operation for program with only ALU operations

12/19/2025
- Determined that the cpu module v1 design was not modular enough, only an alu and memory unit were used inside of the cpu modue which left the cpu module to define all the control and difficult to understand
- Created all modules to be used in the cpu module v2 desgin

12/18/2025
- Changed OUTPUT instruction to HALT
- Tested cpu module v1s

12/17/2025
- Created memory module
- Completeed cpu module v1

12/16/2025
- Created an ALU module
- Created register module
- Began creating cpu module v1
