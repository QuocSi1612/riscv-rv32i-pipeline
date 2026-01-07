module lsu(
  input  logic        i_clk,
  input  logic        i_rst_n,
  input  logic [31:0] i_lsu_addr,   // địa chỉ load/store
  input  logic [31:0] i_st_data,    // store data
  input  logic        i_lsu_wren,   // write enable
  input  logic [2:0]  i_control,    // LB/LH/LW/SB/SH/SW
  output logic [31:0] o_ld_data
);

  localparam DMEM_BASE = 32'h1000_0000;
  localparam SIZE      = 1024;

  logic [31:0] o_dmem_data;

  // kiểm tra địa chỉ hợp lệ trong vùng dmem
  logic dmem_valid;
  assign dmem_valid = (i_lsu_addr >= DMEM_BASE) && (i_lsu_addr < DMEM_BASE + SIZE);

  // dịch địa chỉ về offset trong RAM
  logic [15:0] dmem_addr_off;
  assign dmem_addr_off = i_lsu_addr[15:0] - DMEM_BASE[15:0];

  dmem dmem_i (
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_lsu_addr(dmem_addr_off),
    .i_st_data(i_st_data),
    .i_lsu_wren(i_lsu_wren & dmem_valid),
    .i_control(i_control),
    .o_dmem_data(o_dmem_data)
  );

  always_comb begin
    o_ld_data = dmem_valid ? o_dmem_data : 32'hDEAD_BEEF;
  end

endmodule
