module SLL_32bit(
    input logic [31:0] a_i,      // Giá trị đầu vào cần dịch (32-bit)
    input logic [4:0] shift_i,   // Số lượng bit dịch (5-bit)
    output logic [31:0] s_o      // Kết quả sau khi dịch
);

    always_comb begin
        case (shift_i)
            5'd0: s_o = a_i;// Không dịch
            5'd1: s_o = {a_i[30:0], 1'b0};  // Dịch 1 bit
            5'd2: s_o = {a_i[29:0], 2'b00}; // Dịch 2 bit
            5'd3: s_o = {a_i[28:0], 3'b0}; // Dịch 3 bit
            5'd4: s_o = {a_i[27:0], 4'b0}; // Dịch 4 bit
            5'd5: s_o = {a_i[26:0], 5'b0}; // Dịch 5 bit
            5'd6: s_o = {a_i[25:0], 6'b0}; // Dịch 6 bit
            5'd7: s_o = {a_i[24:0], 7'b0}; // Dịch 7 bit
            5'd8: s_o = {a_i[23:0], 8'b0};// Dịch 8 bit
            5'd9: s_o = {a_i[22:0], 9'b0};// Dịch 9 bit
            5'd10: s_o = {a_i[21:0], 10'b0};  // Dịch 10 bit
            5'd11: s_o = {a_i[20:0], 11'b0};  // Dịch 11 bit
            5'd12: s_o = {a_i[19:0], 12'b0};  // Dịch 12 bit
            5'd13: s_o = {a_i[18:0], 13'b0};  // Dịch 13 bit
            5'd14: s_o = {a_i[17:0], 14'b0}; // Dịch 14 bit
            5'd15: s_o = {a_i[16:0], 15'b0}; // Dịch 15 bit
            5'd16: s_o = {a_i[15:0], 16'b0}; // Dịch 16 bit
            5'd17: s_o = {a_i[14:0], 17'b0}; // Dịch 17 bit
            5'd18: s_o = {a_i[13:0], 18'b0}; // Dịch 18 bit
            5'd19: s_o = {a_i[12:0], 19'b0}; // Dịch 19 bit
            5'd20: s_o = {a_i[11:0], 20'b0}; // Dịch 20 bit
            5'd21: s_o = {a_i[10:0], 21'b0}; // Dịch 21 bit
            5'd22: s_o = {a_i[9:0], 22'b0}; // Dịch 22 bit
            5'd23: s_o = {a_i[8:0], 23'b0}; // Dịch 23 bit
            5'd24: s_o = {a_i[7:0], 24'b0}; // Dịch 24 bit
            5'd25: s_o = {a_i[6:0], 25'b0}; // Dịch 25 bit
            5'd26: s_o = {a_i[5:0], 26'b0}; // Dịch 26 bit
            5'd27: s_o = {a_i[4:0], 27'b0}; // Dịch 27 bit
            5'd28: s_o = {a_i[3:0], 28'b0}; // Dịch 28 bit
            5'd29: s_o = {a_i[2:0], 29'b0}; // Dịch 29 bit
            5'd30: s_o = {a_i[1:0], 30'b0}; // Dịch 30 bit
            5'd31: s_o = {a_i[0], 31'b0}; // Dịch 31 bit
            default: s_o = 32'b0;
        endcase
    end

endmodule
