`timescale 1ns / 1ps
module tb_control_unit;

    reg [7:0] instr;
    reg [2:0] state;
    reg zf;
    reg reset;

    wire [2:0] next_state;
    wire pc_we;
    wire pc_sel;
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
    // -------------------------------------------

    control_unit control_unit_8b (
        .instr(instr),
        .state(state),
        .zf(zf),
        .reset(reset),
        .next_state(next_state),
        .pc_we(pc_we),
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
        $dumpfile("control_unitTB.vcd");
        $dumpvars(0, tb_control_unit);
    end

    initial begin
        instr = 8'b00000000; state = FETCH; zf = 0; reset = 1; #10;
        reset = 0; #10;
        $finish;

    end

endmodule;