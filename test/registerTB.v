`timescale 1ns / 1ps
module register_tb;

    reg clk;
    reg rst;
    reg we;
    reg d_1;
    wire q_1;
    reg [2:0] d_3;
    wire [2:0] q_3;
    reg [7:0] d_8;
    wire [7:0] q_8;

    register #(.WIDTH(1)) reg_unit_1 (
        .clk(clk),
        .rst(rst),
        .we(we),
        .d(d_1),
        .q(q_1)
    );

    register #(.WIDTH(3)) reg_unit_3 (
        .clk(clk),
        .rst(rst),
        .we(we),
        .d(d_3),
        .q(q_3)
    );

    register #(.WIDTH(8)) reg_unit_8 (
        .clk(clk),
        .rst(rst),
        .we(we),
        .d(d_8),
        .q(q_8)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end 

    initial begin
        $dumpfile("registerTB.vcd");
        $dumpvars(0, register_tb);
    end

    initial begin
        // Test reset
        rst = 1; we = 0; d_1 = 1'b1; d_3 = 3'b111; d_8 = 8'b11111111; #10;
        if (q_1 != 1'b0 || q_3 != 3'b000 || q_8 != 8'b00000000) begin
            $display("Test Case 1 Failed");
        end else begin
            $display("Test Case 1 Passed");
        end

        // Test loading values (we high)
        rst = 0; we = 1; #10;
        if (q_1 != 1'b1 || q_3 != 3'b111 || q_8 != 8'b11111111) begin
            $display("Test Case 2 Failed");
        end else begin
            $display("Test Case 2 Passed");
        end

        // Test loading values (we low)
        we = 0; d_1 = 1'b0; d_3 = 3'b010; d_8 = 8'b01010101; #10;
        if (q_1 != 1'b1 || q_3 != 3'b111 || q_8 != 8'b11111111) begin
            $display("Test Case 3 Failed");
        end else begin
            $display("Test Case 3 Passed");
        end

        // Test loading values (we high)
        we = 1; d_1 = 1'b1; d_3 = 3'b101; d_8 = 8'b10101010; #10;
        if (q_1 != 1'b1 || q_3 != 3'b101 || q_8 != 8'b10101010) begin
            $display("Test Case 4 Failed");
        end else begin
            $display("Test Case 4 Passed");
        end

        // Test reset
        rst = 1; we = 1; d_1 = 1'b1; d_3 = 3'b111; d_8 = 8'b11111111; #10;
        if (q_1 != 1'b0 || q_3 != 3'b000 || q_8 != 8'b00000000) begin
            $display("Test Case 5 Failed");
        end else begin
            $display("Test Case 5 Passed");
        end

         
        $finish;
    end
endmodule