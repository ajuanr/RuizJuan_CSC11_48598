/* Farenheit to Celcius
 * Version 1
 *     To compile:
 *         gcc -c divmod.s
 *         gcc -c main.s
 *         gcc divmod.o main.o -o f2c
 */


.data
prompt: .asciz "Enter temperature from 32-212 in degrees Farenheit: "
format: .asciz "%d"
result: .asciz "Temp is %d"
result2: .asciz ".%d\n"       /* used this because of error I was getting*/

begTime: .word 0
endTime: .word 0

convert:
    push {lr}

    ldr r0, ad_of_prompt
    bl printf

    sub sp, sp, #4     /* make room on stack for read */
    mov r1, sp         /* move  r1 onto stack before read */
    ldr r0, ad_of_format
    bl scanf

    /* Perform the conversion */
    ldr r1, [sp]
    sub r1, r1, #32    /* r0 = (F-32) */
    mov r2, #5      /* temp value in order to multiply r0 by 5 */
    mul r1, r2, r1     /* r0 = (F-32) * 5 */
    mov r2, #9
    bl divMod

    add sp, sp, #4
    pop {lr}
    bx lr

ad_of_prompt: .word prompt
ad_of_format: .word format

.text
.global main
main:
    push {lr}      /* save the link register */

   
    
    bl convert

    /* after conversion r0 holds integer part
                        r1 holds decimal part */
    mov r4, r1
    mov r1, r0
    /* Print the result */
    ldr r0, ad_of_result 
    bl printf

    ldr r0, ad_of_result2
    mov r1, r4
    bl printf

    /* exit */
    pop {lr}
    bx lr

ad_of_result: .word result
ad_of_result2: .word result2
ad_of_begTime: .word begTime
ad_of_endTime: .word endTime
