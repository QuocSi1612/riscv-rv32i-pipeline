module dmem(
  input  logic        i_clk,
  input  logic        i_rst_n,
  input  logic [15:0] i_lsu_addr,
  input  logic [31:0] i_st_data,
  input  logic        i_lsu_wren,
  input  logic [2:0]  i_control,
  output logic [31:0] o_dmem_data
);

  localparam [2:0] LB  = 3'b000,
                   LH  = 3'b001,
                   LW  = 3'b010,
                   LBU = 3'b100,
                   LHU = 3'b101;

  localparam SIZE = 1024;

  logic [7:0] dmem [SIZE-1:0];

  logic [15:0] addr_even;
  assign addr_even = {i_lsu_addr[15:1], 1'b0};

  // Reset và ghi dữ liệu
  longint i;
  always_ff @(posedge i_clk) begin
    if (!i_rst_n) begin
      for (i = 0; i < SIZE; i++)
        dmem[i] <= 8'h00;
    end else if (i_lsu_wren) begin
      case (i_control[1:0])
        2'b00: if (i_lsu_addr < SIZE) dmem[i_lsu_addr] <= i_st_data[7:0]; // SB
        2'b01: begin // SH
          if (addr_even + 0 < SIZE) dmem[addr_even + 0] <= i_st_data[7:0];
          if (addr_even + 1 < SIZE) dmem[addr_even + 1] <= i_st_data[15:8];
        end
        2'b10: begin // SW
          if (addr_even + 0 < SIZE) dmem[addr_even + 0] <= i_st_data[7:0];
          if (addr_even + 1 < SIZE) dmem[addr_even + 1] <= i_st_data[15:8];
          if (addr_even + 2 < SIZE) dmem[addr_even + 2] <= i_st_data[23:16];
          if (addr_even + 3 < SIZE) dmem[addr_even + 3] <= i_st_data[31:24];
        end
      endcase
    end
  end

  // Load dữ liệu
  logic [7:0] temp[3:0];
  always_comb begin
    temp[0] = (addr_even + 0 < SIZE) ? dmem[addr_even + 0] : 8'h00;
    temp[1] = (addr_even + 1 < SIZE) ? dmem[addr_even + 1] : 8'h00;
    temp[2] = (addr_even + 2 < SIZE) ? dmem[addr_even + 2] : 8'h00;
    temp[3] = (addr_even + 3 < SIZE) ? dmem[addr_even + 3] : 8'h00;
  end

  always_comb begin
    case (i_control)
      LB:  o_dmem_data = {{24{dmem[i_lsu_addr][7]}}, dmem[i_lsu_addr]};
      LH:  o_dmem_data = {{16{temp[1][7]}}, temp[1], temp[0]};
      LW:  o_dmem_data = {temp[3], temp[2], temp[1], temp[0]};
      LBU: o_dmem_data = {24'h0, dmem[i_lsu_addr]};
      LHU: o_dmem_data = {16'h0, temp[1], temp[0]};
      default: o_dmem_data = 32'h0;
    endcase
  end

endmodule
