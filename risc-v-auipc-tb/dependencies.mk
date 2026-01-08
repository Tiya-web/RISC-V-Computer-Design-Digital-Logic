# Assumes only SystemVerilog (.sv) files are used
# Format is:
#    Product : List of Dependencies
#    (Use \ at the end of the line for line continuation)
# Types of products are:
#    *.rtl.json:  Simulation file
#    *.vcd:  Value Change Dump (signal trace)
#    *.ice40.jpg:  Ice40 synthesis
#    *.aig.jpg:  AIG synthesis
#    *.bin:  bitstream / programming
#

# label="2.3 RISC-V auipc Testbench"
products/risc-v-auipc-tb.vcd: \
	risc-v-auipc-tb.sv \
	riscvsingle.sv

