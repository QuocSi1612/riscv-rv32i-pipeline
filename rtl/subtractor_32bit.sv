module subtractor_32bit(
    input logic [31:0] a_i,
    input logic [31:0] b_i,
    output logic [31:0] d_o,  // Kết quả phép trừ
    output logic b_o          // Borrow ra
);

    logic [31:0] b_w;  // Chuỗi borrow giữa các full subtractor

    // Thực hiện phép trừ từng bit sử dụng full subtractor
    full_subtractor S0 (a_i[0], b_i[0], 1'b0, d_o[0], b_w[0]);   // Bit 0
    full_subtractor S1 (a_i[1], b_i[1], b_w[0], d_o[1], b_w[1]); // Bit 1
    full_subtractor S2 (a_i[2], b_i[2], b_w[1], d_o[2], b_w[2]); // Bit 2
    full_subtractor S3 (a_i[3], b_i[3], b_w[2], d_o[3], b_w[3]); // Bit 3
    full_subtractor S4 (a_i[4], b_i[4], b_w[3], d_o[4], b_w[4]); // Bit 4
    full_subtractor S5 (a_i[5], b_i[5], b_w[4], d_o[5], b_w[5]); // Bit 5
    full_subtractor S6 (a_i[6], b_i[6], b_w[5], d_o[6], b_w[6]); // Bit 6
    full_subtractor S7 (a_i[7], b_i[7], b_w[6], d_o[7], b_w[7]); // Bit 7
    full_subtractor S8 (a_i[8], b_i[8], b_w[7], d_o[8], b_w[8]); // Bit 8
    full_subtractor S9 (a_i[9], b_i[9], b_w[8], d_o[9], b_w[9]); // Bit 9
    full_subtractor S10(a_i[10], b_i[10], b_w[9], d_o[10], b_w[10]); // Bit 10
    full_subtractor S11(a_i[11], b_i[11], b_w[10], d_o[11], b_w[11]); // Bit 11
    full_subtractor S12(a_i[12], b_i[12], b_w[11], d_o[12], b_w[12]); // Bit 12
    full_subtractor S13(a_i[13], b_i[13], b_w[12], d_o[13], b_w[13]); // Bit 13
    full_subtractor S14(a_i[14], b_i[14], b_w[13], d_o[14], b_w[14]); // Bit 14
    full_subtractor S15(a_i[15], b_i[15], b_w[14], d_o[15], b_w[15]); // Bit 15
    full_subtractor S16(a_i[16], b_i[16], b_w[15], d_o[16], b_w[16]); // Bit 16
    full_subtractor S17(a_i[17], b_i[17], b_w[16], d_o[17], b_w[17]); // Bit 17
    full_subtractor S18(a_i[18], b_i[18], b_w[17], d_o[18], b_w[18]); // Bit 18
    full_subtractor S19(a_i[19], b_i[19], b_w[18], d_o[19], b_w[19]); // Bit 19
    full_subtractor S20(a_i[20], b_i[20], b_w[19], d_o[20], b_w[20]); // Bit 20
    full_subtractor S21(a_i[21], b_i[21], b_w[20], d_o[21], b_w[21]); // Bit 21
    full_subtractor S22(a_i[22], b_i[22], b_w[21], d_o[22], b_w[22]); // Bit 22
    full_subtractor S23(a_i[23], b_i[23], b_w[22], d_o[23], b_w[23]); // Bit 23
    full_subtractor S24(a_i[24], b_i[24], b_w[23], d_o[24], b_w[24]); // Bit 24
    full_subtractor S25(a_i[25], b_i[25], b_w[24], d_o[25], b_w[25]); // Bit 25
    full_subtractor S26(a_i[26], b_i[26], b_w[25], d_o[26], b_w[26]); // Bit 26
    full_subtractor S27(a_i[27], b_i[27], b_w[26], d_o[27], b_w[27]); // Bit 27
    full_subtractor S28(a_i[28], b_i[28], b_w[27], d_o[28], b_w[28]); // Bit 28
    full_subtractor S29(a_i[29], b_i[29], b_w[28], d_o[29], b_w[29]); // Bit 29
    full_subtractor S30(a_i[30], b_i[30], b_w[29], d_o[30], b_w[30]); // Bit 30
    full_subtractor S31(a_i[31], b_i[31], b_w[30], d_o[31], b_w[31]); // Bit 31
    
    assign b_o = b_w[31];  // Borrow ra từ bit cuối cùng (bit 31)

endmodule
