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

# label="4.5 RISC-V+spinner.S bitstream" dependsOn=["4.3 Convert spinner.S+driver for iCE40 ROM"]
products/risc-v-spinner.bin: \
	top.sv \
	ledandkey.sv \
	pins.pcf \
	../risc-v/riscvsingle.sv \
	imem.sv \
	dmem.sv \
	io.sv
# Don't include the rom as true dependency, but as a task dependency.


