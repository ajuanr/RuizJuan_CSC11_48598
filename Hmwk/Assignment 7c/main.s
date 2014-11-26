/* as -o main.o main.s
 * gcc -o main main.s
 */
.data
prompt: .asciz "Enter temperature from 32-212 in degrees Farenheit: "
format: .asciz "%f"
result: .asciz "Temp is %d\n"
initial: .float 0

.global main
main:
    push {lr}

    ldr r0, ad_of_prompt
    bl printf

    ldr r0, ad_of_format
    ldr r1, ad_of_initial
    bl scanf

    vldr s1, [r1]
    vcvt.f64.f32 d1, s1
  
    vmov r2, r3, d0
    ldr r0, ad_of_result
    bl printf

    pop {lr}
    bx lr

ad_of_prompt: .word prompt
ad_of_result: .word result
ad_of_format: .word format
ad_of_initial: .word initial
