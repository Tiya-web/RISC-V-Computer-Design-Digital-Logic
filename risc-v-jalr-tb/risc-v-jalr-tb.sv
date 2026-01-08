(* top *)
module testbench();

   // Include the register definitions (to use syymbolic names in test cases)
  `include "../common/risc-v-regs.sv"
  `include "../common/risc-v-tests.sv"

  // initialize test
  initial
    begin
      $dumpfile("risc-v-jalr-tb.vcd");
      $dumpvars(0, testbench);

      check_jalr(`E("jalr t0,t1,0x10"),     t0,  t1, 12'h10,  32'h00FF00FF, 32'h00000020);
      check_jalr(`E("jalr zero,ra,0x00"), zero,  ra, 12'h00,  32'h00FF00FF, 32'h00000020);
      check_jalr(`E("jalr zero,ra,0x10"), zero,  ra, 12'h10,  32'h00FF00FF, 32'h00000020);
      check_jalr(`E("jalr t1,ra,0x00"),     t1,  ra, 12'h00,  32'h00FF00FF, 32'h00000020);
      check_jalr(`E("jalr t1,ra,0xFC"),     t1,  ra, 12'hFC,  32'h00FF00FF, 32'h00000020);
      check_jalr(`E("jalr t1,ra,-4"),       t1,  ra, 12'hFFC, 32'h00FF00FF, 32'h00000020);
      check_jalr(`E("jalr t1,ra,-8"),       t1,  ra, 12'hFF8, 32'h00FF00FF, 32'h00000020);
      check_jalr(`E("jalr s1,s11,6"),       s1, s11, 12'h6,   32'h00FF000F, 32'h000F0020);

      finish_tests(`E(""));
      $finish(0);
    end
endmodule
