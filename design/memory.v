module memory_256x8 (
    input wire clk,                         // Clock signal
    input wire we,                          // Write enable
    input wire [7:0] addr,                  // Address input
    input wire [7:0] d_i,                   // Data input
    output reg [7:0] d_o                    // Data output
);

    reg [7:0] mem [(2**8)-1:0];

    always @(posedge clk) begin     // Synchronous read/write
        if (we) begin
            mem[addr] = d_i;        // Write-First behavior
        end
        d_o <= mem[addr];           // Updated data will be read immediately
    end

    initial begin
        $readmemb("../programs/test1.b", mem, 8'd0, 8'd15);
    end
endmodule