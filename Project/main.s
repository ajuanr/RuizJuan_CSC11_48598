.data
/* 3-digit array holding the numbers user must guess */
.balign 4
master: .skip 12

/* 3-digit array holding the numbers that the user guessed */
.balign 4
guess: .skip 12

/* Instructions to user */
.balign 4
instruct: .asciz "Enter three digits in the correct order to win\n"

/* Prompts user to enter a number */
.balign 4
prompt: .asciz "Enter a number: "

/* Scan format */
.balign 4
scan: .asciz "%d"

/* Tell users what numbers they entered */
.balign 4
numsRead: .asciz "You entered %d, %d, and %d\n"

.text
    .global main

main:
    ldr r0, address_of_instruct
    bl printf

    bx lr


address_of_instruct: .word instruct   
