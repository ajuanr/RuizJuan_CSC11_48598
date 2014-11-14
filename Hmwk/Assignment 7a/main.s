/* Farenheit to Celcius
 * Version 1
 *     To compile:
 *         gcc -c divmod.s
 *         gcc -c main.s
 *         gcc divmod.o main.o -o f2c
 */


.data
prompt: .asciz "Enter temperature in degrees Farenheit: "
format: .asciz "%d"
result: .asciz "Temp is %d\n"

.text
.global main
main:
    push {lr}      /* save the link register */

    ldr r0, ad_of_prompt
    bl printf

    sub sp, sp, #4     /* make room on stack for read */
    mov r1, sp         /* move  r1 onto stack before read */
    ldr r0, ad_of_format
    bl scanf

    /* Perform the conversion */
    ldr r0, [sp]
    sub r0, r0, #32    /* r0 = (F-32) */
    mov r1, #5      /* temp value in order to multiply r0 by 5 */
    mul r0, r1, r0     /* r0 = (F-32) * 5 */
    mov r1, #9
    bl divMod

@    mov r2, r1
    mov r1, #7

    /* Print the result
    ldr r0, ad_of_result 
    bl printf

    /* exit */
    add sp, sp, #4
    pop {lr}
    bx lr


ad_of_prompt: .word prompt
ad_of_format: .word format
ad_of_result: .word result
