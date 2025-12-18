`timescale 1ns / 1ps
module alu_tb;

    // Testbench signals
    reg [2:0] opcode;
    reg [7:0] a;
    reg [7:0] b;
    wire [7:0] res;
    wire zero_flag;
    wire overflow_flag;

    // Instantiate the Device Under Test (DUT)
    alu dut (
        .opcode(opcode),
        .a(a),
        .b(b),
        .res(res),
        .zero_flag(zero_flag),
        .overflow_flag(overflow_flag)
    );

    initial begin
        $dumpfile("aluTB.vcd");
        $dumpvars(0, alu_tb);
    end

    initial begin
        // Test case 1: ADD operation without overflow
        opcode = 3'b000; // ADD
        a = 8'b00001111; // 15
        b = 8'b00000001; // 1
        #10;
        if (res != 8'b00010000 || zero_flag != 0 || overflow_flag != 0) begin
            $display("Test case 1 failed: ADD without overflow");
        end

        // Test case 2: ADD operation with overflow
        opcode = 3'b000; // ADD
        a = 8'b01111111; // 127
        b = 8'b00000001; // 1
        #10;
        if (res != 8'b10000000 || zero_flag != 0 || overflow_flag != 1) begin
            $display("Test case 2 failed: ADD with overflow");
        end

        // Test case 3: ADD operation with zero 
        opcode = 3'b000; // ADD
        a = 8'b11111111; // -1
        b = 8'b00000001; // 1
        #10;
        if (res != 8'b00000000 || zero_flag != 1 || overflow_flag != 0) begin
            $display("Test case 3 failed: ADD resulting in zero");
        end

        // Test case 4: AND operation
        opcode = 3'b001; // AND
        a = 8'b11001100; // 204
        b = 8'b10101010; // 170
        #10;  
        if (res != 8'b10001000 || zero_flag != 0 || overflow_flag != 0) begin
            $display("Test case 4 failed: AND operation");
        end              

        // Test case 5: NOT operation
        opcode = 3'b010; // NOT
        a = 8'b00001111; // 15
        b = 8'b00000000; // unused for NOT
        #10;
        if (res != 8'b11110000 || zero_flag != 0 || overflow_flag != 0) begin
            $display("Test case 5 failed: NOT operation");
        end

        $finish;
    end
endmodule
