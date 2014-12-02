/* be sure to pass the flag -mfpu=vfpv2 to 'as' command
 *    as  -mfpu=vfpv2 -o temp.o temp.s
 *    gcc -o temp temp.s
 */
.data
.balign 4
delta: .asciz "Delta time is %d\n"
.balign 4
result: .asciz "Temp is %f\n"

initial: .float 212.0
thirtyTwo: .float 32.0
five: .float 5.0
nine: .float 9.0

/* for delta time */
beg: .word 0
end: .word 0

.text
.global main
main:
    push {lr}
    sub sp, sp, #4          /* 8-byte align the stack */

    mov r0, #0
    bl time
    ldr r1, ad_of_beg
    str r0, [r1] 

    ldr r5, =100000000
    loop:
    cmp r5, #0
    beq cont
    ldr r1, =initial   /* put the value in floating point register */
    vldr s14, [r1]

    ldr r1, =thirtyTwo /* Get registers ready to put into floaing point*/
    ldr r2, =five
    ldr r3, =nine

    vldr s15, [r1]          /* Load the registers */
    vldr s16, [r2]
    vldr s17, [r3]

    vsub.f32 s14, s14, s15  /* This is (F-32) as part of conversion */
    vmul.f32 s14, s14, s16
    vdiv.f32 s14, s14, s17
    
    sub r5, r5, #1
    b loop
   
    cont: 
    mov r0, #0
    bl time
    ldr r1, ad_of_end
    str r0, [r1] 

    ldr r1, =beg
    ldr r1, [r1]
    ldr r2, =end
    ldr r2, [r2]
    sub r1, r2, r1
    ldr r0, =delta
    bl printf

    vcvt.f64.f32 d0, s14    /* convert to double for printing  */
  
    ldr r0, =result         /* print the number */
    vmov r2, r3, d0
    bl printf

    mov r7, #1
    swi 0
    add sp, sp, #4         /* restore the stack */
    pop {lr}               /* and exit */
    bx lr

ad_of_beg: .word beg
ad_of_end: .word end

.global time
.global printf
