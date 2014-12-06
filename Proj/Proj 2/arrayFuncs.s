/* This file holds functions for manipulating arrays */
.data
.balign 4
intOut: .asciz "%d "

.balign 4
newLine: .asciz "\n"

/* this array holds the value of the 52 cards in the deck */
/* card =  2, 3, 4, 5, 6, 7, 8, 9, 10, J,  Q,  K,  A */
.balign 4
cardVal:
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11

.text
/* fill array function */
/* number of elements passed as r0 */
/* array is passed as r1 */
.global fillArray
fillArray:
     push {r4-r8, lr}
@    push {r4, r5, r6, r7, r8, lr}        /* r8 is unused */

    mov r4, r0                           /* r4 holds the numbmer of elements */
    mov r5, r1                           /* r5 holds the array */

    mov r7, #0                           /* start counting from zero */
    fillLoop:
       str r7, [r5, r7, lsl#2]
       add r7, r7, #1                    /* increment loop counter */
       cmp r7, r4
       bne fillLoop

    pop {r4-r8, lr}
@    pop {r4, r5, r6,r7, r8, lr}
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
    push {r4-r10, lr}
@    push {r4, r5, r6, r7, r8, r9, r10, lr}

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

    pop {r4-r10, lr}
    bx lr
/* exit shuffle function */

/* Function gets a card
 * index where next card is                  r0
 * get index from shuffled array passed in   r1
 * get card from card value array in         r2
 */
.global getCard
getCard:
    push {r4, r5, r6, lr}
    
    mov r4, r0
    mov r5, r1
    mov r6, r2
    ldr r4, [r5, r4, lsl#2]     /* grab card from */

    ldr r4, [r6, r4, lsl#2] 

    mov r0, r4

    pop {r4, r5, r6, lr}
    bx lr
/* exit getCard function */

/* Function deals the initial two cards to player and dealer
 * index of next card passed in        r0
 * array holding cards passed in       r1
 * array where cards are placed is in  r2
 * index where to place card           r3
 * 
*/
.global deal
deal:
    push {r4-r8, lr}     

    mov r4, r0                      /* index */
    mov r5, r1                      /* card array */
    mov r6, r2                      /* output array */
    mov r7, r3

    mov r0, r4
    mov r1, r5
    ldr r2, adr_cardVal
    bl getCard                  /* getCard returns a card in r0 */

    str r0, [r6, r7, lsl#2]

    pop {r4-r8,lr}
    bx lr
/* exit deal function */

/* Function adds the values of the cards in a hand
 * checks for aces and changes their value from 11 to 1
 * if they would cause player to bust
 * 
 * pass the number of elements in  r0
 * pass the array in               r1
 * return the sum in               r0
 */
.global sumArray
sumArray:
    push {r4-r8,  lr}

    mov r4, r0                /* save num elements */
    mov r5, r1                /* save the array */
    mov r6, #0                /* initialize the sum */
    mov r7, #0                /* initialize the num of aces */

    mov r8, #0                /* initialize loop counter */
    sumLoop:
        ldr r0, [r5, r8, lsl#2]
        add r6, r6, r0

        add r8,r8, #1
        cmp r8, r4
        bne sumLoop

    mov r0, r6                /* return the sum in r0 */

    pop {r4-r8,  lr}
    bx lr



adr_newLine: .word newLine
adr_intOut: .word intOut
adr_cardVal: .word cardVal
