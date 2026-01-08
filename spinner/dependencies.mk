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

# label="4.0 Edit spinner.S" type=".edit"
spinner.S.edit: \


# label="_Edit spinner simulate.S" type=".edit"
simulate.S.edit: \

# label="4.1 Simulate spinner.S" type=".riscv-sim" dependsOn=["4.2 Edit spinner_driver.S", "_Edit spinner simulate.S"]
spinner_driver_sim.S.riscv-sim:

# label="4.2 Edit spinner_driver.S" type=".edit"
spinner_driver.S.edit: \

# label="4.3 Convert spinner.S+driver for iCE40 ROM"
products/spinner.rom.txt: \
	../../common/bootloader.S \
	spinner_driver.S \
	spinner.S \
    ../delay/delay.S \
    ../../common/common_ice40.S

# label="4.4 Edit common_ice40.S" type=".edit"
common_ice40.S.edit: \
