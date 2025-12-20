`timescale 1ns / 1ps
module alu_tb;

    reg [2:0] opcode;
    reg [7:0] a;
    reg [7:0] b;
    wire [7:0] y;
    wire zf;

    alu alu_unit (
        .opcode(opcode),
        .a(a),
        .b(b),
        .y(y),
        .zf(zf)
    );

    initial begin
        $dumpfile("aluTB.vcd");
        $dumpvars(0, alu_tb);
    end

    initial begin
        $monitor("opcode: %b, a: %b, b: %b, y: %b, zf: %b", opcode, a, b, y, zf);

        opcode = 3'b000; a = 8'b01010101; b = 8'b10101010; #10;
        if (y != 8'b11111111 || zf != 0) $display("Test Case 1 Failed");
        else $display("Test Case 1 Passed");

        opcode = 3'b000; a = 8'b11111111; b = 8'b00000001; #10;
        if (y != 8'b00000000 || zf != 1) $display("Test Case 2 Failed");
        else $display("Test Case 2 Passed");

        opcode = 3'b001; a = 8'b11001100; b = 8'b10101010; #10;  
        if (y != 8'b10001000 || zf != 0) $display("Test Case 3 Failed");
        else $display("Test Case 3 Passed");

        opcode = 3'b001; a = 8'b10101010; b = 8'b01010101; #10;  
        if (y != 8'b00000000 || zf != 1) $display("Test Case 4 Failed");
        else $display("Test Case 4 Passed");

        opcode = 3'b010; a = 8'b11001100; b = 8'b00000000; #10;  
        if (y != 8'b00110011 || zf != 0) $display("Test Case 5 Failed");
        else $display("Test Case 5 Passed");

        opcode = 3'b010; a = 8'b11111111; b = 8'b10101010; #10;  
        if (y != 8'b00000000 || zf != 1) $display("Test Case 6 Failed");
        else $display("Test Case 6 Passed");

        $finish;
    end
endmodule
