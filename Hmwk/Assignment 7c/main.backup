/* be sure to pass the flag -mfpu=vfpv2 to 'as' command
 *    as  -mfpu=vfpv2 -o main.o main.s
 *    gcc -o main main.s
 */
.data
prompt: .asciz "Enter temperature from 32-212 in degrees Farenheit: "
format: .asciz "%f"
result: .asciz "Temp is %f\n"
initial: .word 0

thirtyTwo: .float 32.0
five: .float 5.0
nine: .float 9.0

.global main
main:
    push {lr}
    sub sp, sp, #4          /* 8-byte align the stack */

    ldr r0, ad_of_prompt    /* print message to user */
    bl printf

    ldr r0, ad_of_format    /* read in the value */
    ldr r1, ad_of_initial
    bl scanf

    ldr r1, ad_of_initial   /* put the value in floating point register */
    vldr s14, [r1]

    ldr r1, ad_of_thirtyTwo /* Get registers ready to put into floaing point*/
    ldr r2, =five
    ldr r3, =nine

    vldr s15, [r1]          /* Load the registers */
    vldr s16, [r2]
    vldr s17, [r3]

    vsub.f32 s14, s14, s15  /* This is (F-32) as part of conversion */
    vmul.f32 s14, s14, s16
    vdiv.f32 s14, s14, s17
    

    vcvt.f64.f32 d0, s14    /* convert to double for printing  */
  
    ldr r0, =result         /* print the number */
    vmov r2, r3, d0
    bl printf

    add sp, sp, #4         /* restore the stack */
    pop {lr}               /* and exit */
    bx lr

ad_of_prompt: .word prompt
ad_of_format: .word format
ad_of_initial: .word initial
ad_of_thirtyTwo: .word thirtyTwo
