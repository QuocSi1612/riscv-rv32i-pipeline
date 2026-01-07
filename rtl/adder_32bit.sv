module adder_32bit(
    input logic [31:0] a_i,
    input logic [31:0] b_i,
    output logic [31:0] s_o,
    output logic c_o
);

    logic [31:0] c_w;  // Tạo dây nối carry giữa các full_adder

    // Thực hiện phép cộng từng bit sử dụng full adder
    full_adder A0 (a_i[0], b_i[0], 1'b0, s_o[0], c_w[0]);   // Bit 0
    full_adder A1 (a_i[1], b_i[1], c_w[0], s_o[1], c_w[1]); // Bit 1
    full_adder A2 (a_i[2], b_i[2], c_w[1], s_o[2], c_w[2]); // Bit 2
    full_adder A3 (a_i[3], b_i[3], c_w[2], s_o[3], c_w[3]); // Bit 3
    full_adder A4 (a_i[4], b_i[4], c_w[3], s_o[4], c_w[4]); // Bit 4
    full_adder A5 (a_i[5], b_i[5], c_w[4], s_o[5], c_w[5]); // Bit 5
    full_adder A6 (a_i[6], b_i[6], c_w[5], s_o[6], c_w[6]); // Bit 6
    full_adder A7 (a_i[7], b_i[7], c_w[6], s_o[7], c_w[7]); // Bit 7
    full_adder A8 (a_i[8], b_i[8], c_w[7], s_o[8], c_w[8]); // Bit 8
    full_adder A9 (a_i[9], b_i[9], c_w[8], s_o[9], c_w[9]); // Bit 9
    full_adder A10(a_i[10], b_i[10], c_w[9], s_o[10], c_w[10]); // Bit 10
    full_adder A11(a_i[11], b_i[11], c_w[10], s_o[11], c_w[11]); // Bit 11
    full_adder A12(a_i[12], b_i[12], c_w[11], s_o[12], c_w[12]); // Bit 12
    full_adder A13(a_i[13], b_i[13], c_w[12], s_o[13], c_w[13]); // Bit 13
    full_adder A14(a_i[14], b_i[14], c_w[13], s_o[14], c_w[14]); // Bit 14
    full_adder A15(a_i[15], b_i[15], c_w[14], s_o[15], c_w[15]); // Bit 15
    full_adder A16(a_i[16], b_i[16], c_w[15], s_o[16], c_w[16]); // Bit 16
    full_adder A17(a_i[17], b_i[17], c_w[16], s_o[17], c_w[17]); // Bit 17
    full_adder A18(a_i[18], b_i[18], c_w[17], s_o[18], c_w[18]); // Bit 18
    full_adder A19(a_i[19], b_i[19], c_w[18], s_o[19], c_w[19]); // Bit 19
    full_adder A20(a_i[20], b_i[20], c_w[19], s_o[20], c_w[20]); // Bit 20
    full_adder A21(a_i[21], b_i[21], c_w[20], s_o[21], c_w[21]); // Bit 21
    full_adder A22(a_i[22], b_i[22], c_w[21], s_o[22], c_w[22]); // Bit 22
    full_adder A23(a_i[23], b_i[23], c_w[22], s_o[23], c_w[23]); // Bit 23
    full_adder A24(a_i[24], b_i[24], c_w[23], s_o[24], c_w[24]); // Bit 24
    full_adder A25(a_i[25], b_i[25], c_w[24], s_o[25], c_w[25]); // Bit 25
    full_adder A26(a_i[26], b_i[26], c_w[25], s_o[26], c_w[26]); // Bit 26
    full_adder A27(a_i[27], b_i[27], c_w[26], s_o[27], c_w[27]); // Bit 27
    full_adder A28(a_i[28], b_i[28], c_w[27], s_o[28], c_w[28]); // Bit 28
    full_adder A29(a_i[29], b_i[29], c_w[28], s_o[29], c_w[29]); // Bit 29
    full_adder A30(a_i[30], b_i[30], c_w[29], s_o[30], c_w[30]); // Bit 30
    full_adder A31(a_i[31], b_i[31], c_w[30], s_o[31], c_w[31]); // Bit 31
    
    assign c_o = c_w[31];  // Cờ tràn cuối cùng
endmodule
