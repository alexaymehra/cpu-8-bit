module control_unit(
    input wire [7:0] instr,         // Instruction from instruction register
    input wire [2:0] state,         // Current CPU state
    input wire zf,                  // Zero flag current value
    input wire reset,               // Reset signal
    output reg [2:0] next_state,    // Next state for the CPU
    output reg pc_we,               // Write enable for program counter
    output reg pc_sel,              // Select signal for program counter input
    output reg pc_jmp_sel,          // Select register to use for JUMP or JUMPz
    output reg [3:0] pc_offset,     // Offset for JUMP or JUMPz
    output reg addr_sel,            // Select signal for memory address input
    output reg [3:0] addr_offset,   // Offset for memory address (for LOAD and STORE)
    output reg mem_sel,             // Select register (A or B) for memory data input (for STORE)
    output reg mem_we,              // Write enable for memory
    output reg [2:0] alu_opcode,    // ALU operation code (same as instruction opcode)
    output reg alu_sel_a,           // Select signal for ALU input A
    output reg alu_sel_b,           // Select signal for ALU input B
    output reg alu_we,              // Write enable for ALU output register   
    output reg zf_we,               // Write enable for zero flag register 
    output reg ir_we,               // Write enable for instruction register
    output reg a_sel,               // Select signal for register A input (memory data or ALU output)
    output reg a_we,                // Write enable for register A
    output reg b_sel,               // Select signal for register B input (memory data or ALU output)
    output reg b_we,                // Write enable for register B
    output reg halt                 // Halt signal
);

    // Instruction Opcodes -----------------------
    localparam ADD    = 3'b000;
    localparam AND    = 3'b001;
    localparam NOT    = 3'b010;
    localparam LOAD   = 3'b011;
    localparam STORE  = 3'b100;
    localparam JUMP   = 3'b101;
    localparam JUMPz  = 3'b110;
    localparam HALT   = 3'b111;
    // -------------------------------------------

    // FSM States --------------------------------
    localparam FETCH      = 3'b000; 
    localparam DECODE     = 3'b001;
    localparam EXECUTE    = 3'b010;
    localparam MEMORY     = 3'b011;
    localparam WRITEBACK  = 3'b100;
    localparam HALT_STATE = 3'b101;
    localparam IDLE       = 3'b110;
    // -------------------------------------------
    
    always @(*) begin
        // Default values
        pc_we = 0;              // No write to PC
        pc_sel = 0;             // PC = PC + 1
        pc_jmp_sel = 0;         // Register A used for JUMP or JUMPz
        pc_offset = 4'b0000;    // No offset for PC     
        addr_sel = 0;           // Select PC value for address
        addr_offset = 4'b0000;  // No offset for address
        mem_sel = 0;            // Select register A for memory input
        mem_we = 0;             // No write to memory
        alu_opcode = 3'b000;    // ALU operation code
        alu_sel_a = 0;          // Select register A for ALU input A
        alu_sel_b = 0;          // Select register A for ALU input B
        alu_we = 0;             // No write to ALU output register
        zf_we = 0;              // Zero flag write disabled
        ir_we = 0;              // No write to IR
        a_sel = 0;              // Select memory data for register A input
        a_we = 0;               // No write to register A
        b_sel = 0;              // Select memory data for register B input
        b_we = 0;               // No write to register B
        halt = 0;               // No halt

        if (reset) begin
            next_state = FETCH;     // Next state FETCH
        end

        else begin
            case (state)
                FETCH: begin                    // Fetch instruction from memory
                    /*
                    On the rising edge of the clk:
                    If there was a JUMP or JUMPz instruction, PC becomes PC + offset
                    */
                    next_state = DECODE;        // Next state is DECODE
                    pc_we = 1;                  // Allow write to PC (PC = PC + 1)
                    ir_we = 1;                  // Allow write to IR (IR = Memory[PC])
                end

                DECODE: begin   // Determine operation to perform
                    /*
                    On the rising edge of the clk:
                    PC increments to PC + 1
                    IR = Memory[PC]
                    (pc_we is disabled)
                    (ir_we is disabled)
                    */
                    
                    case (instr[7:5])       
                        ADD, AND, NOT, JUMP, JUMPz: begin
                            next_state = EXECUTE;       
                        end

                        LOAD, STORE: begin
                            next_state = MEMORY;
                        end

                        HALT: begin
                            next_state = HALT_STATE;
                        end
                    endcase
                end

                EXECUTE: begin                          // Perform operation
                    /*
                    On the rising edge of the clk:
                    Nothing happens
                    */

                    case (instr[7:5])
                        ADD, AND: begin
                            alu_opcode = instr[7:5];    // ALU operation code
                            alu_sel_a = instr[3];       // Select ALU input A
                            alu_sel_b = instr[2];       // Select ALU input B
                            alu_we = 1;                 // Allow write to ALU output register
                            zf_we = 1;                  // Allow write to zero flag register
                            next_state = WRITEBACK;
                        end
                        NOT: begin
                            alu_opcode = instr[7:5];    // ALU operation code
                            alu_sel_a = instr[3];       // Select ALU input A
                            alu_we = 1;                 // Allow write to ALU output register
                            zf_we = 1;                  // Allow write to zero flag register
                            next_state = WRITEBACK;
                        end
                        JUMP: begin
                            pc_jmp_sel = instr[4];      // Select A or B register for JUMP
                            pc_offset = instr[3:0];     // Additional JUMP offset
                            pc_sel = 1;                 // Select jump address for PC
                            pc_we = 1;                  // Allow write to PC
                            next_state = FETCH;
                        end
                        JUMPz: begin
                            if (zf == 1) begin
                                pc_jmp_sel = instr[4];  // Select A or B register for JUMPz
                                pc_offset = instr[3:0]; // Additional JUMPz offset
                                pc_sel = 1;             // Select jumpz address for PC
                                pc_we = 1;              // Allow write to PC
                            end
                            next_state = FETCH;
                        end
                    endcase
                end

                MEMORY: begin                                   // Read from or write to memory 
                    /*
                    On the rising edge of the clk:
                    Nothing happens
                    */

                    case (instr[7:5])
                        LOAD: begin
                            addr_offset = instr[3:0];   // Set address offset
                            addr_sel = 1;               // Select PC + offset for address
                            next_state = WRITEBACK;
                        end

                        STORE: begin
                            addr_offset = instr[3:0];   // Set address offset 
                            addr_sel = 1;               // Select PC + offset for address
                            mem_sel = instr[4];         // Select register A or B for memory input
                            mem_we = 1;                 // Allow write to memory
                            next_state = IDLE;
                        end
                    endcase
                end

                WRITEBACK: begin                        // Write result to register file
                    /*
                    On the rising edge of the clk:
                    If there was ADD, AND, or NOT, the result is in the ALU output register
                    If there was LOAD, memory d_out = Memory[PC + offset]
                    */
                    
                    case (instr[7:5])
                        ADD, AND, NOT: begin
                            if (instr[4] == 0) begin
                                a_sel = 1;              // Select ALU output for register A input
                                a_we = 1;               // Allow write to register A
                            end else begin
                                b_sel = 1;              // Select ALU output for register B input
                                b_we = 1;               // Allow write to register B
                            end
                            next_state = FETCH;
                        end

                        LOAD: begin
                            // Memory data is default selected for register input
                            if (instr[4] == 0) begin
                                a_we = 1;           // Allow write to register A
                            end else begin
                                b_we = 1;           // Allow write to register B
                            end
                            next_state = FETCH;
                        end
                    endcase
                end 

                HALT_STATE: begin
                    halt = 1;
                    next_state = HALT_STATE;
                end

                IDLE: begin
                    next_state = FETCH;
                end
            endcase
        end
    end
endmodule