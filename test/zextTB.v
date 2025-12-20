`timescale 1ns / 1ps
module zext_tb;

    reg [3:0] in;
    wire [7:0] out;

    zext zext_unit(
        .in(in),
        .out(out)
    );

    initial begin
        $dumpfile("zextTB.vcd");
        $dumpvars(0, zext_tb);
    end

    initial begin
        $monitor("in: %b, out: %b", in, out);

        in = 4'b0011; #10;
        if (out != 8'b00000011) $display("Test Case 1 Failed");
        else $display("Test Case 1 Passed");

        in = 4'b1100; #10
        if (out != 8'b00001100) $display("Test Case 2 Failed");
        else $display("Test Case 2 Passed");

        $finish;
    end

endmodule