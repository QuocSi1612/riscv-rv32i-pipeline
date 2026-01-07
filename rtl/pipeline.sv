module pipeline(
  input  logic        i_clk,
  input  logic        i_rst_n,

  output logic        o_insn_vld,
  output logic        o_mispred,
  output logic [31:0] o_pc_debug
);

//--------------------------------------------------------------Wire region

  logic [31:0] pc, pc_next, pc_four;
  logic        brc_taken;
  logic        IF_mispred;
  logic [31:0] alu_data;
  logic [31:0] instruction;

//IF_ID  
  logic [31:0] ID_pc_four, ID_pc, ID_inst;
  logic        ID_mispred;

//control unit
  logic       rd_wren, insn_vld, br_un, opa_sel, opb_sel, mem_wren, rs1_en, rs2_en;
  logic [1:0] wb_sel;
  logic [3:0] alu_op;

//register file  
  logic [4:0] rs1_addr, rs2_addr, rd_addr;
  logic [31:0] rs1_data, rs2_data, wb_data;

  assign rs1_addr = ID_inst[19:15];
  assign rs2_addr = ID_inst[24:20];

//immediate  
  logic [31:0] immgen_data;

//ID_EX  
  logic        EX_mispred, EX_insn_vld;
  logic [31:0] EX_pc, EX_pc_four, EX_inst;
  logic [31:0] EX_imm_data, EX_rs1_data, EX_rs2_data;
  logic        EX_rd_wren, EX_opa_sel, EX_opb_sel, EX_mem_wren, EX_br_un;
  logic [1:0]  EX_wb_sel;
  logic [3:0]  EX_alu_op;

//BRC
  logic br_less, br_equal;

//ALU mux
  logic [31:0] operand_a, operand_b;

//EX_MEM
  logic        MEM_mispred, MEM_insn_vld, MEM_mem_wren, MEM_rd_wren;
  logic [31:0] MEM_pc, MEM_pc_four, MEM_inst;
  logic [31:0] MEM_alu_data, MEM_forward_b_data;
  logic [1:0]  MEM_wb_sel;

//LSU
  logic [31:0] ld_data;
  logic [2:0]  MEM_func3;
  assign MEM_func3 = MEM_inst[14:12];

//MEM_WB
  logic        WB_mispred, WB_insn_vld, WB_rd_wren;
  logic [31:0] WB_pc, WB_pc_four, WB_inst;
  logic [31:0] WB_alu_data, WB_ld_data;
  logic [1:0]  WB_wb_sel;

//hazard  
  logic pc_hazard_en, ID_IF_hazard_stall, ID_EX_hazard_flush, ID_EX_flush;
  assign ID_EX_flush = ID_EX_hazard_flush | brc_taken;

//forwarding
  logic [1:0] forward_a_sel, forward_b_sel;
  logic [31:0] forward_a_data, forward_b_data;

//--------------------------------------------------------------IF

  assign IF_mispred = 1'b0;   // sửa lại đúng: luôn 0 trong single-cycle

  pc PC(
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_en_pc(pc_hazard_en),
    .i_pc_next(pc_next),
    .o_pc(pc)
  );

  PC_plus_4 PC_four(
    .i_pc(pc),
    .o_pc_next(pc_four)
  );

  mux2_1 PC_select(
    .sel(brc_taken),
    .i_data_0(pc_four),
    .i_data_1(alu_data),
    .o_data(pc_next)
  );

  // FIXED: đúng port name
  imem instr_mem(
    .i_pc_addr(pc),
    .o_inst(instruction)
  );

//--------------------------------------------------------------IF_ID

  IF_ID IF_ID_reg(
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_flush(brc_taken),
    .i_stall(ID_IF_hazard_stall),

    .i_IF_mispred(IF_mispred),
    .i_IF_pc_four(pc_four),
    .i_IF_pc(pc),
    .i_IF_inst(instruction),

    .o_ID_mispred(ID_mispred),
    .o_ID_pc_four(ID_pc_four),
    .o_ID_pc(ID_pc),
    .o_ID_inst(ID_inst)
  );

