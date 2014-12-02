/* as -o main.o main.s
 * gcc -o main main.s
 */
.data
prompt: .asciz "Enter temperature from 32-212 in degrees Farenheit: "
format: .asciz "%d"
result: .asciz "Temp is %d\n"

.global main
main:
    push {lr}

    ldr r0, ad_of_prompt
    bl printf

    ldr r0, ad_of_format
    sub sp, sp, #4
    mov r1, sp
    bl scanf

    ldr r2, =0x8E38F       /* 20 bits    >>20 */

    ldr r1, [sp]
    sub r1, r1, #32        /* r1 = (Temp-32) */
    mul r1, r2, r1          /* r1 = r1 * (5/9)<<20 */ 
    mov r1, r1, lsr#20    /* r1 >> 20 */ 
   
    ldr r0, ad_of_result
    bl printf

    add sp, sp, #4
    pop {lr}
    bx lr

ad_of_prompt: .word prompt
ad_of_result: .word result
ad_of_format: .word format
