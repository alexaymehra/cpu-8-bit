`timescale 1ns / 1ps
module memory #(
    parameter ADDR_WIDTH = 8,      // Address width (number of address bits)
    parameter DATA_WIDTH = 8       // Data width (number of data bits)
)(
    input wire clk,                                // Clock signal
    input wire we,                                 // Write enable
    input wire [ADDR_WIDTH-1:0] addr,              // Address input
    input wire [DATA_WIDTH-1:0] din,               // Data input
    output reg [DATA_WIDTH-1:0] dout               // Data output
);

    reg [DATA_WIDTH-1:0] memory [(2**ADDR_WIDTH)-1:0];

    always @(posedge clk) begin
        if (we) begin
            memory[addr] <= din;
        end
        dout <= memory[addr];
    end
endmodule