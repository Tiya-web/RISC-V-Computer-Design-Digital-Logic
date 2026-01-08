module dmem(input  logic        clock, write_enable,
            input  logic [31:0] address, write_data,
            output logic [31:0] read_data);

  logic [31:0] RAM[1023:0];

  assign read_data = RAM[address[11:2]]; // word aligned

  always_ff @(posedge clock)
    if (write_enable) RAM[address[11:2]] <= write_data;

endmodule
