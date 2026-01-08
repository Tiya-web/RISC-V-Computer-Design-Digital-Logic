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

# label="2.4 RISC-V Program Testbench"
products/risc-v-prog-tb.vcd: \
	risc-v-prog-tb.sv \
	top.sv \
	riscvsingle.sv \
	imem.sv \
	dmem.sv \
	io.sv

