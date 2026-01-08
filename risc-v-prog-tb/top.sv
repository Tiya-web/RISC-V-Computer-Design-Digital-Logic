module top(
    input  logic        clock,        // Clock
    input  logic        reset,        // Reset
    output logic [31:0] WriteData,    // Data to write
    output logic [31:0] DataAdr,      // Address to read/write
    output logic        MemWrite      // Write enable
);

  logic [31:0] PC, Instr, ReadData;

  // instantiate processor and memories
  riscvsingle rvsingle(
      .clock(clock),
      .reset(reset),
      .PC(PC),
      .Instr(Instr),
      .MemWrite(MemWrite),
      .ALUResult(DataAdr),
      .ReadData(ReadData),
      .WriteData(WriteData));

  imem imem(.address(PC), .instruction(Instr));

  // The two types of memory (actual data memory and memory mapped I/O)
  logic [31:0] MemData;
  dmem dmem(.clock(clock),
            .write_enable(MemWrite && DataAdr[15]===0),
            .address(DataAdr),
            .write_data(WriteData),
            .read_data(MemData));

  logic [31:0] IOData;
  wire tm_strobe, tm_clock, tm_dio;
  io io(.clock(clock),
        .reset(reset),
        .write_enable(MemWrite && DataAdr[15]===1),
        .address(DataAdr),
        .write_data(WriteData),
        .read_data(IOData),
        .tm_strobe(tm_strobe),
        .tm_clock(tm_clock),
        .tm_dio(tm_dio)
        );

  assign ReadData = (DataAdr[15]===1'b0) ? MemData : IOData;

endmodule
