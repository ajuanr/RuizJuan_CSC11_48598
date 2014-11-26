.data
begTime: .word 0
endTime: .word 0



iDyn: .asciz "Integer Dynamic Pressure  = %d\n"
cross: .asciz "Cross Sectional Area x 32 = %d\n"
iDrag: .asciz "Integer Drag x 32 = %d\n"
.text
.global main
main:
    push {lr}
    //Test the 2 functions
    @unsigned int nLoops=1000000000;

    mov r4, #1               /* unsigned int iHalf=1;      // 1 bit,  >>1 */
    ldr r5, =0x9B5           /* unsigned int iRho=0x9B5;   //12 bits, >>20 */
    mov r6, #200             /* unsigned int iVel=200;     // 8 bits */
    ldr r7, =0x3243F7        /* unsigned int iPi=0x3243F7; //24 bits, >>20 */
    mov r8, #6               /* unsigned int iRad=6;       // 4 bits */
    ldr r9, =0x1C7           /* unsigned int iConv=0x1C7;  //12 bits, >>16 */
    ldr r10, =0x666          /* unsigned int iCd=0x666;    //12 bits, >>12 */
    //Time for the integer function
    @begTime=time(0);
    ldr r11, ad_of_begTime
    bl time
    str r0, [r1]
    
    @for(unsigned int i=1;i<=nLoops;i++){
    ldr r11, =100000000
    for:
        cmp r11, #0
        beq exit  
        mov r1, r4           /* iDynp=iHalf;  //xBit  1, BP- 1 */
        mul r1, r5, r1       /* iDynp*=iRho;  //xBit 12, BP-21 */
        mul r1, r6, r1       /* iDynp*=iVel;  //xBit 20, BP-21 */
        mul r1, r6, r1       /* iDynp*=iVel;  //xBit 28, BP-21 */
        mov r1, r1, lsr#12   /* iDynp>>=12;   //xBit 16, BP- 9 */
        mov r2, r7           /* iArea=iPi;    //xBit 24, BP-20 */
        mul r2, r8, r2       /* iArea*=iRad;  //xBit 28, BP-20 */
        mul r2, r8, r2       /* iArea*=iRad;  //xBit 32, BP-20 */
        mov r2, r2, lsr#12   /* iArea>>=12;   //xBit 20, BP- 8 */
        mul r2, r9, r2       /* iArea*=iConv; //xBit 32, BP-24 */
        mov r2, r2, lsr#16   /* iArea>>=16;   //xBit 16  BP- 8 */
        mul r3, r1, r2       /* iDrag=iDynp*iArea;//xBit 32 BP-17 */
        mov r3, r3, lsr#12   /* iDrag>>=12;   //xBit 20  BP- 5 */
        mul r3, r10, r3       /* iDrag*=iCd;   //xBit 32  BP-17 */
        sub r11, r11, #1
        b for
    exit: 
    @endTime=time(0);
    ldr r11, ad_of_endTime
    bl time
    str r0, [r1]

    ldr r0, ad_of_result
    mov r1, r1, lsr#9
    bl printf

    ldr r0, ad_of_cross
    /* print time differential */
    ldr r2, ad_of_endTime
    ldr r2, [r2]
    ldr r1, ad_of_begTime
    ldr r1, [r1]
    sub r1, r2, r1
    @mov r1, r2 @, lsr#3
    bl printf

    ldr r0, ad_of_iDrag
    mov r1, r3, lsr#12
    bl printf

    pop {lr}
    bx lr

ad_of_begTime: .word begTime
ad_of_endTime: .word endTime
ad_of_result: .word iDyn
ad_of_cross: .word cross
ad_of_iDrag: .word iDrag
