`timescale 1ns / 1ps
module cpu_8b_tb;
    reg clk;
    reg rst;
    wire halt;

    cpu_8b cpu_unit(
        .clk(clk),
        .rst(rst),
        .halt(halt)
    );

    initial begin
        $dumpfile("cpuTB.vcd");
        $dumpvars(0, cpu_8b_tb);
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    // Reset
    initial begin
        rst = 1;
        #20;       
        rst = 0;

        fork
            begin
                wait(halt); #20; $finish;
            end
            begin
                #1000;  // timeout
                $display("Simulation timeout"); $finish;
            end
        join
    end

    always @(posedge clk) begin
        $timeformat(-9, 0, " ns", 10);
        $display("Time %0t:", $time);
        $display("IR = %b,  PC = %b,  State = %b",
            cpu_unit.instr,
            cpu_unit.pc,
            cpu_unit.state, 
        );
        $display("A_REG = %b,  B_REG = %b",
            cpu_unit.a_reg_o,
            cpu_unit.b_reg_o
        );
        $display("MEM_ADDR = %b,  MEM_DATA = %b",
            cpu_unit.mem_addr,
            cpu_unit.mem_d_o
        );
        $display("ALU_RES = %b,  ZF = %b",
            cpu_unit.alu_res,
            cpu_unit.zf
        );
        $display("Reset = %b,  Halt = %b\n", rst, halt);
    end

endmodule
