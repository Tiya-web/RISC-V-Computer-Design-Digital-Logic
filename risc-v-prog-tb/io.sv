// Stub module for memory-mapped I/O (to the display)
module io(
        output logic tm_strobe,       // TM1638 Strobe
        output logic tm_clock,        // TM1638 Clock
        inout  logic tm_dio,          // TM1638 Data
        input logic reset,
        input logic clock,
        input logic write_enable,
        input logic [31:0] address, write_data,
        output logic [31:0] read_data
);

    logic [7:0] keys;
    logic [31:0] segments;
    logic [7:0] lights;
    assign keys = 8'b1;  // Right most key is always pressed
    always_ff @(posedge clock)
        if(write_enable)
            if(address === 32'h8000)
                segments <= write_data;
            else if(address === 32'h8004)
                lights <= write_data[7:0];

    always_comb
        if(address === 32'h8000)
            read_data = segments;
        else if(address === 32'h8004)
            read_data = {24'b0, lights};
        else if(address === 32'h8008)
            read_data = {24'b0, keys};
        else
            read_data = 32'h0;
endmodule

