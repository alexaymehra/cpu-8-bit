module mux_2to1 (
    input wire [7:0] in0,   // 8-bit input 0
    input wire [7:0] in1,   // 8-bit input 1
    input wire sel,         // Selection signal (0 for in0, 1 for in1)
    output wire [7:0] out   // 8-bit output
);

    assign out = sel ? in1 : in0;
    
endmodule