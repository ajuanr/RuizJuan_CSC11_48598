.data
prompt: .asciz "Enter temperature in degrees Farenheit :"
format: .asciz "%d"
result: .asciz "Temp is %d\n"

.text
.global main
main:
    push {lr}      /* save the link register */

    ldr r0, ad_of_prompt
    bl printf

    sub sp, sp, #4     /* make room on stack for read */
    mov r1, sp      /* push r1 onto stack before read */
    ldr r0, ad_of_format
    bl scanf

    ldr r1, [sp]
    ldr r0, ad_of_result 
    bl printf
    add sp, sp, #4
    pop {lr}
    bx lr


ad_of_prompt: .word prompt
ad_of_format: .word format
ad_of_result: .word result