//--------------------------------------------------------------ID  

  control_unit ctrl(
    .i_inst(ID_inst),
    .o_rd_wren(rd_wren),
    .o_insn_vld(insn_vld),
    .o_br_un(br_un),
    .o_opa_sel(opa_sel),
    .o_opb_sel(opb_sel),
    .o_mem_wren(mem_wren),
    .o_mem_rden(),
    .o_rs1_en(rs1_en),
    .o_rs2_en(rs2_en),
    .o_alu_op(alu_op),
    .o_wb_sel(wb_sel)
  );

  regfile reg_file(
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_rd_wren(WB_rd_wren),
    .i_rs1_addr(rs1_addr),
    .i_rs2_addr(rs2_addr),
    .i_rd_addr(rd_addr),
    .i_rd_data(wb_data),
    .o_rs1_data(rs1_data),
    .o_rs2_data(rs2_data)
  );

  immgen immediate(
    .i_inst(ID_inst),
    .o_imm(immgen_data)
  );

//--------------------------------------------------------------ID_EX

  ID_EX ID_EX_reg(
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_flush(ID_EX_flush),

    .i_ID_pc_four(ID_pc_four),
    .i_ID_pc(ID_pc),
    .i_ID_inst(ID_inst),
    .i_ID_mispred(ID_mispred),

    .o_EX_pc_four(EX_pc_four),
    .o_EX_pc(EX_pc),
    .o_EX_inst(EX_inst),
    .o_EX_mispred(EX_mispred),

    .i_ID_imm_data(immgen_data),
    .o_EX_imm_data(EX_imm_data),

    .i_ID_rs1_data(rs1_data),
    .i_ID_rs2_data(rs2_data),
    .o_EX_rs1_data(EX_rs1_data),
    .o_EX_rs2_data(EX_rs2_data),

    .i_ID_rd_wren(rd_wren),
    .i_ID_opa_sel(opa_sel),
    .i_ID_opb_sel(opb_sel),
    .i_ID_mem_wren(mem_wren),
    .i_ID_alu_op(alu_op),
    .i_ID_br_un(br_un),
    .i_ID_wb_sel(wb_sel),
    .i_ID_insn_vld(insn_vld),

    .o_EX_rd_wren(EX_rd_wren),
    .o_EX_opa_sel(EX_opa_sel),
    .o_EX_opb_sel(EX_opb_sel),
    .o_EX_mem_wren(EX_mem_wren),
    .o_EX_alu_op(EX_alu_op),
    .o_EX_br_un(EX_br_un),
    .o_EX_wb_sel(EX_wb_sel),
    .o_EX_insn_vld(EX_insn_vld)
  );

