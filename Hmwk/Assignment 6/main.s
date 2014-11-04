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

    /* call collatz function */
    mov r0, #1
    mov r3, #0
    mov r4, #100
    add r4, r4, r4, lsl #10
    loop:
        mov r0, #100
        cmp r3, r4
        bl collatz
        addne r3, r3, #1
        bne loop

    done:
    mov r1, r4
    ldr r0, ad_of_message
    bl printf
 
    mov r1, r2
    @bl time
    ldr r0, ad_of_message
    bl printf

    /* Get final time */
    mov r0, #0
    @bl time
    mov r1, r0


    /* print message to user */
    ldr r0, ad_of_message
    @bl printf
    ldr r2, ad_of_beg
    ldr r2, [r2]
    sub r1, r2, r1   /* r1 <- r2- r1 */

    pop {lr}
    bx lr
     
ad_of_message: .word message
ad_of_beg: .word beg
ad_of_end: .word end

.global printf
.global time
