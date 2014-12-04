/* This is project 2 *
 * The program runs blackjack 
 * Ruiz, Juan - Project 2 - 48598
*/

.data 
/* arrays holding the hand of the player and dealer 
 * max number of card with one deck is 11: A A A A 2 2 2 2 3 3 3 = 21
 * array padded with room for three more cards/
*/

.balign 4
testMess: .asciz "Divmod return is: %d\n"

.balign 4
dealer: .skip 56

.balign 4
player: .skip 56

/* this array holds the value of the 52 cards in the deck */
/*card =   2, 3, 4, 5, 6, 7, 8, 9, 10, J,  Q,  K,  A */
.balign 4
cardVal: 
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11

/* This array will hold the index of wchich card to shuffle next */
shflIndx: .skip 56

/* this array holds the index of the next card to be dealt */
.balign 4
shuflIndx: .skip 220

/* Total number of cards in the deck. Constant */
ttlCrd: .word 52

/* Messages */
.balign 4
val: .asciz "%d "

.balign 4
newLine: .asciz "\n" 

.text 
/* fill array function */
/* number of elements passed as r0
/* array is passed as r1 */
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
 * r1 = the array
 */
printArray:
    push {r4, r5, r6, lr}

    mov r4, r0                             /* r4 holds the number of elements */
    mov r5, r1                             /* r5 holds the array */

    mov r6, #0                             /* r6 holds the loop counter */
    printLoop:
        ldr r1, [r5, r6, lsl#2]            /* get the element */
        ldr r0, =val
        bl printf

        add r6, r6, #1      /* increment and check if looping is complete */
        cmp r4, r6
        bne printLoop        

        /* print a new line */
        ldr r0, =newLine
        bl printf

    pop {r4, r5, r6, lr}
    bx lr

.global main
main:
    push {lr}
    sub sp, sp, #4      /* keep stack 8-byte aligned */

    mov r0, #10
    ldr r1, adr_ttlCard
    ldr r1, [r1]
    bl random
    mov r1, r0
    ldr r0, =testMess
    bl printf

    ldr r0, adr_ttlCard
    ldr r0, [r0]
    ldr r1, adr_cardVal
    bl printArray

    ldr r0, adr_ttlCard
    ldr r0, [r0]
    ldr r1, adr_shflIndx
    bl fillArray

    ldr r0, adr_ttlCard
    ldr r0, [r0]
    ldr r1, adr_shflIndx
    bl printArray


        /* Exit stage right */
    add sp, sp, #4
    pop {lr}
    bx lr

adr_cardVal: .word cardVal
adr_shflIndx: .word shflIndx
adr_ttlCard: .word ttlCrd

