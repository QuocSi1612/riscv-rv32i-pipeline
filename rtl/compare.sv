module compare (
    input logic [31:0] i_operand_a,   // Operand A (rs1)
    input logic [31:0] i_operand_b,   // Operand B (rs2)
    input logic i_signed,             // 1 if signed comparison, 0 if unsigned
    output logic o_less               // 1 if A < B
);

    logic A_msb, B_msb;               // Most significant bits (MSB) for signed comparison
    logic A_less_than_B;              // Intermediate signal for less-than check

    // Less-than check
    always_comb begin
        A_msb = i_operand_a[31];      // MSB of A
        B_msb = i_operand_b[31];      // MSB of B

        if (!i_signed) begin
            // Unsigned comparison: Compare bit-by-bit starting from MSB
            A_less_than_B = 1'b0;
            for (int i = 31; i >= 0; i--) begin // so sanh tung bit 31 xuong bit 0 
                if (i_operand_a[i] != i_operand_b[i]) begin // skip so sanh neu 2 bit giong nhau, xet bit ke tiep neu bit so a =0 chung to a nho hon b 
                    A_less_than_B = (i_operand_a[i] == 1'b0);
                    break;
                end
            end
        end else begin
            // Signed comparison: Check MSB (sign bit) first
            if (A_msb != B_msb) begin
                A_less_than_B = A_msb;  // If A is negative and B is positive, A < B
            end else begin
                // If both have the same sign, do bitwise comparison
                A_less_than_B = 1'b0;
                for (int i = 30; i >= 0; i--) begin
                    if (i_operand_a[i] != i_operand_b[i]) begin
                        A_less_than_B = (i_operand_a[i] == 1'b0);
                        break;
                    end
                end
            end
        end

        o_less = A_less_than_B;  // Set output o_less based on the comparison
    end

endmodule
