module SRL_32bit(
    input logic [31:0] a_i,      // Giá trị đầu vào cần dịch (32-bit)
    input logic [4:0] shift_i,   // Số lượng bit dịch (5-bit)
    output logic [31:0] s_o      // Kết quả sau khi dịch
);

    always_comb begin
        case (shift_i)
            5'd0: s_o = a_i;                              // Không dịch
            5'd1: s_o = {1'b0, a_i[31:1]};                // Dịch 1 bit
            5'd2: s_o = {2'b0, a_i[31:2]};                // Dịch 2 bit
            5'd3: s_o = {3'b0, a_i[31:3]};                // Dịch 3 bit
            5'd4: s_o = {4'b0, a_i[31:4]};                // Dịch 4 bit
            5'd5: s_o = {5'b0, a_i[31:5]};                // Dịch 5 bit
            5'd6: s_o = {6'b0, a_i[31:6]};                // Dịch 6 bit
            5'd7: s_o = {7'b0, a_i[31:7]};                // Dịch 7 bit
            5'd8: s_o = {8'b0, a_i[31:8]};                // Dịch 8 bit
            5'd9: s_o = {9'b0, a_i[31:9]};                // Dịch 9 bit
            5'd10: s_o = {10'b0, a_i[31:10]};             // Dịch 10 bit
            5'd11: s_o = {11'b0, a_i[31:11]};             // Dịch 11 bit
            5'd12: s_o = {12'b0, a_i[31:12]};             // Dịch 12 bit
            5'd13: s_o = {13'b0, a_i[31:13]};             // Dịch 13 bit
            5'd14: s_o = {14'b0, a_i[31:14]};             // Dịch 14 bit
            5'd15: s_o = {15'b0, a_i[31:15]};             // Dịch 15 bit
            5'd16: s_o = {16'b0, a_i[31:16]};             // Dịch 16 bit
            5'd17: s_o = {17'b0, a_i[31:17]};             // Dịch 17 bit
            5'd18: s_o = {18'b0, a_i[31:18]};             // Dịch 18 bit
            5'd19: s_o = {19'b0, a_i[31:19]};             // Dịch 19 bit
            5'd20: s_o = {20'b0, a_i[31:20]};             // Dịch 20 bit
            5'd21: s_o = {21'b0, a_i[31:21]};             // Dịch 21 bit
            5'd22: s_o = {22'b0, a_i[31:22]};             // Dịch 22 bit
            5'd23: s_o = {23'b0, a_i[31:23]};             // Dịch 23 bit
            5'd24: s_o = {24'b0, a_i[31:24]};             // Dịch 24 bit
            5'd25: s_o = {25'b0, a_i[31:25]};             // Dịch 25 bit
            5'd26: s_o = {26'b0, a_i[31:26]};             // Dịch 26 bit
            5'd27: s_o = {27'b0, a_i[31:27]};             // Dịch 27 bit
            5'd28: s_o = {28'b0, a_i[31:28]};             // Dịch 28 bit
            5'd29: s_o = {29'b0, a_i[31:29]};             // Dịch 29 bit
            5'd30: s_o = {30'b0, a_i[31:30]};             // Dịch 30 bit
            5'd31: s_o = {31'b0, a_i[31]};                // Dịch 31 bit
            default: s_o = 32'b0;
        endcase
    end

endmodule
