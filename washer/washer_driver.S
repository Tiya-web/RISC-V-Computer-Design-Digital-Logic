
.globl main
main:
    # init Stack
    addi sp, sp, -12
    sw ra, 0(sp)

    sw zero, 4(sp) # Initialize the mode to 0
    sw zero, 8(sp) # Initialize the left display contents to 0
    j main_mode_digit

main_loop:
    # Check for start button
    li a0, 0x156
    call ecall_proxy

    # Check for the start button (1st button)
    andi t1, a0, 1
    beqz t1, main_check_advance

main_start_pressed:
    lw a0, 4(sp)
    # Call the wash cycle with the current mode
    call washcycle

    # Simulator can't press buttons at the same time, so loop
    j main_loop

main_check_advance:  # Can only get here if right button not pressed.  a0 still contains the buttons
    andi t1, a0, 0x80
    beqz t1, main_mode_digit  # Mode not pressed: show the mode

main_mode_advance_pressed:
    # Get and update the mode
    lw t0, 4(sp)
    addi t0, t0, 1
    andi t0, t0, 0x3
    sw t0, 4(sp)

    # Wait for release
main_button_wait:
    li a0, 0x156
    call ecall_proxy
    andi t1, a0, 0x80
    bnez t1, main_button_wait

# TODO: The display stuff here...
main_mode_digit:
    # Update the digit shown on the display
    lw t0, 4(sp) # Get the mode
    # if mode 00 =, digit 0x3f, 0x6, 0x5B, 0x4F
    li a1, 0x3f
    beqz t0, main_mode_set_digit
    li a1, 0x6
    li t1, 1
    beq t0, t1, main_mode_set_digit
    li a1, 0x5B
    li t1, 2
    beq t0, t1, main_mode_set_digit
    li a1, 0x4F

main_mode_set_digit:
    li a0, 3
    # a1 is already the value to use
    call set_left_digit
    j main_loop

    # The below should never happen (infinite loop)
    lw ra, 0(sp)
    addi sp, sp, 12
    jr ra

.globl set_left_digit
set_left_digit:
    addi sp, sp, -12
    sw a1, 8(sp)  # Value to use
    sw a0, 4(sp)  # Index of digit
    sw ra, 0(sp)
    # a0 is the index of the digit to change (0-3)
    # a1 is the contents to update it to
    andi a1, a1, 0xFF  # Mask a1 to just used bits
    # Get the current values
    li a0, 0x155
    jal ecall_proxy

    # Convert the index to a shift anount: Shift it by 3 (*8)
    lw t0, 4(sp)
    slli t0, t0, 3   # t0 = 8x index
    # Create a mask
    li t2, 0xFF
    sll t2, t2, t0
    not t2, t2
    # Apply the mask to the current display
    and a0, a0, t2
    # shift the updates into position
    lw t1, 8(sp)
    sll t1, t1, t0
    # Combine them
    or a1, a0, t1
    # Apply them
    li a0, 0x154
    call ecall_proxy
    lw ra, 0(sp)
    addi sp, sp, 12

    jr ra

.globl washer_set_outputs
washer_set_outputs:
    addi sp, sp, -4
    sw ra, 0(sp)
    # Convert to setting a digit
    mv a1,a0
    li a0, 0
    call set_left_digit
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra
