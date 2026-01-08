module imem(input  logic [31:0] address,
            output logic [31:0] instruction);

  // Only 8 instructions in this tb
  logic [31:0] ROM[0:63];
  initial
      $readmemh("../risc-v-gen.rom.txt",ROM,0,23);

  assign instruction = ROM[address[7:2]];

endmodule
