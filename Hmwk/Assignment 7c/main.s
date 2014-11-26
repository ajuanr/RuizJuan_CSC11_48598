/* as -o main.o main.s
 * gcc -o main main.s
 */
.data
prompt: .asciz "Enter temperature from 32-212 in degrees Farenheit: "
format: .asciz "%f"
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

    vldr s14, [sp]
    vcvt.f64.f32 d0, s14
  
    vmov r2, r3, d0
    ldr r0, ad_of_result
    bl printf

    add sp, sp, #4
    pop {lr}
    bx lr

ad_of_prompt: .word prompt
ad_of_result: .word result
ad_of_format: .word format
