.text
.global scaleLeft
scaleLeft:
    push {lr}
    doWhile_r1_ge_r2:
        mov r3, r3, lsl#1
        mov r2, r2, lsl#1
    cmp r1, r2
    bge doWhile_r1_ge_r2
    mov r3, r3, lsr#1
    mov r2, r2, lsr#1

    /* Leave the function */
    pop {lr}
    bx lr
