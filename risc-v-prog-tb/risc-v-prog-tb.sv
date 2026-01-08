module testbench();

  logic        clk;
  logic        reset;

  logic [31:0] WriteData, DataAdr;
  logic        MemWrite;

  // instantiate device to be tested
  top dut(clk, reset, WriteData, DataAdr, MemWrite);

  // initialize test
  initial
    begin
      $dumpfile("risc-v-prog-tb.vcd");
      $dumpvars(0, testbench);
      reset = 1; # 22; reset = 0;
      // <=~24 insts executed * 10 cycles/inst + 22 cycles for reset = 242 cycles
      #300;
      $display("ERROR: risc-v-prog-tb.sv:20:Simulation failed");
      $finish(0);
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check results
  always @(negedge clk)
    begin
      if(MemWrite) begin
        if(DataAdr === 108 & WriteData === 32'hABCDE7E5) begin
          $display("ERROR: risc-v-prog-tb:01:Simulation succeeded!");
          $finish(0);
        end else if (DataAdr !== 96) begin
          $display("ERROR: risc-v-prog-tb:38:Simulation failed");
          $finish(0);
        end
      end
    end
endmodule
