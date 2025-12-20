`timescale 1ns / 1ps
module adder_tb;

    reg [7:0] a;
    reg [7:0] b;
    wire [7:0] sum;

    adder add_unit(
        .a(a),
        .b(b),
        .sum(sum)
    );

    initial begin
        $dumpfile("adderTB.vcd");
        $dumpvars(0, adder_tb);
    end

    initial begin
        $monitor("a = %b, b = %b, sum = %b", a, b, sum);
        a = 8'b10101010; b = 8'b01010101; #10;
        if (sum != 8'b11111111) $display("Test Case 1 Failed");
        else $display("Test Case 1 Passed");

        a = 8'b11111111; b = 8'b00000001; #10;
        if (sum != 8'b00000000) $display("Test Case 2 Failed");
        else $display("Test Case 2 Passed");

        a = 8'b11111111; b = 8'b01111111; #10;
        if (sum != 8'b01111110) $display("Test Case 3 Failed");
        else $display("Test Case 3 Passed");

        $finish;
    end

endmodule

