module memory #(
    parameter ADDR_WIDTH = 8,               // Address width 
    parameter DATA_WIDTH = 8                // Data width 
)(
    input wire clk,                         // Clock signal
    input wire we,                          // Write enable
    input wire [ADDR_WIDTH-1:0] addr,       // Address input
    input wire [DATA_WIDTH-1:0] data_in,    // Data input
    output reg [DATA_WIDTH-1:0] data_out    // Data output
);
    //  Data Width           Number of Addresses
    reg [DATA_WIDTH-1:0] mem [(2**ADDR_WIDTH)-1:0];

    always @(posedge clk) begin     // Synchronous read/write
        if (we) begin
            mem[addr] = data_in;    // Write-First behavior
        end
        data_out <= mem[addr];      // Updated data will be read immediately
    end
endmodule