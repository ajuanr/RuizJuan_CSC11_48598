/*
 * This program initializes and array with temperatures from 32 to 212
 * in increments of five degrees
 * It convert the temperatures in degrees faranheit to celcius
 */

.data

.align 4
tempArray: .skip 1024

.align 4
val: .asciz "%d "                          /* equivalent to tempArray[i] */



.global main

/* fill array function */
/* number of elements passed as r0
/* array is passed as r1 */
fillArray:
    push {r4, r5, r6, r7, r8, lr}

    mov r4, r0      /* r4 holds the numbmer of elements */
    mov r5, r1      /* r5 holds the array */


    mov r7, #0   /* start counting from zero */
    mov r8, #32  /* initial temperature is 32 F */
    fillLoop:
       ldr r0, =val
       mov r1, r8
       bl printf

       str r8, [r5, r7, lsl#2] 
       add r7, r7, #1           /* increment loop counter */
       add r8, r8, #5           /* increment temp in 5 degree increments */
       cmp r7, r4
       bne fillLoop
    
    pop {r4, r5, r6,r7, r8, lr}
    bx lr

/* Print the elements of an array
 * r0 = number of elements
 * r1 = the array
 */
printArray:
    push {r4, r5, r6, lr}

    mov r4, r0              /* r4 holds the number of elements */
    mov r5, r1              /* r5 holds the array */

    mov r6, #0              /* r6 holds the loop counter */
    printLoop:
        ldr r1, [r5, r6, lsl#2]    /* get the element */
        mov r1, r1
        ldr r0, =val
        bl printf

        add r6, r6, #1      /* increment and check if looping is complete */
        cmp r4, r6
        bne printLoop        

    pop {r4, r5, r6, lr}
    bx lr
   
    

main:
    push {lr}
    sub sp, sp, #4      /* keep stack 8-byte aligned */
 
    mov r0, #198
    ldr r1, =tempArray


    bl fillArray
    bl printArray

    /* print the values 
    mov r4, #0       /* this is the loop counter *
    mov r5, r0
    printLoop:
        cmp r4, r5
        beq stageRight
        ldr r0, =val
        bl printf
        add r4, r4, #1
        ldr r1, [r1, r4, lsl#2]
        b printLoop 
*/    

    
    stageRight:       /* program complete. Exit stage right */
    add sp, sp, #4
    pop {lr}
    bx lr