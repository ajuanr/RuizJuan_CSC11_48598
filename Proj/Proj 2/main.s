/* This is project 2 *
 * The program runs blackjack 
 * Ruiz, Juan - Project 2 - 48598
 *
 *     To Compile
 *          gcc -c arrayFuncs.s
 *          gcc -c divMod.s
 *          gcc -c random.o
 *          gcc -c main.o
 *          gcc arrayFuncs.o divMod.o  random.o main.o -o proj 
 */

.data 
/* arrays holding the hand of the player and dealer 
 * max number of cards with one deck is 11: A A A A 2 2 2 2 3 3 3 = 21
 * array padded with room for three more cards/
*/
.balign 4
mess: .asciz "Value is: %d\n"


.balign 4
dlrHnd: .skip 56

.balign 4
plyrHnd: .skip 56

.balign 4
spltHnd: .skip 56

/* this array holds the value of the 52 cards in the deck */
/* card =  2, 3, 4, 5, 6, 7, 8, 9, 10, J,  Q,  K,  A */
.balign 4
cardVal: 
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11

/* This array will hold the index of which card to shuffle next */
shflIndx: .skip 56

/* this array holds the index of the next card to be dealt */
.balign 4
shuflIndx: .skip 220

/* the index of the next card to be dealt */
.balign 4
cIndx: .word 0

/* Total number of cards in the deck. Constant */
nCard: .word 52

.balign 4
newLine: .asciz "\n" 

.text 
.global main
main:
    push {lr}
    sub sp,sp, #4

    /* seed random number generator */
    mov r0, #0
    bl time
    bl srand

    ldr r0, adr_nCard       /* print  out all cardValues */
    ldr r0, [r0]
    ldr r1, adr_cardVal
    bl printArray

    ldr r0, adr_nCard       /* initialize index with 0-51 */
    ldr r0, [r0]
    ldr r1, adr_shflIndx
    bl fillArray

    ldr r0, adr_nCard       /* print initialized index */
    ldr r0, [r0]
    ldr r1, adr_shflIndx
    bl printArray

    ldr r0, adr_nCard        /* shuffle the index */
    ldr r0, [r0]
    ldr r1, adr_shflIndx
    bl shuffle

    ldr r0, adr_nCard       /* print initialized index */
    ldr r0, [r0]
    ldr r1, adr_shflIndx
    bl printArray

    ldr r0, adr_cIndx
    ldr r4, [r0]            /* save card index */


    mov r5, #0                    /* r5 holds number of cards that have been dealt */                   
    mov r6, #0                    /* r6 holds number of cards player has been dealt */
    mov r7, #0                    /* r7 holds number of cards dealer has been dealt */

    dealPlyr:
       mov r0, r5
       ldr r1, adr_shflIndx
       ldr r2, adr_plyrHnd
       mov r3, r6
       bl deal
       add r5, r5, #1    
       add r6, r6, #1              /* increment cards dealt to player */
       cmp r6, #2
       bne dealPlyr

    mov r0, r6
    ldr r1, adr_plyrHnd
    bl printArray


    dealDlr:
       ldr r1, adr_shflIndx
       ldr r2, adr_dlrHnd
       mov r3, r7
       bl deal
       add r5, r5, #1    
       add r7, r7, #1              /* increment cards dealt to player */
       cmp r7, #2
       bne dealDlr

    mov r0, r7
    ldr r1, adr_dlrHnd
    bl printArray


    

        /* Exit stage right */
    add sp, sp, #4
    pop {lr}
    bx lr

adr_cardVal: .word cardVal
adr_shflIndx: .word shflIndx
adr_nCard: .word nCard
adr_newLine: .word newLine
adr_plyrHnd: .word plyrHnd
adr_dlrHnd: .word dlrHnd
adr_cIndx: .word cIndx
