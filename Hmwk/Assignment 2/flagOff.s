    .global main
main:
    mov r0, #0     @ set the result to zero
    mov r1, #0     @ hold the remainder
    mov r2, #0     @ 0 to show result, 1 to show remainder
    mov r5, #0    @ set the numerator
    mov r6, #7     @ set the denominator

_test:
    cmp r5, r6     @ (numer - denom)
    blt _remainder @ if numer = 0
    bge _subtract  @ if (numer > denom)
    mov r1, r5     @ what's left of numer is mod result
    cmp r2, #1     @ user wants to see remainder if r2 = 1
    beq _swap      @ flag was 1, swap show to show remainder
    bal _exit      @ numer < denom, exit

@ Used only when numer = 0
_remainder:
    mov r1, r6
    cmp r2, #0
    beq _exit
    bal _swap

_subtract:
    sub r5, r6     @ subtract denom from numer
    add r0, r0, #1 @ add 1 to the counter
    bal _test      @ test to again to see if done

_swap:
    mov r4, r0     @ r4 is temp
    mov r0, r1     @ replace r5 with r6
    mov r1, r4     @ put original value of r5 into r6
    bal _exit

_exit:
    mov r7, #1
    swi 0
