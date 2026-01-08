(* top *)
module testbench();

   // Include the register definitions (to use syymbolic names in test cases)
  `include "../common/risc-v-regs.sv"
  `include "../common/risc-v-tests.sv"

  // initialize test
  initial
    begin
      $dumpfile("risc-v-auipc-tb.vcd");
      $dumpvars(0, testbench);

/*
        input string name;
        input logic [4:0] rd;
        input logic [19:0] imm;
        input logic [31:0] rd_init;
        input logic [31:0] pc_init;
  Example
     pc => 8
        auipc t0,   0x10000
     t0 => 0x1000 0008
*/

      check_auipc(`E("auipc t0,0x10000"),    t0,  20'h10000,  32'h00FF00FF, 32'h00000008);

      check_auipc(`E("auipc t0,0x10000"),    t0,  20'h10000,  32'h00FF00FF, 32'h00000020);
      check_auipc(`E("auipc t0,0x10000"),    t0,  20'h10000,  32'h00FF00FF, 32'h00200020);
      check_auipc(`E("auipc t0,0xFF000"),    t0,  20'hFF000,  32'h00FF00FF, 32'h00000020);
      check_auipc(`E("auipc t0,0xFF000"),    t0,  20'hFF000,  32'h00FF00FF, 32'h00200020);

      check_auipc(`E("auipc s0,0x10000"),    s0,  20'h10000,  32'h00FF00FF, 32'h00000020);
      check_auipc(`E("auipc s0,0x10000"),    s0,  20'h10000,  32'h00FF00FF, 32'h002F0020);
      check_auipc(`E("auipc s0,0xFF000"),    s0,  20'hFF000,  32'h00FF00FF, 32'h00000020);
      check_auipc(`E("auipc s0,0xFF000"),    s0,  20'hFF000,  32'h00FF00FF, 32'h002F0020);

      finish_tests(`E(""));
      $finish(0);
    end
endmodule
