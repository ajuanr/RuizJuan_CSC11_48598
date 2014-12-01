/* be sure to pass the flag -mfpu=vfpv2 to 'as' command
 *    as  -mfpu=vfpv2 -o main.o main.s
 *    gcc -o main main.s
 */
.data
prompt: .asciz "Enter temperature from 32-212 in degrees Farenheit: "
format: .asciz "%f"
result: .asciz "Temp is %f\n"
initial: .word 0


/* 5/9 */
fiveNine: .float 0.555

/* thrtyTwo */
thrtyTwo: .float 32.0

.global main
main:
    push {lr}

    ldr r0, ad_of_prompt
    bl printf

    ldr r0, ad_of_format
    ldr r1, ad_of_initial
    bl scanf

    ldr r1, ad_of_initial
    vldr s14, [r1]

    mov r1, #5
    mov r2, #9
    mov r3, #32
    vmov s17, r1
    vmov s18, r2
    vmov s19, r3

    vadd.f32 s14, s14, s19
    @vmul.f32 s14, s14, s12

    vcvt.f64.f32 d0, s14    /* convert to double for printing */
  
    ldr r0, ad_of_result
    vmov r2, r3, d0
    bl printf

    pop {lr}
    bx lr

ad_of_prompt: .word prompt
ad_of_result: .word result
ad_of_format: .word format
ad_of_initial: .word initial
ad_of_fiveNine: .word fiveNine
ad_of_thrtyTwo: .word thrtyTwo
