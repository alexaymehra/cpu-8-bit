`timescale 1ns / 1ps
module memory_tb;

    // Parameters
    parameter ADDR_WIDTH = 8;
    parameter DATA_WIDTH = 8;

    // Testbench signals
    reg clk;
    reg we;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;

    // Instantiate the Device Under Test (DUT)
    memory #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        $dumpfile("memoryTB.vcd");  
        $dumpvars(0, memory_tb);    
    end

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Test sequence
    initial begin
        $monitor("Time: %0dns, WE: %b, ADDR: %h, DIN: %h, DOUT: %h", $time, we, addr, data_in, data_out);
        
        // Initialize signals
        we = 0;
        addr = 0;
        data_in = 0;

        // Wait for global reset
        #10;

        // Write data to memory
        we = 1; addr = 8'h00; data_in = 8'hA5; #10; // Write 0xA5 to address 0x00
        we = 1; addr = 8'h01; data_in = 8'h5A; #10; // Write 0x5A to address 0x01
        we = 1; addr = 8'h02; data_in = 8'hFF; #10; // Write 0xFF to address 0x02

        // Disable write enable
        we = 0; addr = 8'h00; data_in = 8'h00; #10; // Disable write
        
        // Read data from memory
        addr = 8'h00; #10; // Read from address 0x00
        if (data_out !== 8'hA5) $display("ERROR: Expected 0xA5 at address 0x00, got %h", data_out);
        addr = 8'h01; #10; // Read from address 0x01
        if (data_out !== 8'h5A) $display("ERROR: Expected 0x5A at address 0x01, got %h", data_out);
        addr = 8'h02; #10; // Read from address 0x02
        if (data_out !== 8'hFF) $display("ERROR: Expected 0xFF at address 0x02, got %h", data_out);

        $finish;
    end
endmodule