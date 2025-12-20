module zext(
    input wire [3:0] in,
    output wire [7:0] out
);

assign out = {4'b0000, in};

endmodule