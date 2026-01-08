.globl main
main:
    addi sp, sp, -4
    sw ra, 0(sp)

main_loop:
    li a0, 0x152
    li a1, 0xFF
    call ecall_proxy

    # Show 1
    li a0, 0x152
    li a1, 0x6
    call ecall_proxy

    li a0, 1000
    call delay

    # Show 2
    li a0, 0x152
    li a1, 0x5B
    call ecall_proxy

    li a0, 2000
    call delay

    # Show 5
    li a0, 0x152
    li a1, 0x6D
    call ecall_proxy

    li a0, 5000
    call delay

    # Loop
    j main_loop

# Should be unreachable
main_end:
    lw ra, 0(sp)
    addi sp, sp, 4
    ret
