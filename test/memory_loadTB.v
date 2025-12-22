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

        if (d_o != 8'b01101100) 
            $display("Test 1 Failed: Got %b", d_o);
        else
            $display("Test 1 Passed");

        addr = 8'h01; #10;
        if (d_o != 8'b00010000) 
            $display("Test 2 Failed: Got %b", d_o);
        else
            $display("Test 2 Passed"); 
        
        addr = 8'h02; #10;
        if (d_o != 8'b10011100) 
            $display("Test 3 Failed: Got %b", d_o);
        else
            $display("Test 3 Passed"); 

        addr = 8'h03; #10;
        if (d_o != 8'b01011000) 
            $display("Test 4 Failed: Got %b", d_o);
        else
            $display("Test 4 Passed"); 

        addr = 8'h04; #10;
        if (d_o != 8'b00110100) 
            $display("Test 5 Failed: Got %b", d_o);
        else
            $display("Test 5 Passed"); 

        addr = 8'h05; #10;
        if (d_o != 8'b10110110) 
            $display("Test 6 Failed: Got %b", d_o);
        else
            $display("Test 6 Passed");

        addr = 8'h06; #10;
        if (d_o != 8'b01100110) 
            $display("Test 7 Failed: Got %b", d_o);
        else
            $display("Test 7 Passed");

        addr = 8'h07; #10;
        if (d_o != 8'b01110110) 
            $display("Test 8 Failed: Got %b", d_o);
        else
            $display("Test 8 Passed");

        addr = 8'h08; #10;
        if (d_o != 8'b01001000) 
            $display("Test 9 Failed: Got %b", d_o);
        else
            $display("Test 9 Passed");
        
        addr = 8'h09; #10;
        if (d_o != 8'b00110100) 
            $display("Test 10 Failed: Got %b", d_o);
        else
            $display("Test 10 Passed");

        addr = 8'h0a; #10;
        if (d_o != 8'b11011100) 
            $display("Test 11 Failed: Got %b", d_o);
        else
            $display("Test 11 Passed");

        addr = 8'h0b; #10;
        if (d_o != 8'b00010100) 
            $display("Test 12 Failed: Got %b", d_o);
        else
            $display("Test 12 Passed");

        addr = 8'h0c; #10;
        if (d_o != 8'b11111111) 
            $display("Test 13 Failed: Got %b", d_o);
        else
            $display("Test 13 Passed");

        addr = 8'h0d; #10;
        if (d_o != 8'b00000011) 
            $display("Test 14 Failed: Got %b", d_o);
        else
            $display("Test 14 Passed");

        addr = 8'h0e; #10;
        if (d_o != 8'b00010000) 
            $display("Test 15 Failed: Got %b", d_o);
        else
            $display("Test 15 Passed");

        addr = 8'h0f; #10;
        if (d_o != 8'b00000000) 
            $display("Test 16 Failed: Got %b", d_o);
        else
            $display("Test 16 Passed");
        
        $finish;
    end
endmodule