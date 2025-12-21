module cpu_8b(
    input wire clk,
    input wire rst,
    output wire halt
);

    wire mem_we;
    wire [7:0] mem_addr;
    wire [7:0] mem_d_i;
    wire [7:0] mem_d_o;

    wire [2:0] alu_opcode;
    wire [7:0] alu_a;
    wire [7:0] alu_b;

    wire a_we;
    wire [7:0] a_reg_i;
    wire [7:0] a_reg_o;

    wire b_we;
    wire [7:0] b_reg_i;
    wire [7:0] b_reg_o;

    wire alu_we;
    wire [7:0] alu_res_next;
    wire [7:0] alu_res;

    wire zf_we;
    wire zf_next;
    wire zf;

    wire ir_we;
    wire [7:0] instr;

    wire [2:0] next_state;
    wire [2:0] state;

    wire pc_we;
    wire [7:0] pc_next;
    wire [7:0] pc;

    wire alu_sel_a;

    wire alu_sel_b;

    wire a_sel;

    wire b_sel;

    wire mem_sel;

    wire [7:0] offset_addr;
    wire addr_sel;

    wire [7:0] addr_offset_zext;

    wire [3:0] addr_offset;

    wire [3:0] pc_offset;
    wire [7:0] pc_offset_zext;

    wire [7:0] inc_pc;
    wire [7:0] new_pc;
    wire pc_sel;

    wire [7:0] jmp_reg_val;

    wire pc_jmp_sel;

    control_unit cpu_control(
        .instr(instr),
        .state(state),
        .zf(zf),
        .reset(rst),
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

    alu alu_unit(
        .opcode(alu_opcode),
        .a(alu_a),
        .b(alu_b),
        .y(alu_res_next),
        .zf(zf_next)
    );

    memory_256x8 mem_unit(
        .clk(clk),
        .we(mem_we),
        .addr(mem_addr),
        .d_i(mem_d_i),
        .d_o(mem_d_o)
    );

    register #(.WIDTH(8)) a_register(
        .clk(clk),
        .rst(rst),
        .we(a_we),
        .d(a_reg_i),
        .q(a_reg_o)
    );

    register #(.WIDTH(8)) b_register(
        .clk(clk),
        .rst(rst),
        .we(b_we),
        .d(b_reg_i),
        .q(b_reg_o)
    );

    register #(.WIDTH(8)) alu_register(
        .clk(clk),
        .rst(rst),
        .we(alu_we),
        .d(alu_res_next),
        .q(alu_res)
    );

    register #(.WIDTH(1)) zf_register(
        .clk(clk),
        .rst(rst),
        .we(zf_we),
        .d(zf_next),
        .q(zf)
    );

    register #(.WIDTH(8)) instruction_register(
        .clk(clk),
        .rst(rst),
        .we(ir_we),
        .d(mem_d_o),
        .q(instr)
    );

    register #(.WIDTH(3)) state_register(
        .clk(clk),
        .rst(rst),
        .we(1'b1),
        .d(next_state),
        .q(state)
    );

    register #(.WIDTH(8)) program_counter(
        .clk(clk),
        .rst(rst),
        .we(pc_we),
        .d(pc_next),
        .q(pc)
    );

    mux_2to1 alu_a_mux(
        .in0(a_reg_o),
        .in1(b_reg_o),
        .sel(alu_sel_a),
        .out(alu_a)
    );

    mux_2to1 alu_b_mux(
        .in0(a_reg_o),
        .in1(b_reg_o),
        .sel(alu_sel_b),
        .out(alu_b)
    );

    mux_2to1 a_register_mux(
        .in0(mem_d_o),
        .in1(alu_res),
        .sel(a_sel),
        .out(a_reg_i)
    );

    mux_2to1 b_register_mux(
        .in0(mem_d_o),
        .in1(alu_res),
        .sel(b_sel),
        .out(b_reg_i)
    );

    mux_2to1 mem_data_mux(
        .in0(a_reg_o),
        .in1(b_reg_o),
        .sel(mem_sel),
        .out(mem_d_i)
    );

    mux_2to1 mem_addr_mux(
        .in0(pc),
        .in1(offset_addr),
        .sel(addr_sel),
        .out(mem_addr)
    );

    adder addr_adder(
        .a(addr_offset_zext),
        .b(pc),
        .sum(offset_addr)
    );

    zext addr_zext(
        .in(addr_offset),
        .out(addr_offset_zext)
    );

    zext pc_zext(
        .in(pc_offset),
        .out(pc_offset_zext)
    );

    mux_2to1 pc_mux(
        .in0(inc_pc),
        .in1(new_pc),
        .sel(pc_sel),
        .out(pc_next)
    );

    adder inc_pc_adder(
        .a(pc),
        .b(8'b00000001),
        .sum(inc_pc)
    );

    adder new_pc_adder(
        .a(pc_offset_zext),
        .b(jmp_reg_val),
        .sum(new_pc)
    );

    mux_2to1 jump_mux(
        .in0(a_reg_o),
        .in1(b_reg_o),
        .sel(pc_jmp_sel),
        .out(jmp_reg_val)
    );

endmodule