`timescale 1ns / 1ps
module tb_mux_2to1;

    reg [7:0] in0;
    reg [7:0] in1;
    reg sel;
    wire [7:0] out;

    mux_2to1 mux_unit(
        .in0(in0),
        .in1(in1),
        .sel(sel),
        .out(out)
    );

    initial begin
        $dumpfile("muxTB.vcd");
        $dumpvars(0, tb_mux_2to1);
    end

    initial begin
        $monitor("sel: %b, in0: %h, in1: %h, out: %h", sel, in0, in1, out);

        sel = 0; in0 = 8'b11111111; in1 = 8'b00000000; #10;
        if (out != 8'b11111111) $display("Test Case 1 Failed");
        else $display("Tese Case 1 Passed");

        sel = 1; #10;
        if (out != 8'b00000000) $display("Test Case 2 Failed");
        else $display("Tese Case 2 Passed");

        in1 = 8'b11110000; #10
        if (out != 8'b11110000) $display("Test Case 3 Failed");
        else $display("Tese Case 3 Passed");

        sel = 0; in0 = 8'b11001100; in1 = 8'b00110011; #10;
        if (out != 8'b11001100) $display("Test Case 4 Failed");
        else $display("Tese Case 4 Passed");
    end

endmodule;
