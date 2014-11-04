.data
/* Holds the time before running collatz */
.balign 4
beg: .word 0

/* Holds the time after running collatz */
.balign 4
end: .word 0

/* Tell user how long function took */
message: .asciz "The collatz function took %d seconds to run\n"

.text
    .global main
main:
    push {lr}

    /* Get initial time */
    mov r0, #0
    bl time
    mov r1, r0
    ldr r0, ad_of_message
    bl printf

    /* call collatz function */
    mov r0, #1
    mov r3, #0
    loop:
        cmp r3, #100
        addne r3, r3, #1
        bl collatz
        bne loop

    /* Get final time */
    bl time
    mov r1, r0
    ldr r0, ad_of_message
    bl printf

    /* print message to user */
    ldr r0, ad_of_message
    sub r1, r2, r1   /* r1 <- r2- r1 */
    bl printf

    pop {lr}
    bx lr
     
ad_of_message: .word message
ad_of_beg: .word beg
ad_of_end: .word end

.global printf
.global time
