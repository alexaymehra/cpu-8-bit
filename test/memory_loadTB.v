`timescale 1ns / 1ps
module memory_load_tb;

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
        $dumpfile("memory_loadTB.vcd");  
        $dumpvars(0, memory_load_tb);    
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin        
        we = 0; addr = 8'h00; d_i = 8'b00000000; #10;

        if (d_o != 8'b00000000) 
            $display("Test 1 Failed: Got %b", d_o);
        else
            $display("Test 1 Passed");

        addr = 8'h01; #10;
        if (d_o != 8'b00111100) 
            $display("Test 2 Failed: Got %b", d_o);
        else
            $display("Test 2 Passed"); 
        
        addr = 8'h02; #10;
        if (d_o != 8'b11111111) 
            $display("Test 3 Failed: Got %b", d_o);
        else
            $display("Test 3 Passed"); 
        
        $finish;
    end
endmodule