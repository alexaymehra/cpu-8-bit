module register #(
    parameter WIDTH = 8
)(
    input wire clk,                 // Clock input
    input wire rst,                 // Synchronous reset (active high)
    input wire we,                  // Write enable (active high)
    input wire [WIDTH-1:0] d,       // Data input
    output reg [WIDTH-1:0] q        // Data output
);

    always @(posedge clk) begin     // Synchronous block (rising edge)
        if (rst) begin
            q <= {WIDTH{1'b0}};     // Reset output to 0
        end else if (we) begin
            q <= d;                 // Load data into register
        end
    end
endmodule