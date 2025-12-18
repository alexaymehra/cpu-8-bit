`timescale 1ns / 1ps
module register_tb;

    // Parameters
    parameter WIDTH = 8;

    // Testbench signals
    reg clk;
    reg reset;
    reg enable;
    reg [WIDTH-1:0] d_in;
    wire [WIDTH-1:0] q_out;

    // Instantiate the Device Under Test (DUT)
    register #(
        .WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .d_in(d_in),
        .q_out(q_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end 

    initial begin
        $dumpfile("registerTB.vcd");
        $dumpvars(0, register_tb);
    end

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        enable = 0;
        d_in = 8'b00000000;

        // Release reset
        #10;
        reset = 0;

        // Test case 1: Load data when enable is high
        enable = 1;
        d_in = 8'b10101010;
        #10; // wait for one clock cycle
        if (q_out !== 8'b10101010) begin
            $display("Test case 1 failed: Expected 10101010, got %b", q_out);
        end else begin
            $display("Test case 1 passed");
        end

        // Test case 2: Disable loading, should retain previous value
        enable = 0;
        d_in = 8'b11111111; // this value should not be loaded
        #10; // wait for one clock cycle
        if (q_out !== 8'b10101010) begin
            $display("Test case 2 failed: Expected 10101010, got %b", q_out);
        end else begin
            $display("Test case 2 passed");
        end

        // Test case 3: Enable loading again with new data
        enable = 1;
        d_in = 8'b11001100;
        #10; // wait for one clock cycle
        if (q_out !== 8'b11001100) begin
            $display("Test case 3 failed: Expected 11001100, got %b", q_out);
        end else begin
            $display("Test case 3 passed");
        end

        // Finish simulation
        #10;
        $finish;
    end
endmodule