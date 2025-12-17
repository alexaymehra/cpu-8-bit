`timescale 1ns / 1ps
module cpu (
    input wire clk,                 // Clock input
    input wire reset                // Synchronous reset
);

    reg [7:0] pc;
    reg [7:0] ir;
    reg [7:0] sr;
    reg [7:0] a_reg;
    reg [7:0] b_reg;

    wire [7:0] alu_input_a;
    wire [7:0] alu_input_b;
    wire [7:0] alu_result;

    reg mem_we;
    wire [7:0] mem_addr;
    wire [7:0] mem_din;
    wire [7:0] mem_dout;

    memory #(8, 8) mem_unit (        // 256 x 8-bit Memory
        .clk(clk),
        .we(mem_we),
        .addr(mem_addr),
        .din(mem_din),
        .dout(mem_dout)
    );

    alu #(8) alu_unit (             // ALU
        .a(alu_input_a),                 
        .b(alu_input_b),                
        .opcode(ir[7:4]),
        .result(alu_result),
        .carry_flag(sr[0]),
        .zero_flag(sr[1]),
        .overflow_flag(sr[2]),
        .sign_flag(sr[3])
    );

    always @(posedge clk) begin
        if (reset) begin
            // Reset logic
        end else begin
            // CPU operation logic

            // 1. Fetch instruction --------------------------------
            mem_we = 0;
            mem_addr = pc;
            ir = mem_dout;
            pc = pc + 1'b1;
            // -----------------------------------------------------
            
            // 2. Decode instruction -------------------------------
            case (ir[7:5])
                3'b000: begin   // ADD DST, SRC1, SRC2
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
                end

                3'b001: begin   // AND DST, SRC1, SRC2
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
                end

                3'b010: begin   // NOT DST, SRC
                    if (ir[3] == 0) begin       // choose SRC
                        alu_input_a = a_reg;
                    end else begin
                        alu_input_a = b_reg;
                    end
                end

                3'b011: begin   // LOAD DST, PC_OFFSET
                    mem_we = 0;
                    mem_addr = pc + ir[3:0];    // calculate address
                end

                3'b100: begin   // STORE SRC, PC_OFFSET
                    if (ir[4] == 0) begin       // choose SRC
                        mem_din = a_reg;
                    end else begin
                        mem_din = b_reg;
                    end
                    mem_addr = pc + ir[3:0];    // calculate address
                end

                3'b101: begin   // JUMP SRC, PC_OFFSET
                    // no preparation needed here
                end

                3'b110: begin   // BRANCH COND, SRC
                end

                3'b111: begin   // OUTPUT SRC
                    if (ir[3:0] == 4'b1111) begin
                        $finish;
                    end
                end

                default: begin
                end
            endcase
            // -----------------------------------------------------

            // 3. Execute instruction ------------------------------
            case (ir[7:5])
                3'b000, 3'b001, 3'b010: begin   // ALU operations
                    if (ir[4] == 0) begin       // choose DST
                        a_reg = alu_result;
                    end else begin
                        b_reg = alu_result;
                    end
                end

                3'b011: begin                   // LOAD
                    if (ir[4] == 0) begin       // choose DST
                        a_reg = mem_dout;
                    end else begin
                        b_reg = mem_dout;
                    end
                end

                3'b100: begin                   // STORE
                    mem_we = 1;
                end

                3'b101: begin                   // JUMP
                    if (ir[4] == 0) begin       // choose SRC & add offset
                        pc = a_reg + ir[3:0];
                    end else begin
                        pc = b_reg + ir[3:0];
                    end
                end

                3'b110: begin                   // BRANCH
                    if (sr[1] == 1) begin
                        if (ir[4] == 0) begin   // choose SRC & add offset
                            pc = a_reg + ir[3:0];
                        end else begin
                            pc = b_reg + ir[3:0];
                        end
                    end
                end

                3'b111: begin                  // OUTPUT
                    if (ir[3:0] == 4'b0000) begin
                        $display("OUTPUT A: %d", a_reg);
                    end else if (ir[3:0] == 4'b0001) begin
                        $display("OUTPUT B: %d", b_reg);
                    end
                end
            endcase
            // -----------------------------------------------------
        end
    end

endmodule