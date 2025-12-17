`timescale 1ns / 1ps
module cpu_8b (
    input wire clk,                 // Clock input
    input wire reset,               // Synchronous reset
    input wire [7:0] instruction,   // 8-bit instruction input
    output reg [7:0] accumulator,   // 8-bit accumulator output
    output reg zero_flag            // Zero flag output
);

endmodule