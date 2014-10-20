/* -- printf02.s */
.data
 
/* First message */
.balign 4
message1: .asciz "Hey, type in two numbers: "
 
/* Division result message */
.balign 4
message2: .asciz "a/b = %d  and  a%%b = %d\n"

/* Mod result message */
.balign 4
message3: .asciz "%d %% %d = %d\n"

/* Format pattern for scanf */
.balign 4
scan_pattern : .asciz "%d %d"
 
/* Where scanf will store the number read */
.balign 4
number_read: .word 0

.balign 4
denom_read: .word 0
 
.balign 4
return: .word 0
 
.balign 4
return2: .word 0
 
.text
 
/*
divide function
*/
divMod:
    push {lr}

    mov r0, #0
    mov r3, #1
    cmp r1, r2
    blt exit

    bl scaleLeft
    bl addSub
    
@scale left
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
    
@add sub
addSub:
    push {lr}
    doWhile_r3_ge_1:
        add r0, r0, r3
        sub r1, r1, r2
        bl scaleRight
    cmp r3, #1  @ test whether addSub loop should continue
    bl doWhile_r3_ge_1

    pop {lr}     /* Exit the function */
    bx lr

@scale right
scaleRight:
    push {lr}
    doWhile_r1_lt_r2:
        mov r3, r3, lsr#1
        mov r2, r2, lsr#1
    cmp r1, r2
    blt doWhile_r1_lt_r2

    pop {lr}
    bx lr

exit:
    pop {lr}
    bx lr

 
.global main
main:
    push {lr} 

    ldr r0, address_of_message1      /* r0 <- &message1 */
    bl printf                        /* call to printf */
 
    ldr r0, address_of_scan_pattern  /* r0 <- &scan_pattern */
    ldr r1, address_of_number_read   /* r1 <- &number_read */
    ldr r2, address_of_denom_read
    bl scanf                         /* call to scanf */
 
    ldr r1, address_of_number_read   /* r0 <- &number_read */
    ldr r1, [r1]                     /* r0 <- *r0 */
    ldr r2, address_of_denom_read
    ldr r2, [r2]

    bl divMod
 
    mov r2, r1
    mov r1, r0

    /* Print a/b */
    ldr r0, address_of_message2      /* r0 <- &message2 */
    bl printf                        /* call to printf */
 
    pop {lr}
    bx lr                            /* return from main using lr */
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_scan_pattern : .word scan_pattern
address_of_number_read : .word number_read
address_of_denom_read : .word denom_read
address_of_message3: .word message3
 
/* External */
.global printf
.global scanf
