module SRA_32bit(
    input logic [31:0] a_i,      // Giá trị đầu vào cần dịch (32-bit)
    input logic [4:0] shift_i,   // Số lượng bit dịch (5-bit)
    output logic [31:0] s_o      // Kết quả sau khi dịch
);

    logic msb;                    // Bit dấu (MSB)

    assign msb = a_i[31];         // Lấy bit dấu (bit cao nhất)

    always_comb begin
        case (shift_i)
            5'd0: s_o = a_i;                                        // Không dịch
            5'd1: s_o = {msb, a_i[31:1]};                           // Dịch 1 bit, điền bit dấu
            5'd2: s_o = {{2{msb}}, a_i[31:2]};                      // Dịch 2 bit, điền 2 bit dấu
            5'd3: s_o = {{3{msb}}, a_i[31:3]};                      // Dịch 3 bit, điền 3 bit dấu
            5'd4: s_o = {{4{msb}}, a_i[31:4]};                      // Dịch 4 bit, điền 4 bit dấu
            5'd5: s_o = {{5{msb}}, a_i[31:5]};                      // Dịch 5 bit, điền 5 bit dấu
            5'd6: s_o = {{6{msb}}, a_i[31:6]};                      // Dịch 6 bit, điền 6 bit dấu
            5'd7: s_o = {{7{msb}}, a_i[31:7]};                      // Dịch 7 bit, điền 7 bit dấu
            5'd8: s_o = {{8{msb}}, a_i[31:8]};                      // Dịch 8 bit, điền 8 bit dấu
            5'd9: s_o = {{9{msb}}, a_i[31:9]};                      // Dịch 9 bit, điền 9 bit dấu
            5'd10: s_o = {{10{msb}}, a_i[31:10]};                   // Dịch 10 bit, điền 10 bit dấu
            5'd11: s_o = {{11{msb}}, a_i[31:11]};                   // Dịch 11 bit, điền 11 bit dấu
            5'd12: s_o = {{12{msb}}, a_i[31:12]};                   // Dịch 12 bit, điền 12 bit dấu
            5'd13: s_o = {{13{msb}}, a_i[31:13]};                   // Dịch 13 bit, điền 13 bit dấu
            5'd14: s_o = {{14{msb}}, a_i[31:14]};                   // Dịch 14 bit, điền 14 bit dấu
            5'd15: s_o = {{15{msb}}, a_i[31:15]};                   // Dịch 15 bit, điền 15 bit dấu
            5'd16: s_o = {{16{msb}}, a_i[31:16]};                   // Dịch 16 bit, điền 16 bit dấu
            5'd17: s_o = {{17{msb}}, a_i[31:17]};                   // Dịch 17 bit, điền 17 bit dấu
            5'd18: s_o = {{18{msb}}, a_i[31:18]};                   // Dịch 18 bit, điền 18 bit dấu
            5'd19: s_o = {{19{msb}}, a_i[31:19]};                   // Dịch 19 bit, điền 19 bit dấu
            5'd20: s_o = {{20{msb}}, a_i[31:20]};                   // Dịch 20 bit, điền 20 bit dấu
            5'd21: s_o = {{21{msb}}, a_i[31:21]};                   // Dịch 21 bit, điền 21 bit dấu
            5'd22: s_o = {{22{msb}}, a_i[31:22]};                   // Dịch 22 bit, điền 22 bit dấu
            5'd23: s_o = {{23{msb}}, a_i[31:23]};                   // Dịch 23 bit, điền 23 bit dấu
            5'd24: s_o = {{24{msb}}, a_i[31:24]};                   // Dịch 24 bit, điền 24 bit dấu
            5'd25: s_o = {{25{msb}}, a_i[31:25]};                   // Dịch 25 bit, điền 25 bit dấu
            5'd26: s_o = {{26{msb}}, a_i[31:26]};                   // Dịch 26 bit, điền 26 bit dấu
            5'd27: s_o = {{27{msb}}, a_i[31:27]};                   // Dịch 27 bit, điền 27 bit dấu
            5'd28: s_o = {{28{msb}}, a_i[31:28]};                   // Dịch 28 bit, điền 28 bit dấu
            5'd29: s_o = {{29{msb}}, a_i[31:29]};                   // Dịch 29 bit, điền 29 bit dấu
            5'd30: s_o = {{30{msb}}, a_i[31:30]};                   // Dịch 30 bit, điền 30 bit dấu
            5'd31: s_o = {{31{msb}}, a_i[31]};                      // Dịch 31 bit, điền 31 bit dấu
            default: s_o = 32'b0;
        endcase
    end

endmodule
