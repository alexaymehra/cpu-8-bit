module cpu_memory(
    input wire clk,
    input wire reset
);
    reg [7:0] pc;
    reg [7:0] ir;
    reg [7:0] mar;
    reg [7:0] mdr;

    reg [7:0] pc_next;
    reg [7:0] ir_next;
    reg [7:0] mar_next;
    reg [7:0] mdr_next;

    reg mem_we;
    wire [7:0] mem_data_out;

    memory #(
        .ADDR_WIDTH(8),
        .DATA_WIDTH(8)
    ) mem_unit (
        .clk(clk),
        .we(mem_we),
        .addr(mar),
        .data_in(mdr),
        .data_out(mem_data_out)
    );

endmodule