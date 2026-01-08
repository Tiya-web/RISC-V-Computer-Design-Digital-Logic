(* top *)
module testbench();

   // Include the register definitions (to use syymbolic names in test cases)
  `include "../common/risc-v-regs.sv"
  `include "../common/risc-v-tests.sv"

  // initialize test
  initial
    begin
      $dumpfile("risc-v-gen-tb.vcd");
      $dumpvars(0, testbench);

      // If rs1 and rs2 are the same, only rs1_init is used (rs2_init is ignored)
      check_add(`E("add t0, t1, t2"), t0, t1, t2, 32'hF, 32'h0, 32'h0);
      check_add(`E("add t0, t1, t2"), t0, t1, t2, 32'hF, 32'hF, 32'hF);
      check_add(`E("add s0, s1, s1"), s0, s1, s1, 32'hF, 32'hF, 32'hF);  // rs2_init ignored
      check_add(`E("add s0, s1, s2"), s0, s1, s2, 32'hF, 32'hFFFFFFFF, 32'hF);

      check_sub(`E("sub t0, t1, t2"), t0, t1, t2, 32'hF, 32'h0, 32'h0);
      check_sub(`E("sub t0, t1, t2"), t0, t1, t2, 32'hF, 32'hF, 32'hF);
      check_sub(`E("sub s0, s1, s1"), s0, s1, s1, 32'hF, 32'hF, 32'hF); // rs2_init ignored
      check_sub(`E("sub s0, s1, s2"), s0, s1, s2, 32'hF, 32'hF, 32'hFFF);

      check_and(`E("and t0, t1, t2"), t0, t1, t2, 32'hF, 32'h0, 32'h0);
      check_and(`E("and t0, t1, t2"), t0, t1, t2, 32'hF, 32'hFA54, 32'hA532);
      check_and(`E("and s0, s1, s2"), s0, s1, s2, 32'hF, 32'hF, 32'hF);

      check_or(`E("or t0, t1, t2"), t0, t1, t2, 32'hF, 32'h0, 32'h0);
      check_or(`E("or t0, t1, t2"), t0, t1, t2, 32'hF, 32'hFA54, 32'hA532);
      check_or(`E("or s0, s1, s2"), s0, s1, s2, 32'hF, 32'hF, 32'hF);

      check_xor(`E("xor t0, t1, t2"), t0, t1, t2, 32'hF, 32'h0, 32'h0);
      check_xor(`E("xor t0, t1, t2"), t0, t1, t2, 32'hF, 32'hFA54, 32'hA532);
      check_xor(`E("xor s0, s1, s2"), s0, s1, s2, 32'hF, 32'hF, 32'hF);

      check_sll(`E("sll t0, t1, t2"), t0, t1, t2, 32'hF, 32'h0, 32'h0);
      check_sll(`E("sll t0, t1, t2"), t0, t1, t2, 32'hF, 32'hFF4, 32'h2);
      check_sll(`E("sll t0, t1, t2"), t0, t1, t2, 32'hF, 32'hFF4, 32'h4);
      check_sll(`E("sll t0, t1, t2"), t0, t1, t2, 32'hF, 32'hFF4, 32'd31);
      check_sll(`E("sll s0, s1, s2"), s0, s1, s2, 32'hF, 32'hF, 32'hF);

      check_srl(`E("srl t0, t1, t2"), t0, t1, t2, 32'hF, 32'h0, 32'h0);
      check_srl(`E("srl t0, t1, t2"), t0, t1, t2, 32'hF, 32'hFF4, 32'h2);
      check_srl(`E("srl t0, t1, t2"), t0, t1, t2, 32'hF, 32'hFF4, 32'h4);
      check_srl(`E("srl t0, t1, t2"), t0, t1, t2, 32'hF, 32'hFF4, 32'd31);
      check_srl(`E("srl s0, s1, s2"), s0, s1, s2, 32'hF, 32'hF, 32'hF);

      check_addi(`E("addi t0, t1, 12"), t0, t1, 12,  32'hF, 32'hF0);
      check_addi(`E("addi t0, t1, 7"), t0, t1, 7,   32'hF, 32'hF0A07);
      check_addi(`E("addi s0, s1, -4"), s0, s1, -4,  32'hF, 32'hFFC);
      check_addi(`E("addi s0, s1, 5"), s0, s1, 5,   32'hF, 32'h1235);

      check_andi(`E("andi t0, t1, 0xAF3"), t0, t1, 12'hAF3,  32'hF, 32'hFAFA);
      check_andi(`E("andi t0, t1, 0xFF3"), t0, t1, 12'hFF3,  32'hF, 32'hFAFA);
      check_andi(`E("andi t0, t1, 0x173"), t0, t1, 12'h173,  32'hF, 32'hFA34AF2A);

      check_ori(`E("ori t0, t1, 0xAF3"), t0, t1, 12'hAF3,  32'hF, 32'hFAFA);
      check_ori(`E("ori t0, t1, 0xFF3"), t0, t1, 12'hFF3,  32'hF, 32'hFAFA);
      check_ori(`E("ori t0, t1, 0x173"), t0, t1, 12'h173,  32'hF, 32'hFA34AF2A);

      check_xori(`E("xori t0, t1, 0xAF3"), t0, t1, 12'hAF3,  32'hF, 32'hFAFA);
      check_xori(`E("xori t0, t1, 0xFF3"), t0, t1, 12'hFF3,  32'hF, 32'hFAFA);
      check_xori(`E("xori t0, t1, 0x173"), t0, t1, 12'h173,  32'hF, 32'hFA34AF2A);

      check_slli(`E("slli t0, t1, 0xF"), t0, t1, 12'hF,  32'hF, 32'h01A);
      check_slli(`E("slli t0, t1, 0xF"), t0, t1, 12'hF,  32'hF, 32'hFAFA01A);
      check_slli(`E("slli t0, t1, 0x0"), t0, t1, 12'h0,  32'hF, 32'hFAFA);
      check_slli(`E("slli t0, t1, 0x1"), t0, t1, 12'h1,  32'hF, 32'h172);

      check_srli(`E("srli t0, t1, 0xF"), t0, t1, 12'hF,  32'hF, 32'h01A);
      check_srli(`E("srli t0, t1, 0xF"), t0, t1, 12'hF,  32'hF, 32'hFAFA01A);
      check_srli(`E("srli t0, t1, 0x0"), t0, t1, 12'h0,  32'hF, 32'hFAFA);
      check_srli(`E("srli t0, t1, 0x1"), t0, t1, 12'h1,  32'hF, 32'h172);

      check_lui(`E("lui t0, 0x12345"), t0, 20'h12345, 32'h0);
      check_lui(`E("lui s0, 0xFFFFF"), s0, 20'hFFFFF, 32'h0);
      check_lui(`E("lui s0, 0xFFFFF"), s0, 20'hFFFFF, 32'hFFFFFFFF);
      check_lui(`E("lui a0, 0x8000"),  a0, 20'h8000,  32'hFFFF0FFF);
      check_lui(`E("lui a0, 0x1"),     a0, 20'h1,     32'hFFFF0FFF);
      check_lui(`E("lui t4, 0x12"),    t4, 20'h12,    32'h00FF0FFF);
      check_lui(`E("lui sp, 0x80"),    sp, 20'h80,    32'h00FF0FFF);

      check_jalr(`E("jalr t0,t1,0x10"),     t0,  t1, 12'h10,  32'h00FF00FF, 32'h00000020);
      check_jalr(`E("jalr zero,ra,0x00"), zero,  ra, 12'h00,  32'h00FF00FF, 32'h00000020);
      check_jalr(`E("jalr zero,ra,0x10"), zero,  ra, 12'h10,  32'h00FF00FF, 32'h00000020);
      check_jalr(`E("jalr t1,ra,0x00"),     t1,  ra, 12'h00,  32'h00FF00FF, 32'h00000020);
      check_jalr(`E("jalr t1,ra,0xFC"),     t1,  ra, 12'hFC,  32'h00FF00FF, 32'h00000020);
      check_jalr(`E("jalr t1,ra,-4"),       t1,  ra, 12'hFFC, 32'h00FF00FF, 32'h00000020);
      check_jalr(`E("jalr t1,ra,-8"),       t1,  ra, 12'hFF8, 32'h00FF00FF, 32'h00000020);
      check_jalr(`E("jalr s1,s11,6"),       s1, s11, 12'h6,   32'h00FF000F, 32'h000F0020);

      check_jal(`E("jal t0, 0x10"), t0, 20'h10, 32'h00FF00FF);
      check_jal(`E("jal zero, 0x10"), zero, 20'h10, 32'h00FF00FF);
      check_jal(`E("jal s2, 0x10"), s2, 20'hFF0FF, 32'h00FF00FF);

                                            // imm pc rs1 rs2
      check_beq(`E("beq t0, t1, 0x10"), t0, t1, 12'h10, 32'h1F0, 32'hF, 32'hF);
      check_beq(`E("beq t0, t1, 0x10"), t0, t1, 12'h10, 32'h1F0, 32'h0, 32'hF);

      check_bne(`E("bne t0, t1, 0x10"), t0, t1, 12'h10, 32'h1F0, 32'hF, 32'hF);
      check_bne(`E("bne t0, t1, 0x10"), t0, t1, 12'h10, 32'h1F0, 32'h0, 32'hF);


      check_slti(`E("slti t0, t1, 0xFF3"), t0, t1, 12'hFF3,  32'hF, 32'h01A);
      check_slti(`E("slti t0, t1, 0x1F3"), t0, t1, 12'h1F3,  32'hF, 32'hFAFA);
      check_slti(`E("slti t0, t1, 0x173"), t0, t1, 12'h173,  32'hF, 32'h172);

      check_slt(`E("slt t0, t1, t2"), t0, t1, t2, 32'hF, 32'h0, 32'h0);
      check_slt(`E("slt t0, t1, t2"), t0, t1, t2, 32'hF, 32'hFA54, 32'hA532);
      check_slt(`E("slt s0, s1, s2"), s0, s1, s2, 32'hF, 32'hF, 32'hF);


      check_lw(`E("lw t0, 0x10(t1)"), t0, 12'h10, t1,  32'hF);
      check_lw(`E("lw s3, 0xFFF(s1)"), s3, 12'hFFF, s1,  32'hF);
      check_lw(`E("lw a0, 0x7FF(s1)"), a0, 12'h7FF, s1,  32'hF);

      check_sw(`E("sw t0, 0x10(t1)"), t0, 12'h10, t1,  32'hFA);
      check_sw(`E("sw s3, 0xFFF(s1)"), s3, 12'hFFF, s1,  32'h123);
      check_sw(`E("sw a0, 0x7FF(s1)"), a0, 12'h7FF, s1,  32'hFF4556);

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
