module hazard_unit(

    // Inputs for hazard detection
    input logic  [31:0] i_EX_inst,   // EX stage instruction
    input logic          i_EX_rd_wren,
    
    input logic  [31:0] i_ID_inst,   // ID stage instruction
    input logic          i_rs1_en,  // ID stage rs1 enable
    input logic          i_rs2_en,  // ID stage rs2 enable

    input logic  [31:0] i_WB_inst,   // WB stage instruction
    input logic          i_WB_rd_wren,

    // Inputs for forwarding
    input logic  [31:0] i_MEM_inst,  // MEM stage instruction
    input logic          i_MEM_rd_wren,

    // Outputs for hazard detection
    output logic         o_pc_en,
    output logic         o_IF_ID_stall,
    output logic         o_ID_EX_flush,

    // Outputs for forwarding
    output logic [1:0]   o_forward_a_sel,
    output logic [1:0]   o_forward_b_sel

);

    // Forwarding selection parameters
    localparam [1:0] no_forward  = 2'b00,
                     mem_forward = 2'b10,
                     wb_forward  = 2'b01;

    // Internal signals for hazard detection
    logic [4:0] ID_rs1_addr, ID_rs2_addr, EX_rd_addr, MEM_rd_addr, WB_rd_addr;
    logic [6:0] EX_opcode;
    logic load_hazard, wb_hazard;

    // Internal signals for forwarding
    logic [4:0] EX_rs1_addr, EX_rs2_addr;

    // Extract register addresses and opcode
    assign ID_rs1_addr = i_ID_inst[19:15];
    assign ID_rs2_addr = i_ID_inst[24:20];
    assign EX_rs1_addr = i_EX_inst[19:15];
    assign EX_rs2_addr = i_EX_inst[24:20];
    assign EX_opcode   = i_EX_inst[6:0];
    assign EX_rd_addr  = i_EX_inst[11:7];
    assign MEM_rd_addr = i_MEM_inst[11:7];
    assign WB_rd_addr  = i_WB_inst[11:7];

    // Hazard detection logic
    assign load_hazard = (EX_opcode == 7'h3) && (EX_rd_addr != 5'b0) && 
                         ((EX_rd_addr == ID_rs1_addr && i_rs1_en) || 
                          (EX_rd_addr == ID_rs2_addr && i_rs2_en));

    assign wb_hazard = i_WB_rd_wren && (WB_rd_addr != 5'b0) &&
                       ((WB_rd_addr == ID_rs1_addr && i_rs1_en) || 
                        (WB_rd_addr == ID_rs2_addr && i_rs2_en));

    // Forwarding logic
    always_comb begin: proc_forward_detect
        // Forwarding for rs1
        if (i_MEM_rd_wren && (MEM_rd_addr != 5'b0) && (MEM_rd_addr == EX_rs1_addr)) 
            o_forward_a_sel = mem_forward;
        else if (i_WB_rd_wren && (WB_rd_addr != 5'b0) && (WB_rd_addr == EX_rs1_addr)) 
            o_forward_a_sel = wb_forward;
        else 
            o_forward_a_sel = no_forward;

        // Forwarding for rs2
        if (i_MEM_rd_wren && (MEM_rd_addr != 5'b0) && (MEM_rd_addr == EX_rs2_addr)) 
            o_forward_b_sel = mem_forward;
        else if (i_WB_rd_wren && (WB_rd_addr != 5'b0) && (WB_rd_addr == EX_rs2_addr)) 
            o_forward_b_sel = wb_forward;
        else 
            o_forward_b_sel = no_forward;
    end

    // Hazard control logic
    always_comb begin: proc_stall_flush
        if (wb_hazard) begin
            o_pc_en        = 1'b0;
            o_IF_ID_stall  = 1'b1;
            o_ID_EX_flush  = 1'b1;
        end 
        else if (load_hazard) begin
            o_pc_en        = 1'b0;
            o_IF_ID_stall  = 1'b1;
            o_ID_EX_flush  = 1'b1;
        end 
        else begin
            o_pc_en        = 1'b1;
            o_IF_ID_stall  = 1'b0;
            o_ID_EX_flush  = 1'b0;
        end
    end

endmodule
