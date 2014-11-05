.data
/* Holds the time before running collatz */
.balign 4
beg: .word 0

/* Holds the time after running collatz */
.balign 4
end: .word 0

/* variable for collatz function */
colVar: .word 0

/* Tell user how long function took */
message: .asciz "Collatz function\n"

/* Tell user time at function call */
cur_time: .asciz "The current time is: %d\n"

/* Display delta time */
delta: .asciz "Delta: %d\n"
.text
    .global main
main:
    push {lr}

    ldr r0, ad_of_message
    bl printf

        /* Get initial time */
    mov r0, #0
    bl time
    ldr r1, ad_of_beg
    str r0, [r1]
    ldr r1, [r1]
    ldr r0, ad_of_curTime
    bl printf

         /* Call collatz function */
    mov r0, #1000
    bl collatz

        /* Get final time */
    mov r0, #0
    bl time
    ldr r1, ad_of_end
    str r0, [r1]
    ldr r1, [r1]
    ldr r0, ad_of_curTime
    bl printf

        /* get delta time */
    ldr r1, ad_of_beg
    ldr r1, [r1]
    ldr r2, ad_of_end
    ldr r2, [r2]
    sub r1, r2, r1
    ldr r0, ad_of_delta
    bl printf

    ldr r0, ad_of_message
    bl printf

        /* Get initial time */
    mov r0, #0
    bl time
    ldr r1, ad_of_beg
    str r0, [r1]
    ldr r1, [r1]
    ldr r0, ad_of_curTime
    bl printf

        /* Call collatz function */
    mov r0, #1000
    bl collatz2

        /* Get final time */
    mov r0, #0
    bl time
    ldr r1, ad_of_end
    mov r1, r0
    ldr r0, ad_of_curTime
    bl printf

        /* get delta time */
    ldr r1, ad_of_beg
    ldr r1, [r1]
    ldr r2, ad_of_end
    ldr r2, [r2]
    sub r1, r2, r1
    ldr r0, ad_of_delta
    bl printf

    pop {lr}
    bx lr

ad_of_message: .word message
ad_of_beg: .word beg
ad_of_end: .word end
ad_of_curTime: .word cur_time
ad_of_colVar: .word colVar
ad_of_delta: .word delta

.global printf
.global time
    ldr r0, ad_of_delta
