`timescale 1ns/1ps

module tb();

  logic clk;
  logic rst_n;

  // DUT
  pipeline dut(
    .i_clk(clk),
    .i_rst_n(rst_n),
    .o_insn_vld(),
    .o_mispred(),
    .o_pc_debug()
  );

  // Clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset
  initial begin
    rst_n = 0;
    #20;
    rst_n = 1;
  end

  int cycle = 0;
  int r;
  int i;
  logic [31:0] word;

  always @(posedge clk) begin
    if (rst_n) begin
      cycle++;

      $display("\n=== Cycle %0d ===", cycle);
      $display("PC   = %08h", dut.PC.pc);
      $display("INST = %08h", dut.instr_mem.o_inst);

      // In toàn bộ regfile
      $display("\nREGISTERS:");
      for (r = 0; r < 32; r++) begin
        $display("x%0d = %08h", r, dut.reg_file.registers[r]);
      end

      // In toàn bộ dmem (word aligned)
      $display("\nDMEM (word aligned):");
      for (i = 0; i < 1024; i += 4) begin
        word = {
          dut.load_store_unit.dmem_i.dmem[i+3],
          dut.load_store_unit.dmem_i.dmem[i+2],
          dut.load_store_unit.dmem_i.dmem[i+1],
          dut.load_store_unit.dmem_i.dmem[i+0]
        };
        $display("mem[%0d] = %08h", i >> 2, word);
      end

      if (cycle > 50) begin
        $display("Simulation finished.");
        $finish;
      end
    end
  end

endmodule
