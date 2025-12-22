12/21/2025
- Verified 1 full program execution (test1)
- Fixed race condition between Memory Unit and Instruction Register after a JUMP or JUMPz instruction by adding an IDLE state after JUMP and JUMPz instructions to allow memory data output to settle
- Fixed assembler not including offset for JUMP and JUMPz instructions in the binary file output
- Fixed race condition between Memory Unit and Instruction Register after a STORE instruction by adding an IDLE state after STORE instructions to allow memory data output to settle
- Added simple assembler to convert text to binary instructions
- Added complete Instruction Set Architecture (ISA) manual

12/20/2025

12/19/2025

12/18/2025

12/17/2025

12/16/2025