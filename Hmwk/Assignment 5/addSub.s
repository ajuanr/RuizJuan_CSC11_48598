.text
.global addSub

addSub:
    push {lr}
    doWhile_r3_ge_1:
        add r0, r0, r3
        sub r1, r1, r2
        bl scaleRight
    cmp r3, #1
    bge doWhile_r3_ge_1

    pop {lr}     /* Exit the function */
    bx lr