//--------------------------------------------------------------EX  

  mux4_1 forward_a(
    .sel(forward_a_sel),
    .i_data_0(EX_rs1_data),
    .i_data_1(wb_data),
    .i_data_2(MEM_alu_data),
    .i_data_3(32'b0),
    .o_data(forward_a_data)
  );

  mux4_1 forward_b(
    .sel(forward_b_sel),
    .i_data_0(EX_rs2_data),
    .i_data_1(wb_data),
    .i_data_2(MEM_alu_data),
    .i_data_3(32'b0),
    .o_data(forward_b_data)
  );

  brc branch(
    .i_br_un(EX_br_un),
    .i_rs1_data(forward_a_data),
    .i_rs2_data(forward_b_data),
    .o_br_less(br_less),
    .o_br_equal(br_equal)
  );

  brc_taken_forwarding brc_taken_unit(
    .i_inst(EX_inst),
    .i_br_less(br_less),
    .i_br_equal(br_equal),
    .brc_taken(brc_taken)
  );

  mux2_1 OPA_sel(
    .sel(EX_opa_sel),
    .i_data_0(forward_a_data),
    .i_data_1(EX_pc),
    .o_data(operand_a)
  );

  mux2_1 OPB_sel(
    .sel(EX_opb_sel),
    .i_data_0(forward_b_data),
    .i_data_1(EX_imm_data),
    .o_data(operand_b)
  );

  alu alu(
    .i_operand_a(operand_a),
    .i_operand_b(operand_b),
    .i_alu_op(EX_alu_op),
    .o_alu_data(alu_data)
  );

//--------------------------------------------------------------EX_MEM

  EX_MEM EX_MEM_m(
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),

    .i_EX_pc(EX_pc),
    .i_EX_pc_four(EX_pc_four),
    .i_EX_inst(EX_inst),
    .i_EX_mispred(EX_mispred),

    .o_MEM_pc(MEM_pc),
    .o_MEM_pc_four(MEM_pc_four),
    .o_MEM_inst(MEM_inst),
    .o_MEM_mispred(MEM_mispred),

    .i_EX_alu_data(alu_data),
    .i_EX_rs2_data(forward_b_data),

    .o_MEM_alu_data(MEM_alu_data),
    .o_MEM_rs2_data(MEM_forward_b_data),

    .i_EX_mem_wren(EX_mem_wren),
    .i_EX_rd_wren(EX_rd_wren),
    .i_EX_wb_sel(EX_wb_sel),
    .i_EX_insn_vld(EX_insn_vld),

    .o_MEM_mem_wren(MEM_mem_wren),
    .o_MEM_rd_wren(MEM_rd_wren),
    .o_MEM_wb_sel(MEM_wb_sel),
    .o_MEM_insn_vld(MEM_insn_vld)
  );

//--------------------------------------------------------------MEM

  lsu load_store_unit(
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_lsu_addr(MEM_alu_data),
    .i_st_data(MEM_forward_b_data),
    .i_lsu_wren(MEM_mem_wren),
    .i_control(MEM_func3),
    .o_ld_data(ld_data)
  );

//--------------------------------------------------------------MEM_WB

  MEM_WB MEM_WB_m(
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),

    .i_MEM_pc(MEM_pc),
    .i_MEM_pc_four(MEM_pc_four),
    .i_MEM_inst(MEM_inst),
    .i_MEM_mispred(MEM_mispred),

    .o_WB_pc(WB_pc),
    .o_WB_pc_four(WB_pc_four),
    .o_WB_inst(WB_inst),
    .o_WB_mispred(WB_mispred),

    .i_MEM_alu_data(MEM_alu_data),
    .i_MEM_ld_data(ld_data),

    .o_WB_alu_data(WB_alu_data),
    .o_WB_ld_data(WB_ld_data),

    .i_MEM_rd_wren(MEM_rd_wren),
    .i_MEM_wb_sel(MEM_wb_sel),
    .i_MEM_insn_vld(MEM_insn_vld),

    .o_WB_rd_wren(WB_rd_wren),
    .o_WB_wb_sel(WB_wb_sel),
    .o_WB_insn_vld(WB_insn_vld)
  );

//--------------------------------------------------------------WB

  mux4_1 WB_sel_mux(
    .sel(WB_wb_sel),
    .i_data_0(WB_pc_four),
    .i_data_1(WB_alu_data),
    .i_data_2(WB_ld_data),
    .i_data_3(32'b0),
    .o_data(wb_data)
  );

  assign rd_addr = WB_inst[11:7];

//--------------------------------------------------------------Hazard

  hazard_unit hazard_forwarding(
    .i_EX_inst(EX_inst),
    .i_EX_rd_wren(EX_rd_wren),

    .i_ID_inst(ID_inst),
    .i_rs1_en(rs1_en),
    .i_rs2_en(rs2_en),

    .i_WB_inst(WB_inst),
    .i_WB_rd_wren(WB_rd_wren),

    .i_MEM_inst(MEM_inst),
    .i_MEM_rd_wren(MEM_rd_wren),

    .o_pc_en(pc_hazard_en),
    .o_IF_ID_stall(ID_IF_hazard_stall),
    .o_ID_EX_flush(ID_EX_hazard_flush),
    .o_forward_a_sel(forward_a_sel),
    .o_forward_b_sel(forward_b_sel)
  );

//--------------------------------------------------------------OUTPUT

  always_ff @(posedge i_clk) begin
    if(~i_rst_n)
      o_insn_vld <= 1'b0;
    else
      o_insn_vld <= WB_insn_vld;

    o_pc_debug <= WB_pc;
    o_mispred  <= WB_mispred;
  end

endmodule
