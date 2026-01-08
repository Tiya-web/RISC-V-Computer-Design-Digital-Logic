.text
.globl delay
delay:
# Do not change name or remove above this line
# Parameters
#    a0  number of milliseconds to delay (1000 = 1s) (Can assume >= 10)
# Return value
#    none / undefined
# Side effects
#    delays for the given time (within about 10%)


# ! NOTE: The single-cycle CPU will execute at 6MHz!
# ! You must update your code taking into account the clock speed!
 # ! Computation for iterations in simulation:  You'll need this for simulation


   # li t1, 1
   srli t0, a0, 1  # for the spinner
   #addi t0, t0, 1

   addi t0, a0, 1
   slli t0, a0, 10
   slli t1, a0, 6
   add  t0, t0, t1
   slli t1, a0, 5
   add  t0, t0, t1
   slli t1, a0, 2
   add  t0, t0, t1
   add  t0, t0, a0


loop:
    addi t0, t0, -1
    bne t0, zero, loop



# HARDWARE
    # ! Computation for iterations on riscvsingle.sv hardware


    # Don't remove:  jr ra must be used to return to caller!
   jr  ra







