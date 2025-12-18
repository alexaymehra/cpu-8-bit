`timescale 1ns / 1ps
module cpu_tb;

    // Testbench Signals
    reg clk;
    reg reset;
    wire halt;

    // Instantiate the CPU
    cpu uut (
        .clk(clk),
        .reset(reset),
        .halt(halt)
    );

    initial begin
        $dumpfile("cpuTB.vcd");
        $dumpvars(0, cpu_tb);
    end

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Preload some instructions/data into memory
        uut.mem_unit.mem[8'h00] = 8'b01100011;  // LOAD A, PC+3
        uut.mem_unit.mem[8'h01] = 8'b01110011;  // LOAD B, PC+3
        uut.mem_unit.mem[8'h02] = 8'b00000100;  // ADD A, A, B
        uut.mem_unit.mem[8'h03] = 8'b11100000;  // HALT
        uut.mem_unit.mem[8'h04] = 8'b00000010;  // Data: 2
        uut.mem_unit.mem[8'h05] = 8'b00000001;  // Data: 1
    end

    initial begin
        $monitor("Time: %0dns, PC: %b, IR: %b, A: %b, B: %b, HALT: %b", 
                 $time, uut.pc, uut.ir, uut.a_reg, uut.b_reg, halt);
        reset = 1;
        #10;
        reset = 0;

        forever begin
            @(posedge clk);
            if (halt) begin
                $finish;
            end
        end
    end

endmodule