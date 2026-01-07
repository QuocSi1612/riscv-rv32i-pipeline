module xor_32bit(
    input logic [31:0] a_i,    // Đầu vào a (32-bit)
    input logic [31:0] b_i,    // Đầu vào b (32-bit)
    output logic [31:0] c_o    // Kết quả (32-bit)
);

    // Sử dụng primitive XOR cho từng bit
    xor (c_o[0],  a_i[0],  b_i[0]);
    xor (c_o[1],  a_i[1],  b_i[1]);
    xor (c_o[2],  a_i[2],  b_i[2]);
    xor (c_o[3],  a_i[3],  b_i[3]);
    xor (c_o[4],  a_i[4],  b_i[4]);
    xor (c_o[5],  a_i[5],  b_i[5]);
    xor (c_o[6],  a_i[6],  b_i[6]);
    xor (c_o[7],  a_i[7],  b_i[7]);
    xor (c_o[8],  a_i[8],  b_i[8]);
    xor (c_o[9],  a_i[9],  b_i[9]);
    xor (c_o[10], a_i[10], b_i[10]);
    xor (c_o[11], a_i[11], b_i[11]);
    xor (c_o[12], a_i[12], b_i[12]);
    xor (c_o[13], a_i[13], b_i[13]);
    xor (c_o[14], a_i[14], b_i[14]);
    xor (c_o[15], a_i[15], b_i[15]);
    xor (c_o[16], a_i[16], b_i[16]);
    xor (c_o[17], a_i[17], b_i[17]);
    xor (c_o[18], a_i[18], b_i[18]);
    xor (c_o[19], a_i[19], b_i[19]);
    xor (c_o[20], a_i[20], b_i[20]);
    xor (c_o[21], a_i[21], b_i[21]);
    xor (c_o[22], a_i[22], b_i[22]);
    xor (c_o[23], a_i[23], b_i[23]);
    xor (c_o[24], a_i[24], b_i[24]);
    xor (c_o[25], a_i[25], b_i[25]);
    xor (c_o[26], a_i[26], b_i[26]);
    xor (c_o[27], a_i[27], b_i[27]);
    xor (c_o[28], a_i[28], b_i[28]);
    xor (c_o[29], a_i[29], b_i[29]);
    xor (c_o[30], a_i[30], b_i[30]);
    xor (c_o[31], a_i[31], b_i[31]);

endmodule
