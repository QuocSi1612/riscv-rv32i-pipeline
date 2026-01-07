module SLT_32bit (
    input logic [31:0] a_i,    // Operand A (rs1)
    input logic [31:0] b_i,    // Operand B (rs2)
    output logic c_o           // Kết quả (A < B với so sánh có dấu)
);

    // Gọi lại module compare với i_signed = 1 để so sánh có dấu
    compare cmp_signed (
        .i_operand_a(a_i),
        .i_operand_b(b_i),
        .i_signed(1'b1),        // So sánh có dấu
        .o_less(c_o)
    );

endmodule
