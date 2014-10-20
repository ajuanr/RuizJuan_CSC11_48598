.text
.global divMod
divMod:
    push {lr}

    mov r0, #0
    mov r3, #1
    cmp r1, r2
    blt exit

    bl scaleLeft
    bl addSub

    exit:
        pop {lr}
    bx lr
