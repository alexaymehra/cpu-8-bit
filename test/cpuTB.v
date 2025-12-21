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

    // VCD dump
    initial begin
        $dumpfile("cpuTB.vcd");
        $dumpvars(0, cpu_8b_tb);
    end

    // Clock generator
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    // Reset and simulation control
    initial begin
        rst = 1;
        #20;       // assert reset for 1 full clock period
        rst = 0;

        // Monitor IR and PC every clock
        forever @(posedge clk) begin
            $display("Time %0t: IR = %b, PC = %b, Halt = %b", $time,
                     cpu_unit.instruction_register.q,
                     cpu_unit.program_counter.q,
                     halt);
        end
    end

    // Stop simulation when halted or timeout
    initial begin
        fork
            begin
                wait(halt);
                #10; $finish;
            end
            begin
                #1000;  // timeout
                $display("Simulation timeout"); $finish;
            end
        join
    end

endmodule
