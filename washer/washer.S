.globl washcycle
# Parameters
#    a0  the wash mode
# Return value
#    none / undefined
# Side effects
#    Operates a single wash cycle designateed by mode (significant time delay and changes to outputs/displays)

washcycle:
    # ! Warning: if delay() is already configured for the hardware, simulation will be way to slow and unusable!!!
    # TODO finish/update washer!
     #
   addi sp, sp, -4
    # 2. Save the Return Address (ra) onto the stack
   sw   ra, 0(sp)
   addi t0, a0, 0

    # Parameters
    #   a0 is set of control values to apply
    #     bit 0: Soap (1 = on)
    #     bit 1: Hot (1 = on)
    #     bit 2: Cold (1 = on)
    #     bit 3: HighPressure (1 = on)
    #     bit 4: AirDry (1 = on)
    #     bit 5: ExtraHotAir (1 = on)
    # Return value
    #   none / undefined
    # Side effects
    #   control values are simulated on digit 3 (10,000s place) of the 7-segement displays


# Mode Check 000 (Regular Wash & Dry)

    addi a1, zero, 0         # Load 0 into a1 (Mode 000)
    bne t0, a1, CHECK_MODE_010 # If t0 != 0, check next mode (010)

Regular_Wash_Dry:
   # output : 0x03 (soap,hot) - Hot water with soap
    addi a0, zero, 0x03
    jal ra, washer_set_outputs

   # Time: 1 full spin, 0.5s per update (3 seconds total = 1 × 6 × 0.5s)
    addi a0, zero, 1
    addi a1, zero, 500
    addi a2, zero, 3
    jal  ra, spinner


   # Rinse(Warm, 6 seconds = 2 full spins × 6 × 0.5s)
   # Outputs: 0x06 (Hot, Cold, Soap is 0)
    addi a0, zero, 0x06
    jal ra, washer_set_outputs

   # Time: 2 full spins, 0.5s per update (6 seconds total)
    addi a0, zero, 2
    addi a1, zero, 500
    addi a2, zero, 3
    jal  ra, spinner

   # Dry (AirDry, 6 seconds = 2 full spins × 6 × 0.5s)
   # Outputs: 0x10 (AirDry Only)
    addi a0, zero, 0x10
    jal  ra, washer_set_outputs

   # Time: 2 full spins, 0.5s per update (6 seconds total)
    addi a0, zero, 2
    addi a1, zero, 500
    addi a2, zero, 3
    jal  ra, spinner


    jal zero, CYCLE_END             # Cycle finished, jump to final cleanup

# Mode Check 010 (Regular Wash & Power Dry)

CHECK_MODE_010:
    addi a1, zero, 2          # Load 2 (010_2) into a1
    bne t0, a1, CHECK_MODE_011 # If t0 != 2, check next mode (011)

Regular_Wash_Power_Dry:
    # Wash (3 seconds = 1 full spin × 6 × 0.5s)
    # Outputs: 0x03 (Soap, Hot)
    addi a0, zero, 0x03
    jal  ra, washer_set_outputs

    # Time: 1 full spin, 0.5s per update
    addi a0, zero, 1
    addi a1, zero, 500
    addi a2, zero, 3
    jal  ra, spinner

    # Rinse (Warm, 6 seconds = 2 full spins × 6 × 0.5s)
    # Outputs: 0x06 (Hot, Cold - Soap is OFF)
    addi a0, zero, 0x06
    jal  ra, washer_set_outputs

    # Time: 2 full spins, 0.5s per update
    addi a0, zero, 2
    addi a1, zero, 500
    addi a2, zero, 3
    jal  ra, spinner

    # Power Dry (3 seconds = 1 full spin × 6 × 0.5s)
    # Outputs: 0x30 (AirDry and ExtraHotAir)
    addi a0, zero, 0x30
    jal  ra, washer_set_outputs

    # Time: 1 full spin, 0.5s per update (3 seconds total)
    addi a0, zero, 1
    addi a1, zero, 500
    addi a2, zero, 3
    jal  ra, spinner

    jal  zero, CYCLE_END

# Mode Check 011 (Power Wash)

CHECK_MODE_011:
   # Check if t0 == 011 (3 in decimal)
    addi a1, zero, 3
    bne t0, a1, CHECK_MODE_001  # If t0 != 3, check next mode (001)

Power_Wash:
   # Wash (3 seconds = 1 full spin × 6 × 0.5s)
   # Outputs: 0x03 (Soap, Hot)
    addi a0, zero, 0x03
    jal ra,  washer_set_outputs

   # Time: 1 full spin, 0.5s per update (Standard speed)
    addi a0, zero, 1               # Set a0 (spins) to 1
    addi a1, zero, 500
    addi a2, zero, 3
    jal ra, spinner

   # Rinse (High Pressure Cold, 3 seconds = 2 full spins × 6 × 0.25s)
   # Outputs: 0x0C (HighPressure, Cold)
    addi a0, zero, 0x0C             # Set a0 to 0x0C
    jal ra, washer_set_outputs

    # Time: 2 full spins, 0.25s per update (Power mode speed)
    addi a0, zero, 2
    addi a1, zero, 250
    addi a2, zero, 3
    jal ra, spinner

    jal  zero, CYCLE_END


# Mode Check 001 (Power Wash Warm)

CHECK_MODE_001:
   # Check if t0 == 001 (1 in decimal)
    addi a1, zero, 1
    bne t0, a1, UNDEFINED_MODE

Power_Wash_Warm:
   # Wash (3 seconds = 1 full spin × 6 × 0.5s)
   # Outputs: 0x03 (Soap, Hot)
    addi a0, zero, 0x03
    jal ra, washer_set_outputs

   # Time: 1 full spin, 0.5s per update (Standard speed)
    addi a0, zero, 1
    addi a1, zero, 500
    addi a2, zero, 3
    jal  ra, spinner

   # Rinse (High Pressure Warm, 3 seconds = 2 full spins × 6 × 0.25s)
   # Outputs: 0x0E (HighPressure, Hot, Cold)
    addi a0, zero, 0x0E
    jal ra, washer_set_outputs

    # Time: 2 full spins, 0.25s per update (Power mode speed)
    addi a0, zero, 2
    addi a1, zero, 250
    addi a2, zero, 3
    jal ra, spinner

    jal  zero, CYCLE_END


# Common Exit Routine

UNDEFINED_MODE:
    # Fall-through point if no valid mode was found.

CYCLE_END:
    # Set Outputs to 0x00 (All OFF)
    addi a0, zero, 0x00             # a0 = 0x00
    jal  ra, washer_set_outputs  # Turn off all outputs

    # 1. Restore the Return Address (ra) from the stack
    lw   ra, 0(sp)
    # 2. Deallocate stack space
    addi sp, sp, 4


    # Don't remove:  jr ra (or `ret`) must be used to return to caller!
    jr ra
