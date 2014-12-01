.data
begTime: .word 0
endTime: .word 0

result: .asciz "\nInteger Dynamic Pressure = %f lbs\nCross-Sectional Area x 32 = %f ft^2\nInteger Drag x 32 = %f lbs\n\n"
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

        /* load constants */
    ldr r1, =fRho
    vldr s7, [r1]              /* s7 = fRho */
    ldr r1, =fVel
    vldr s8, [r1]              /* s8  = fVel */
    ldr r1, =fRad
    vldr s9, [r1]              /* s9 = fRad */
    ldr r1, =fConv
    vldr s10, [r1]             /* s10 = fConv */
    ldr r1, =fCd
    vldr s11, [r1]             /* s11 = fCd */
    
     
    ldr r1, =fHalf
    vldr s14, [r1]             /* s14 = fDynp = fHalf */
    ldr r1, =fPi
    vldr s15, [r1]             /* s15 = fArea = fPi */
    vmov s16, s14              /* s16 = fDrag = fDynp * fArea */
    vmul.f32 s16, s16, s15

    vmul.f32 s14, s14, s7      @ fDynp*=fRho;
    vmul.f32 s14, s14, s8      @ fDynp*=fVel;
    vmul.f32 s14, s14, s8      @ fDynp*=fVel;
    vmul.f32 s15, s15, s9      @ fArea*=fRad;
    vmul.f32 s15, s15, s9      @ fArea*=fRad;
    vmul.f32 s15, s15, s10     @ fArea*=fConv;
    vmul.f32 s16, s16, s11      @ fDrag*=fCd;

    vcvt.f64.f32 d0, s14
    ldr r0, =testMsg
    vmov r2, r3, d0
    bl printf

    add sp, sp, #4
    pop {lr}
    bx lr

ad_of_result: .word result
ad_of_testMsg: .word testMsg

.global printf
.global scanf
