.text

.global scaleRight

scaleRight:
    push {lr}
    doWhile_r1_lt_r2:
        mov r3, r3, lsr#1
        mov r2, r2, lsr#1
    cmp r1, r2
    blt doWhile_r1_lt_r2

    pop {lr}
    bx lr
