module cpu (
    input wire clk,                 // Clock input
    input wire reset                // Synchronous reset
);
    
    // FSM States --------------------------------
    #localparam FETCH_ADDR = 3'b000; 
    #localparam FETCH_WAIT = 3'b001; 
    #localparam FETCH_DATA = 3'b010;
    #localparam DECODE     = 3'b011;
    #localparam EXECUTE    = 3'b100;
    #localparam MEMORY     = 3'b101;
    #localparam WRITEBACK  = 3'b110;
    // -------------------------------------------

    // Instruction Opcodes -----------------------
    #localparam ADD    = 3'b000;
    #localparam AND    = 3'b001;
    #localparam NOT    = 3'b010;
    #localparam LOAD   = 3'b011;
    #localparam STORE  = 3'b100;
    #localparam JUMP   = 3'b101;
    #localparam JUMPz  = 3'b110;
    #localparam OUTPUT = 3'b111;
    // -------------------------------------------

    // State Variables ---------------------------
    reg [2:0] cpu_state;
    reg [2:0] next_state;
    // -------------------------------------------

    // Main Registers & Flags --------------------
    reg [7:0] pc;
    reg [7:0] ir;
    reg [7:0] a_reg;
    reg [7:0] b_reg;
    reg [7:0] mar;
    reg [7:0] mdr;
    reg zero_flag;
    reg overflow_flag;

    reg [7:0] pc_next;
    reg [7:0] ir_next;
    reg [7:0] a_reg_next;
    reg [7:0] b_reg_next;
    reg [7:0] mar_next;
    reg [7:0] mdr_next;
    reg zero_flag_next;
    reg overflow_flag_next;
    // -------------------------------------------

    // Other signals ------------------------------
    reg [7:0] alu_input_a;
    reg [7:0] alu_input_b;
    wire [7:0] alu_result;
    wire alu_zero_flag;
    wire alu_overflow_flag;

    reg mem_we;
    wire [7:0] mem_data_out;
    // -------------------------------------------

    // Main Memory Unit (256x8) ------------------
    memory #(8, 8) mem_unit (        
        .clk(clk),
        .we(mem_we),
        .addr(mar),
        .data_in(mdr),
        .data_out(mem_data_out)
    );
    // -------------------------------------------

    // Arithmetic and Logic Unit -----------------
    alu #(8) alu_unit (             
        .a(alu_input_a),                 
        .b(alu_input_b),                
        .opcode(ir[7:5]),
        .result(alu_result),
        .zero_flag(alu_zero_flag),
        .overflow_flag(alu_overflow_flag)
    );
    // -------------------------------------------

    // Next State Logic --------------------------
    always @(posedge clk) begin
        if (reset) begin
            cpu_state <= FETCH_ADDR;
            pc <= 8'b0;
            ir <= 8'b0;
            a_reg <= 8'b0;
            b_reg <= 8'b0;
            mar <= 8'b0;
            mdr <= 8'b0;
            zero_flag <= 1'b0;
            overflow_flag <= 1'b0;
        end else begin
            cpu_state <= next_state;
            pc <= pc_next;
            ir <= ir_next;
            a_reg <= a_reg_next;
            b_reg <= b_reg_next;
            mar <= mar_next;
            mdr <= mdr_next;
            zero_flag <= zero_flag_next;
            overflow_flag <= overflow_flag_next;
        end
    end
    // -------------------------------------------

    // Control and Datapath Logic ----------------
    always @(*) begin
        // Default value assignments
        next_state = cpu_state;
        pc_next = pc;
        ir_next = ir;
        a_reg_next = a_reg;
        b_reg_next = b_reg;
        mar_next = mar;
        mdr_next = mdr;
        zero_flag_next = zero_flag;
        overflow_flag_next = overflow_flag;

        mem_we = 0;
        alu_input_a = 8'b0;
        alu_input_b = 8'b0;

        case (cpu_state)
            FETCH_ADDR: begin               // Put PC address on memory bus
                mar_next = pc;
                next_state = FETCH_WAIT;
            end

            FETCH_WAIT: begin               // Wait state for memory read
                mdr_next = mem_data_out;
                next_state = FETCH_DATA;
            end

            FETCH_DATA: begin               // Read instruction from memory 
                ir_next = mdr;
                pc_next = pc + 1'b1;
                next_state = DECODE;
            end

            DECODE: begin                   // Determine which instrucion this is
                case (ir[7:5])
                    ADD, AND, NOT: begin            // ALU operations
                        next_state = EXECUTE;
                    end

                    LOAD, STORE: begin              // Memory operations
                        mar_next = pc + ir[3:0];    // calculate address
                        next_state = MEMORY;
                    end

                    JUMP, JUMPz, OUTPUT: begin      // Control operations
                        next_state = EXECUTE;
                    end

                    default: begin                  // Undefined instruction
                        next_state = FETCH_ADDR;
                    end
                endcase
            end

            EXECUTE: begin                  // Compute result or target address
                case (ir[7:5])
                    ADD, AND: begin                 // ADD, AND
                        if (ir[3] == 0) begin       // choose SRC1
                            alu_input_a = a_reg;
                        end else begin
                            alu_input_a = b_reg;
                        end

                        if (ir[2] == 0) begin       // choose SRC2
                            alu_input_b = a_reg;
                        end else begin
                            alu_input_b = b_reg;
                        end

                        next_state = WRITEBACK;
                    end

                    NOT: begin                      // NOT  
                        if (ir[3] == 0) begin       // choose SRC
                            alu_input_a = a_reg;
                        end else begin
                            alu_input_a = b_reg;
                        end

                        next_state = WRITEBACK;
                    end

                    JUMP: begin                     // JUMP
                        if (ir[4] == 0) begin       // choose SRC & add offset
                            pc_next = a_reg + ir[3:0];
                        end else begin
                            pc_next = b_reg + ir[3:0];
                        end

                        next_state = FETCH_ADDR;
                    end

                    JUMPz: begin                    // BRANCH
                        if (zero_flag == 1) begin   // If zero flag is set
                            if (ir[4] == 0) begin   // choose SRC & add offset
                                pc_next = a_reg + ir[3:0];
                            end else begin
                                pc_next = b_reg + ir[3:0];
                            end
                        end

                        next_state = FETCH_ADDR;
                    end

                    OUTPUT: begin                   // OUTPUT
                        if (ir[3:0] == 4'b111) begin    // HALT
                            $finish;
                        end else begin
                            if (ir[4] == 1'b0) begin    // choose SRC  
                                $display("OUTPUT A: %d", a_reg);
                            end else begin
                                $display("OUTPUT B: %d", b_reg);
                            end
                        end

                        next_state = FETCH_ADDR;
                    end

                    default: begin                  // Undefined instruction
                        next_state = FETCH_ADDR;
                    end
                endcase
            end

            MEMORY: begin               // Access data memory
                case (ir[7:5])
                    LOAD: begin                     // LOAD
                        mem_we = 0;
                        mdr_next = mem_data_out;
                        next_state = WRITEBACK;
                    end

                    STORE: begin                    // STORE
                        mem_we = 1;
                        if (ir[4] == 0) begin       // choose SRC
                            mdr_next = a_reg;
                        end else begin
                            mdr_next = b_reg;
                        end

                        next_state = FETCH_ADDR;
                    end
                endcase
            end

            WRITEBACK: begin            // Commit results to registers
                case(ir[7:5])
                    ADD, AND, NOT: begin            // ALU operations
                        if (ir[4] == 0) begin       // choose DEST
                            a_reg_next = alu_result;
                        end else begin
                            b_reg_next = alu_result;
                        end

                        zero_flag_next = alu_zero_flag;
                        overflow_flag_next = alu_overflow_flag;

                        next_state = FETCH_ADDR;
                    end

                    LOAD: begin                     // LOAD
                        if (ir[4] == 0) begin       // choose DEST
                            a_reg_next = mdr;
                            
                        end else begin
                            b_reg_next = mdr;
                        end

                        if (mdr == 8'b0) begin      // Update zero flag
                            zero_flag_next = 1'b1;
                        end else begin
                            zero_flag_next = 1'b0;
                        end

                        next_state = FETCH_ADDR;
                    end
                endcase
            end

        endcase

    end
    // -------------------------------------------
endmodule