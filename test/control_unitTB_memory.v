`timescale 1ns / 1ps
module tb_control_unit_memory;

    reg [7:0] instr;
    reg [2:0] state;
    reg zf;
    reg reset;

    wire [2:0] next_state;
    wire pc_we;
    wire pc_sel;
    wire pc_jmp_sel;
    wire [3:0] pc_offset;
    wire addr_sel;
    wire [3:0] addr_offset;
    wire mem_sel;
    wire mem_we;
    wire [2:0] alu_opcode;
    wire alu_sel_a;
    wire alu_sel_b;
    wire alu_we;
    wire zf_we;
    wire ir_we;
    wire a_sel;
    wire b_sel;
    wire b_we;
    wire halt;

    // FSM States --------------------------------
    localparam FETCH      = 3'b000; 
    localparam DECODE     = 3'b001;
    localparam EXECUTE    = 3'b010;
    localparam MEMORY     = 3'b011;
    localparam WRITEBACK  = 3'b100;
    localparam HALT_STATE = 3'b101;
    localparam IDLE       = 3'b110;
    // -------------------------------------------

    control_unit control_unit_8b (
        .instr(instr),
        .state(state),
        .zf(zf),
        .reset(reset),
        .next_state(next_state),
        .pc_we(pc_we),
        .pc_sel(pc_sel),
        .pc_jmp_sel(pc_jmp_sel),
        .pc_offset(pc_offset),
        .addr_sel(addr_sel),
        .addr_offset(addr_offset),
        .mem_sel(mem_sel),
        .mem_we(mem_we),
        .alu_opcode(alu_opcode),
        .alu_sel_a(alu_sel_a),
        .alu_sel_b(alu_sel_b),
        .alu_we(alu_we),
        .zf_we(zf_we),
        .ir_we(ir_we),
        .a_sel(a_sel),
        .a_we(a_we),
        .b_sel(b_sel),
        .b_we(b_we),
        .halt(halt)
    );

    initial begin
        $dumpfile("control_unitTB_memory.vcd");
        $dumpvars(0, tb_control_unit_memory);
    end

    integer pass_count = 0;
    integer fail_count = 0;

    task automatic check_memory; 
        input integer test_num;
        input [2:0] exp_next_state;
        input [3:0] exp_addr_offset;
        input exp_addr_sel;
        input exp_mem_sel;
        input exp_mem_we;
        integer failed;
    begin
        $display("----- Beginning Test %0d -----", test_num);

        failed = 0;

        if (next_state != exp_next_state) begin
            $display("Test %0d Failed: next_state", test_num);
            failed = 1;
        end

        if (pc_we != 0) begin
            $display("Test %0d Failed: pc_we", test_num);
            failed = 1;
        end

        if (pc_sel != 0) begin
            $display("Test %0d Failed: pc_sel", test_num);
            failed = 1;
        end

        if (pc_jmp_sel != 0) begin
            $display("Test %0d Failed: pc_jmp_sel", test_num);
            failed = 1;
        end

        if (pc_offset != 4'b0000) begin
            $display("Test %0d Failed: pc_offset", test_num);
            failed = 1;
        end

        if (addr_sel != exp_addr_sel) begin
            $display("Test %0d Failed: addr_sel", test_num);
            failed = 1;
        end

        if (addr_offset != exp_addr_offset) begin
            $display("Test %0d Failed: addr_offset", test_num);
            failed = 1;
        end

        if (mem_sel != exp_mem_sel) begin
            $display("Test %0d Failed: mem_sel", test_num);
            failed = 1;
        end

        if (mem_we != exp_mem_we) begin
            $display("Test %0d Failed: mem_we", test_num);
            failed = 1;
        end

        if (alu_opcode != 3'b000) begin
            $display("Test %0d Failed: alu_opcode", test_num);
            failed = 1;
        end

        if (alu_sel_a != 0) begin
            $display("Test %0d Failed: alu_sel_a", test_num);
            failed = 1;
        end

        if (alu_sel_b != 0) begin
            $display("Test %0d Failed: alu_sel_b", test_num);
            failed = 1;
        end

        if (alu_we != 0) begin
            $display("Test %0d Failed: alu_we", test_num);
            failed = 1;
        end

        if (zf_we != 0) begin
            $display("Test %0d Failed: zf_we", test_num);
            failed = 1;
        end

        if (ir_we != 0) begin
            $display("Test %0d Failed: ir_we", test_num);
            failed = 1;
        end

        if (a_sel != 0) begin
            $display("Test %0d Failed: a_sel", test_num);
            failed = 1;
        end

        if (a_we != 0) begin
            $display("Test %0d Failed: a_we", test_num);
            failed = 1;
        end

        if (b_sel != 0) begin
            $display("Test %0d Failed: b_sel", test_num);
            failed = 1;
        end

        if (b_we != 0) begin
            $display("Test %0d Failed: b_we", test_num);
            failed = 1;
        end

        if (halt != 0) begin
            $display("Test %0d Failed: halt", test_num);
            failed = 1;
        end

        if (failed) begin
            fail_count = fail_count + 1;
            $display("Test %0d RESULT: FAIL\n", test_num);
        end else begin
            pass_count = pass_count + 1;
            $display("Test %0d RESULT: PASS\n", test_num);
        end
    end
    endtask



    initial begin

        // Testing MEMORY
        $display("Testing MEMORY\n");
        reset = 1; #10;
        reset = 0; state = MEMORY; zf = 0;

        instr = 8'b01101111; #10;   // LOAD A, 15
        check_memory(
            1,              // test_num
            WRITEBACK,      // exp_next_state
            4'b1111,        // exp_addr_offset
            1'b1,           // exp_addr_sel
            1'b0,           // exp_mem_sel
            1'b0            // exp_mem_we
        );

        instr = 8'b01110011; #10;   // LOAD B, 3
        check_memory(
            2,              // test_num
            WRITEBACK,      // exp_next_state
            4'b0011,        // exp_addr_offset
            1'b1,           // exp_addr_sel
            1'b0,           // exp_mem_sel
            1'b0            // exp_mem_we
        );

        instr = 8'b10001111; #10;   // STORE A, 15
        check_memory(
            3,              // test_num
            IDLE,           // exp_next_state
            4'b1111,        // exp_addr_offset
            1'b1,           // exp_addr_sel
            1'b0,           // exp_mem_sel
            1'b1            // exp_mem_we
        );

        instr = 8'b10010011; #10;   // STORE B, 3
        check_memory(
            4,              // test_num
            IDLE,           // exp_next_state
            4'b0011,        // exp_addr_offset
            1'b1,           // exp_addr_sel
            1'b1,           // exp_mem_sel
            1'b1            // exp_mem_we
        );

        $display("=================================");
        $display("TEST SUMMARY");
        $display("Passed: %0d", pass_count);
        $display("Failed: %0d", fail_count);
        $display("=================================");
        $finish;

    end

endmodule;