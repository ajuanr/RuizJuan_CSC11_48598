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
    push {lr}

    /* Get initial time */
    ldr r0, ad_of_beg
    bl time

    /* call collatz function */
    bl collatz

    /* Get final time */
    ldr r0, ad_of_end
    bl time

    /* print message to user */
    ldr r0, ad_of_message
    ldr r1, ad_of_beg
    ldr r2, ad_of_end
    sub r1, r2, r1
    bl printf

    pop {lr}
    bx lr
     
ad_of_message: .word message
ad_of_beg: .word beg
ad_of_end: .word end

.global printf
.global time
