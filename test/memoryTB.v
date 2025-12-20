`timescale 1ns / 1ps
module memory_tb;

    reg clk;
    reg we;
    reg [7:0] addr;
    reg [7:0] d_i;
    wire [7:0] d_o;

    memory_256x8 mem_unit (
        .clk(clk),
        .we(we),
        .addr(addr),
        .d_i(d_i),
        .d_o(d_o)
    );

    initial begin
        $dumpfile("memoryTB.vcd");  
        $dumpvars(0, memory_tb);    
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor("Time: %0dns, we: %b, addr: %h, d_i: %h, d_o: %h", $time, we, addr, d_i, d_o);
        
        we = 0; addr = 0; d_i = 0; #10;

        we = 1; addr = 8'h00; d_i = 8'hA5; #10;     // Write 0xA5 to address 0x00
        we = 1; addr = 8'h01; d_i = 8'h5A; #10;     // Write 0x5A to address 0x01
        we = 1; addr = 8'h02; d_i = 8'hFF; #10;     // Write 0xFF to address 0x02

        we = 0; addr = 8'h00; d_i = 8'h00; #10;     // Disable write
        
        addr = 8'h00; #10; 
        if (d_o != 8'hA5) $display("Test Case 1 Failed");
        else $display("Test Case 1 Passed");

        addr = 8'h01; #10; 
        if (d_o !== 8'h5A) $display("Test Case 2 Failed");
        else $display("Test Case 2 Passed");

        addr = 8'h02; #10; 
        if (d_o !== 8'hFF) $display("Test Case 3 Failed");
        else $display("Test Case 3 Passed");

        $finish;
    end
endmodule