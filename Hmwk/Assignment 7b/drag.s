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
    //Integer Function and Variables
    mov r0, #0 
    mov r1, #0
    mov r2, #0

    /* Constants */
    mov r3, #1     // 1 bit,  >>1
    ldr r4, =0x9B5  //12 bits, >>20
    mov r5, #200    // 8 bits
    ldr r6, =0x3243F7//24 bits, >>20
    mov r7, #6      // 4 bits
    ldr r8, =0x1C7 //12 bits, >>16
    ldr r9, =0x666   //12 bits, >>12
    //Time for the integer function
    @begTime=time(0);

    @for(unsigned int i=1;i<=nLoops;i++){
        mov r0, r3           /* iDynp=iHalf;  //xBit  1, BP- 1 */
        mul r0, r4, r0       /* iDynp*=iRho;  //xBit 12, BP-21 */
        mul r0, r5, r0       /* iDynp*=iVel;  //xBit 20, BP-21 */
        mul r0, r5, r0       /* iDynp*=iVel;  //xBit 28, BP-21 */
        mov r0, r0, lsr#12   /* iDynp>>=12;   //xBit 16, BP- 9 */
        mov r1, r6           /* iArea=iPi;    //xBit 24, BP-20 */
        mul r1, r7, r1       /* iArea*=iRad;  //xBit 28, BP-20 */
        mul r1,r7, r1        /* iArea*=iRad;  //xBit 32, BP-20 */
        mov r1, r1, lsr#12   /* iArea>>=12;   //xBit 20, BP- 8 */
        mul r1, r8, r1       /* iArea*=iConv; //xBit 32, BP-24 */
        mov r1, r1, lsr#16   /* iArea>>=16;   //xBit 16  BP- 8 */
        mul r2, r0, r1       /* iDrag=iDynp*iArea;//xBit 32 BP-17 */
        mov r2, r2, lsr#12   /* iDrag>>=12;   //xBit 20  BP- 5 */
        mul r2, r9, r2       /* iDrag*=iCd;   //xBit 32  BP-17 */
    @endTime=time(0);

    mov r3, r2
    mov r2, r1 
    mov r1, r0, lsr#9
   
    ldr r0, ad_of_result
    bl printf

    ldr r0, ad_of_cross
    mov r1, r2 @, lsr#3
    bl printf

    ldr r0, ad_of_iDrag
    mov r1, r3 @, lsr#12
    bl printf

    pop {lr}
    bx lr

ad_of_begTime: .word begTime
ad_of_endtime: .word endTime
ad_of_result: .word iDyn
ad_of_cross: .word cross
ad_of_iDrag: .word iDrag
