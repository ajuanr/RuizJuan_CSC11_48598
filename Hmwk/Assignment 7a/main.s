/* Ask user for temp prompt */
prompt: asciz "Enter the temperature in degrees farenheit\n"

/* scan format */
.balign 4
format: .asciz "%d"

/* Result */
result: "Temp is %d\n"


.global main

main:
    push {lr}      /* save the link registers */

    ldr r0, ad_of_prompt
    bl printf

    push {r1}      /* push r1 onto stack before read */
    bl scanf

    ldr r1, sp
    ldr r0, ad_of_result 
    bl printf


ad_of_prompt: .word prompt
ad_of_result: .word result
