@ Purpose: Efficient technique for calculating a/b and a%b
@ a/b -> counter contained in r0
@ a%b -> remainder contained in r1
@ a -> contained in r2
@ b -> contained in r3
@ Divisor Scale -> r4 
@ Subtraction Scale -> r5 = b*r4


    divmod
    cmp r1, r3   @ compare and exit if a < b
    @ blt _exit
    bl scaleL
    bl divMod
    
    @scale left
    scaleL:
    sub sp, sp, #16
    str lr, [sp]
    str r4, [sp]
    str r5, [sp]
    mov r4, r4, lsl#1
    mov r5, r5, lsl#1
    cmp r1, r5
    bgezl scaleL
    mov r4, r4, lsr#1
    mov r5, r5, lsr#1

    /* Restore original values */
    ldr r5, [sp]
    ldr r4, [sp]
    ldr lr, [sp]
    add sp, sp, #16
    
    @add sub
    addSub:
    add r0, r0, r4
    sub r1, r1, r5
    bal ScaleR

    asTest:
    cmp r4, #1  @ test whether addSbu loop should continue
    bge addSub 
    @  blt _exit

    @scale right
    _ScaleR:
    mov r4, r4, lsr#1
    mov r5, r5, lsr#1
    cmp r1, r5
    blt _ScaleR
    bge _asTest

@_exit:
@    mov r7, #1
@    swi 0

    .global main
main:
    sub sp, sp, #8
    str lr, [sp]
    @ declare variables in intitialize r2/r3 => r0  r2%r3 =>r1
    mov r2, #24
    mov r3, #6
    mov r4, #1
    mov r5, r3
    mov r0, #0
    mov r1, r2

    bl divmod

    ldr lr, [sp]
    bx lr
