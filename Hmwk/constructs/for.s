    .global main

main:
    mov r0, #0

@ count down to zero
_setCntr:
    mov r1, #10     @ r1 is the counter
    
    @drop down into loop
_for:
    cmp r1, #0
    beq _exit
    add r0, r0, #1       @ double the value each iterator
    sub r1, r1, #1
    bal _for                @ re-enter loop

_exit:
    mov r7, #0
    swi 0
