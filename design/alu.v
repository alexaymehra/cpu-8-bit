module alu(
    input wire [2:0] opcode,        // Operation code (3 bits)
    input wire [7:0] a,             // First operand (8 bits)
    input wire [7:0] b,             // Second operand (8 bits)
    output reg [7:0] y,             // Result (8 bits)
    output reg zf,                  // Zero flag
);

    localparam ADD = 3'b000;        // ADD opcode
    localparam AND = 3'b001;        // AND opcode
    localparam NOT = 3'b010;        // NOT opcode

always @(*) begin
    zf = 0;

    case (opcode)
        ADD: begin             
            y = a + b;
        end
        AND: begin              
            y = a & b;
        end
        NOT: begin              
            y = ~a;
        end
        default: begin              // Undefined opcodes
            y = 8'b00000000;
        end
    endcase

    if (y == 8'b00000000) begin
        zf = 1;
    end
end
endmodule