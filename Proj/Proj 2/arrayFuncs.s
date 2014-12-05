/* This file holds functions for manipulating arrays */


.data
.balign 4
intOut: .asciz "%d "

.balign 4
newLine: .asciz "\n"
/* fill array function */
/* number of elements passed as r0 */
/* array is passed as r1 */

.text
.global fillArray
fillArray:
    push {r4, r5, r6, r7, r8, lr}        /* r8 is unused */

    mov r4, r0                           /* r4 holds the numbmer of elements */
    mov r5, r1                           /* r5 holds the array */

    mov r7, #0                           /* start counting from zero */
    fillLoop:
       str r7, [r5, r7, lsl#2]
       add r7, r7, #1                    /* increment loop counter */
       cmp r7, r4
       bne fillLoop

    pop {r4, r5, r6,r7, r8, lr}
    bx lr

/* Print the elements of an array
 * r0 = number of elements
 * r1 = input array
 */
.global printArray
printArray:
    push {r4, r5, r6, lr}

    mov r4, r0                             /* r4 holds the number of elements */
    mov r5, r1                             /* r5 holds the array */

    mov r6, #0                             /* r6 holds the loop counter */
    printLoop:
        ldr r1, [r5, r6, lsl#2]            /* get the element */
        ldr r0, adr_intOut
        bl printf

        add r6, r6, #1                     /* increment and check if looping is complete */
        cmp r4, r6
        bne printLoop

        /* print a new line */
        ldr r0, adr_newLine
        bl printf

    pop {r4, r5, r6, lr}
    bx lr
/* exit printArray */

/* Shuffle an array
 * r0 = number of elements
 * r1 = input array
 */
.global shuffle
shuffle:
    push {r4, r5, r6, r7, r8, r9, r10, lr}

    mov r4, r0                              /* save the number of elements */
    mov r5, r1                              /* and the array */

    /* shuffle 7 times */
    mov r6, #0                              /* r6 holds number of times shuffled */
 
    shuffleLoop:
        /* swap elements */
        mov r7, #0                          /* r7 holds counter for shuffleLoop */
        swapLoop:
            mov r0, #0                      /* min for random*/
            mov r1, r4                      /* max, for random */
            bl random                       /* get the index of the number to swap, in r0 */

            mov r3, r0                      /* save the index returned from random */
            ldr r1, [r5, r3,lsl#2]          /* save array[i] */ 
            ldr r2, [r5, r7, lsl#2]         /* save array[random] */
        
            str r1, [r5, r7, lsl#2]         /* swap the values */ 
            str r2, [r5, r3, lsl#2]
            
            add r7, r7, #1
            cmp r7, r4
            bne swapLoop
            
        add r6, r6, #1              
        cmp r6, #7
        bne shuffleLoop

    pop {r4, r5, r6, r7, r8, r9, r10, lr}
    bx lr
/* exit shuffle function */


/* Function deals one card
 * index where next card is              r0
 * deal card from array passed in        r1
 * index where card will be placed is in r2
 * deal the card to array passed in      r3
 */
.global dealOne
dealOne:
    push {r4, r5, r6, lr}
    
   @ mov r4, r0      /* save the card to be dealt */
   @ mov r5, r1      /* save the index */
   @ mov r6, r2      /* save the array */
    mov r7, r3
    ldr r4, [r1, r0, lsl#2]     /* grab card from */

@    mov r1,r4
@    ldr r0, adr_intOut
@    bl printf
    str r4, [r7, r2, lsl#2]     /* put card here */

    pop {r4, r5, r6, lr}
    bx lr
/* exit deal function */

/* Game opening. deal two cards two players and two to dealer *
 * pass player hand in r0
 * pass dealer hand in r1
 * pass cardIndex in r2
 *    return card index in r0
 */
.global dealInit
dealInit:
    push {r4, r5, r6, lr}

    mov r4, r0
    mov r5, r1
    mov r6, r2

    ldr r0, adr_cIndx
    ldr r0, [r0]
    ldr r1, adr_shflIndx        /* deal one card to player */
    mov r2, #0
    ldr r3, adr_plyrHnd
    bl dealOne

    ldr r0, adr_cIndx      /* increment index */
    ldr r1, [r0]
    add r1, r1, #1
    str r1, [r0]

    ldr r0, adr_cIndx
    ldr r0, [r0]
    ldr r1, adr_shflIndx        /* deal one card to dealer */
    mov r2, #0
    ldr r3, adr_dlrHnd
    bl dealOne

    ldr r0, adr_cIndx      /* increment index */
    ldr r1, [r0]
    add r1, r1, #1
    str r1, [r0]

    ldr r0, adr_cIndx
    ldr r0, [r0]
    ldr r1, adr_shflIndx        /* deal second card to player */
    mov r2, #0
    ldr r3, adr_plyrHnd
    bl dealOne

    ldr r0, adr_cIndx      /* increment index */
    ldr r1, [r0]
    add r1, r1, #1
    str r1, [r0]

    ldr r0, adr_cIndx
    ldr r0, [r0]
    ldr r1, adr_shflIndx        /* deal second card to dealer */
    mov r2, #0
    ldr r3, adr_dlrHnd
    bl dealOne

    ldr r0, adr_cIndx      /* increment index */
    ldr r1, [r0]
    add r1, r1, #1
    str r1, [r0]

    pop {r4, r5, r6, lr}
    bx lr

adr_newLine: .word newLine
adr_intOut: .word intOut
