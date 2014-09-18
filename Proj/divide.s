    .global _start
_start:
    mov r0, #0     @ set the counter to zero
    mov r1, #0     @ holds the mod value
    mov r5, #111   @ set the numerator
    mov r6, #6     @ set the denominator

_test:
    cmp r5, r6     @ number - denom 
    bge _subtract  @ numer > denom
    mov r1, r5     @ what's left of numer is mod result
    bal _exit      @ number < denom, exit

_subtract:
    sub r5, r6     @ subtract denom from numer
    add r0, r0, #1 @ add 1 to the counter
    bal _test      @ test to again to see if done

_exit:
    mov r7, #1
    SWI 0
