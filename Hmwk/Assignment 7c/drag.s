.data
begTime: .word 0
endTime: .word 0

result: .asciz "\nInteger Dynamic Pressure = %f lbs\nCross-Sectional Area x 32 = %f ft^2\nInteger Drag x 32 = %f lbs\n\n"
timing: .asciz "Ran in %d seconds\n"
testMsg: .asciz "%f\n"


fHalf: .float 0.5
fRho: .float 0.00237      //slug/ft^3
fVel: .float 200          //ft/sec
fPi: .float 3.1415926     //atan(1)*4; //Pi
fRad: .float 6            //Radius 6 to 18 inches
fConv: .float 1.0         //144    //inches to feet
fCd: .float 0.4           //Spherical Cd

.text
.global main
main:
    /* remember to divide by 144 */

    push {lr}
    sub sp, sp, #4             /* 8-byte align the sp */
    
    ldr r1, =fHalf
    vldr s14, [r1]

    vcvt.f64.f32 d0, s14
    ldr r0, =testMsg
    vmov r2, r3, d0
    bl printf

    add sp, sp, #4
    pop {lr}
    bx lr

ad_of_result: .word result
ad_of_timing: .word timing
ad_of_testMsg: .word testMsg

.global time
.global printf
.global scanf
