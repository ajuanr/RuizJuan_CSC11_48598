/* To compile
 *
 *
 */

.data
prompt: .asciz "Enter temperature from 32-212 in degrees Farenheit: "
format: .asciz "%d"
result: .asciz "Temp is %d"
result2: .asciz ".%d\n"       /* used this because of error I was getting*/

fiveNine: .word 0

.global main
main:
    push {lr}

    ldr r0, ad_of_prompt
    bl printf

    ldr r0, ad_of_format
    sub sp, sp, #4
    mov r1, sp
    bl scanf

    ldr r2, ad_of_fiveNine
    mov r2, #0x8E38F

    ldr r1, [sp]
    sub r1, r1, #32        /* (F-32) */

    ldr r0, ad_of_result
    bl printf


    pop {r1, lr}
    bx lr

ad_of_prompt: .word prompt
ad_of_result: .word result
ad_of_format: .word format
ad_of_fiveNine: .word fiveNine
