    .global _start
_start:
    mov r0, #0     @ set the counter to zero
    mov r1, #0     @ hold the mod value
    mov r5, #11    @ set the numerator
    mov r6, #5     @ set the denominator

_test:
    cmp r5, r6     @ if numer > denom, set N=1
    bge _subtract  @ numer > denom
    mov r1, r5     @ whats left of numer is mod result
    bal _exit

_subtract:
    sub r5, r6     @ subtrac denom from numer
    add r0, r0, #1 @ add 1 to the counter
    bal _test      @ test to again to see if done

_exit:
    mov r7, #1
    SWI 0
