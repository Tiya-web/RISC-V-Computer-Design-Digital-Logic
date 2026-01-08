(* top *)
module testbench();

   // Include the register definitions (to use syymbolic names in test cases)
  `include "../common/risc-v-regs.sv"
  `include "../common/risc-v-tests.sv"

  // initialize test
  initial
    begin
      $dumpfile("risc-v-lui-tb.vcd");
      $dumpvars(0, testbench);

      check_lui(`E("lui t0, 0x12345"), t0, 20'h12345, 32'h0);
      check_lui(`E("lui s0, 0xFFFFF"), s0, 20'hFFFFF, 32'h0);
      check_lui(`E("lui s0, 0xFFFFF"), s0, 20'hFFFFF, 32'hFFFFFFFF);
      check_lui(`E("lui a0, 0x8000"),  a0, 20'h8000,  32'hFFFF0FFF);
      check_lui(`E("lui a0, 0x1"),     a0, 20'h1,     32'hFFFF0FFF);
      check_lui(`E("lui t4, 0x12"),    t4, 20'h12,    32'h00FF0FFF);
      check_lui(`E("lui sp, 0x80"),    sp, 20'h80,    32'h00FF0FFF);

      finish_tests(`E(""));
      $finish(0);
    end
endmodule
