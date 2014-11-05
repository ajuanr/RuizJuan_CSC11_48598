.data
/* Holds the time before running collatz */
.balign 4
beg: .word 0

/* Holds the time after running collatz */
.balign 4
end: .word 0

/* Tell user how long function took */
message: .asciz "Collatz function\n"

/* Tell user time at function call */
cur_time: .asciz "The current time is: %d\n"

.text
    .global main
main:
    push {lr}

    /* Get initial time */
    mov r0, #0
    bl time
    mov r1, r0
    mov r2, r0
    ldr r0, ad_of_cur_time
    bl printf

    /* Call collatz function */
    mov r0, #1
    add r0, r0, lsl #29
    bl collatz

    ldr r0, ad_of_message
    bl printf

    /* Get final time */
    mov r0, #0
    bl time
    mov r1, r0
    ldr r0, ad_of_cur_time
    bl printf


    /* Get initial time */
    mov r0, #0
    bl time
    mov r1, r0
    mov r2, r0
    ldr r0, ad_of_cur_time
    bl printf

    /* Call predicated collatz function */
    mov r0, #1
    add r0, r0, lsl #29
    bl collatz2

    ldr r0, ad_of_message
    bl printf


    /* Get final time */
    mov r0, #0
    bl time
    mov r1, r0
    ldr r0, ad_of_cur_time
    bl printf

    pop {lr}
    bx lr
     
ad_of_message: .word message
ad_of_beg: .word beg
ad_of_end: .word end
ad_of_cur_time: .word cur_time

.global printf
.global time
