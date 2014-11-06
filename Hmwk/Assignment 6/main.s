.data
/* Holds the time before running collatz */
.balign 4
beg: .word 0

/* Holds the time after running collatz */
.balign 4
end: .word 0

/* variable for collatz function */
colVar: .word 0

/* scan format */
format: .asciz "%d"

/* prompt */
prompt: .asciz "Enter a number for collatz function: "

/* Tell user what function they are in*/
message1: .asciz "In unpredicated collatz function\n"
message2: .asciz "In predicated collatz function"

/* Display delta time */
delta: .asciz "Delta: %d\n"
.text
    .global main
main:
    push {lr}


        /* Get initial time */
    mov r0, #0
    bl time
    ldr r1, ad_of_beg
    str r0, [r1]
    ldr r1, [r1]

         /* Get initial value for both collatz functions */
    ldr r0, ad_of_prompt
    bl printf
    ldr r0, ad_of_format
    ldr r1, ad_of_colVar
    bl scanf


         /* tell user what function is running */
    ldr r0, ad_of_message1
    bl printf

    ldr r0, ad_of_colVar
    ldr r0, [r0]
         /* Call collatz function */
    bl collatz

        /* Get final time */
    mov r0, #0
    bl time
    ldr r2, ad_of_end
    str r0, [r2]
    ldr r2, [r2]

        /* get delta time */
    ldr r1, ad_of_beg
    ldr r1, [r1]
    ldr r2, ad_of_end
    ldr r2, [r2]
    sub r1, r2, r1
    ldr r0, ad_of_delta
    bl printf


        /* Get initial time */
    mov r0, #0
    bl time
    ldr r1, ad_of_beg
    str r0, [r1]
    ldr r1, [r1]

         /* tell user what function is running */
    ldr r0, ad_of_message1
    bl printf

        /* Call collatz function */
    ldr r0, ad_of_colVar
    ldr r0, [r0]
    bl collatz2

        /* Get final time */
    mov r0, #0
    bl time
    ldr r2, ad_of_end
    str r0, [r2]

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

ad_of_message1: .word message1
ad_of_message2: .word message2
ad_of_beg: .word beg
ad_of_end: .word end
ad_of_colVar: .word colVar
ad_of_delta: .word delta
ad_of_prompt: .word prompt
ad_of_format: .word format

.global printf
.global time
