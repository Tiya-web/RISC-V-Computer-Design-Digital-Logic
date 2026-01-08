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
#    *.rom.txt: Convert a single .S file to assembly format for RISC-V ROM (Does not sanity check; Will remove any lines between <RM> and </RM> tags)

# label="3.0 Edit delay.S" type=".edit"
delay.S.edit: \

# label="_Edit delay simulate.S" type=".edit"
simulate.S.edit: \

# label="3.1 Simulate delay.S" type=".riscv-sim" dependsOn=["3.2 Edit delay_driver.S", "_Edit delay simulate.S"]
delay_driver_sim.S.riscv-sim:

# label="3.2 Edit delay_driver.S" type=".edit"
delay_driver.S.edit: \

# label="3.3 Convert delay.S+driver for iCE40 ROM"
products/delay.rom.txt: \
	../../common/bootloader.S \
	delay_driver.S \
	delay.S \
	../../common/common_ice40.S \


