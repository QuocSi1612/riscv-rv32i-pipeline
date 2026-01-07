module alu #(parameter WIDTH = 32)(
    input logic [3:0] i_alu_op,       // Tín hiệu điều khiển 4-bit
    input logic [WIDTH-1:0] i_operand_a,   // Toán hạng đầu vào 32-bit
    input logic [WIDTH-1:0] i_operand_b,   // Toán hạng đầu vào 32-bit
    output logic [WIDTH-1:0] o_alu_data    // Kết quả 32-bit
);
// biến nội lưu trữ kết quả
    logic [31:0] result_d;
    logic [31:0] add_w, sub_w, and_w, or_w, xor_w, sll_w, srl_w, sra_w, slt_w, sltu_w;
    // gọi lại module con 
	adder_32bit A0(i_operand_a, i_operand_b, add_w);
    subtractor_32bit S0(i_operand_a, i_operand_b, sub_w);
	SLT_32bit SLT0(i_operand_a, i_operand_b, slt_w);
	SLTU_32bit SLTU0(i_operand_a, i_operand_b, sltu_w);
    xor_32bit X0(i_operand_a, i_operand_b, xor_w);
	or_32bit O0(i_operand_a, i_operand_b, or_w);
	and_32bit A1(i_operand_a, i_operand_b, and_w);
    SLL_32bit SLL0(i_operand_a, i_operand_b, sll_w);
    SRL_32bit SRL0(i_operand_a, i_operand_b, srl_w);
    SRA_32bit SRA0(i_operand_a, i_operand_b, sra_w);
    always_comb begin 
        unique case (i_alu_op)
            4'b0000: result_d = add_w;         // ADD
            4'b0001: result_d = sub_w;         // SUB
            4'b0011: result_d = slt_w;         // SLT
            4'b0100: result_d = sltu_w;        // SLTU
            4'b0101: result_d = xor_w;         // XOR
            4'b1000: result_d = or_w;          // OR
            4'b1001: result_d = and_w;         // AND
            4'b0010: result_d = sll_w;         // SLL
			4'b0110: result_d = srl_w;         // SRL
			4'b0111: result_d = sra_w;         // SRA
            4'b1010: result_d = i_operand_b;   // AUIPC
            default: result_d = 32'b0;         // Mặc định
        endcase
    end 
    

assign o_alu_data = result_d; // Cập nhật kết quả



endmodule
