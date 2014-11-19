/* To compile
 *
 *
 */

.data
prompt: .asciz "Enter temperature from 32-212 in degrees Farenheit: "
format: .asciz "%d"
result: .asciz "Temp is %d"
result2: .asciz ".%d\n"       /* used this because of error I was getting*/


.global main
main:
    push {lr}

    ldr r0, ad_of_prompt
    bl printf

    ldr r0, ad_of_format
    push {r1}             /* push r1 onto stack before scanf */
    bl scanf

    ldr r0, ad_of_result
    ldr r1, [sp]
    ldr r1, [r1]
    bl printf


    pop {r1, lr}
    bx lr

ad_of_result: .word result
ad_of_format: .word format
