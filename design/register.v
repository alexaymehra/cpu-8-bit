`timescale 1ns / 1ps
module register #(
    parameter WIDTH = 8
)(
    input wire clk,                 // Clock input
    input wire reset,               // Synchronous reset
    input wire enable,              // Enable signal
    input wire [WIDTH-1:0] d_in,    // data input
    output reg [WIDTH-1:0] q_out    // data output
);

    always @(posedge clk) begin
        if (reset) begin
            q_out <= {WIDTH{1'b0}}; // Reset output to 0
        end else if (enable) begin
            q_out <= d_in;          // Load data into register
        end
    end
endmodule