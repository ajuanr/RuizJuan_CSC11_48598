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
result: .asciz "Temp is %d\n"
result2: .asciz ".%d\n"       /* used this because of error I was getting*/
delta: .asciz "The delta is %d\n" 

begTime: .word 0
endTime: .word 0

.text
.global main
main:
    push {lr}      /* save the link register */
    
    /* get initial time */
    mov r0, #0
    bl time
    ldr r4, ad_of_begTime
    str r0, [r4]

    ldr r5, =100000000
    for:
        cmp r5, #0
        beq exit
        /* Perform the conversion */
        mov r1, #212
        sub r1, r1, #32    /* r0 = (F-32) */
        mov r2, #5      /* temp value in order to multiply r0 by 5 */
        mul r1, r2, r1     /* r0 = (F-32) * 5 */
        mov r2, #9
        bl divMod
        sub r5, r5, #1
        b for

    exit:
    mov r6, r0       /* Save result from conversion
    /* get final time */
    mov r0, #0
    bl time
    ldr r4, ad_of_endTime
    str r0, [r4]

    mov r1, r6
    ldr r0, ad_of_result 
    bl printf

    @ldr r0, ad_of_result2
    @mov r1, r4
    @bl printf

       /* get delta time */
    ldr r1, ad_of_begTime
    ldr r1, [r1]
    ldr r2, ad_of_endTime
    ldr r2, [r2]
    sub r1, r2, r1
    ldr r0, ad_of_delta
    bl printf 

    /* exit */
    pop {lr}
    bx lr

ad_of_result: .word result
ad_of_result2: .word result2
ad_of_begTime: .word begTime
ad_of_endTime: .word endTime
ad_of_delta: .word delta
