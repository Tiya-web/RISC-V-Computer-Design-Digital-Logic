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

# label="5.0 Edit washer.S" type=".edit"
washer.S.edit: \

# label="_Edit washer simulate.S" type=".edit"
simulate.S.edit: \


# label="5.1 Simulate washer.S" type=".riscv-sim" dependsOn=["5.2 Edit washer_driver.S", "_Edit washer simulate.S"]
washer_driver_sim.S.riscv-sim:

# label="5.2 Edit washer_driver.S" type=".edit"
washer_driver.S.edit: \

# label="5.3 Convert washer.S+driver for iCE40 ROM"
products/washer.rom.txt: \
	../../common/bootloader.S \
	washer_driver.S \
	washer.S \
	../spinner/spinner.S \
    ../delay/delay.S \
    ../../common/common_ice40.S


