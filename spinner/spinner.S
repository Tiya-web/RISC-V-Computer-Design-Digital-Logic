.text
.globl spinner
# Do not change name or remove above this line
spinner:
# Parameters
#    a0 the number of "spins" (complete rotations, clockwise around LEDs of a digit)
#    a1  the time to delay with each segment on (in milliseconds)
#    a2  the digit to use (0 is rightmost / least significant digit)
# Return value
#    a0  none / undefined
# Side effects
#    Delay for approximately 6*spins*segment_time milliseconds and displaying a pattern on the designated digit

    # TODO: Your code here
    # ! Replace all `ecall` with `call ecall_proxy`
    # ! AND be sure register conventions are followed

    # Save registers on the stack
    addi sp, sp, -20
    sw   ra, 16(sp)
    sw   s0, 12(sp)
    sw   s1, 8(sp)
    sw   s2, 4(sp)
    sw   s3, 0(sp)

 # Initialize saved registers from arguments
    addi s0, a0, 0
    addi s1, a1, 0
    addi s2, a2, 0


outer_loop:

    beq  s0, zero, cleanup

    addi s3, zero, 0

inner_loop:
    addi t0, zero, 6
    slt  t1, s3, t0
    beq  t1, zero, end_inner_loop

    # Compute bitmask
    addi t1, zero, 1
    sll  t1, t1, s3

    slli t2, s2, 3
    sll  t1, t1, t2

    # Display segment
    addi a0, zero, 0x152
    addi a1, t1, 0
    addi a2, s2, 0
    call ecall_proxy

    # Delay
    addi a0, s1, 0
    call delay

    addi s3, s3, 1
    jal  zero, inner_loop

end_inner_loop:
    addi s0, s0, -1
    jal  zero, outer_loop

cleanup:
    # Turn off all segments
    addi a0, zero, 0x152
    addi a1, zero, 0
    addi a2, s2, 0
    call ecall_proxy

    # Restore registers
    lw   ra, 16(sp)
    lw   s0, 12(sp)
    lw   s1, 8(sp)
    lw   s2, 4(sp)
    lw   s3, 0(sp)
    addi sp, sp, 20



    # Don't remove:  jr ra (or `ret`) must be used to return to caller!
    jr ra

