`timescale 1ns / 1ps
module alu #(
    parameter WIDTH = 8
)(
    input wire [2:0] opcode,        // Operation code (3 bits)
    input wire [WIDTH-1:0] a,       // First operand (WIDTH bits)
    input wire [WIDTH-1:0] b,       // Second operand (WIDTH bits)
    output reg [WIDTH-1:0] res,     // Result (WIDTH bits)
    output reg zero_flag,           // Zero flag
    output reg overflow_flag        // Overflow flag
);


always @(*) begin
    // Default flag values
    zero_flag = 0;
    overflow_flag = 0;

    case (opcode)
        3'b000: begin           // ADD
            {carry_flag, res} = a + b;
            // if operands have same sign but result has different sign, overflow occured
            overflow_flag = ((a[WIDTH-1] == b[WIDTH-1]) && (res[WIDTH-1] != a[WIDTH-1]));
        end
        3'b001: begin           // AND
            res = a & b;
        end
        3'b010: begin           // NOT
            res = ~a;
        end
        default: begin          // Undefined opcodes
            res = {WIDTH{1'b0}};
        end
    endcase

    // Set zero flag
    if (res == {WIDTH{1'b0}}) begin
        zero_flag = 1;
    end
end
endmodule