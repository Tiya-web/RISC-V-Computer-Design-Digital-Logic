.globl main
main:
    addi sp, sp, -4
    sw ra, 0(sp)

main_loop:

    # Show spins, time, digit
    li a0, 1
    li a1, 500  # Fast-ish
    li a2, 0
    call spinner

    # Show spins, time, digit
    li a0, 2
    li a1, 250  # Fast-ish
    li a2, 1
    call spinner

    # Show spins, time, digit
    li a0, 3
    li a1, 125  # Fast-ish
    li a2, 2
    call spinner

    # Show spins, time, digit
    li a0, 4
    li a1, 62  # Fast-ish
    li a2, 3
    call spinner

    j main_loop

main_end:
    lw ra, 0(sp)
    addi sp, sp, 4
    ret

