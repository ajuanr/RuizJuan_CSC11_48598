/* as -o main.o main.s
 * gcc -o main main.s
 */
.data
result: .asciz "Temp is %d\n"
beg: .word 0
end: .word 0
delta: .asciz "Delta for integer shift is: %d\n"

.global main
main:
    push {lr}
    ldr r2, =0x8E38F       /* 20 bits    >>20 */

    /* Get initial time */
    mov r0, #0
    bl time
    ldr r1, ad_of_beg
    str r0, [r1]
    ldr r1, [r1]

    ldr r5, =100000000
    for:
    cmp r5, #0
    beq exit
    /* Convert */
    mov r1, #212
    sub r1, r1, #32        /* r1 = (Temp-32) */
    mul r1, r2, r1          /* r1 = r1 * (5/9)<<20 */ 
    mov r1, r1, lsr#20    /* r1 >> 20 */ 
    sub r5, r5, #1
    b for

    /* Get final time */
    exit: 
    mov r0, #0
    bl time
    ldr r2, ad_of_end
    str r0, [r2]

    ldr r0, ad_of_result
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

ad_of_result: .word result
ad_of_beg: .word beg
ad_of_end: .word end
ad_of_delta: .word delta
