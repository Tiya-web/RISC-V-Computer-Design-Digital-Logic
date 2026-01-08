module imem(input  logic [31:0] address,
            output logic [31:0] instruction);

  logic [31:0] ROM[0:511];

  initial
      $readmemh("../code/spinner/products/spinner.rom.txt",ROM);

  assign instruction = ROM[address[10:2]]; // word aligned

endmodule
