/* This is project 2 *
 * The program runs blackjack 
 * Ruiz, Juan - Project 2 - 48598
*/

.data 
/* arrays holding the hand of the player and dealer 
 * max number of cards with one deck is 11: A A A A 2 2 2 2 3 3 3 = 21
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

    ldr r0, adr_nCard
    ldr r0, [r0]
    ldr r1, adr_cardVal
    bl printArray

    ldr r0, adr_nCard
    ldr r0, [r0]
    ldr r1, adr_shflIndx
    bl fillArray

    ldr r0, adr_nCard
    ldr r0, [r0]
    ldr r1, adr_shflIndx
    bl printArray

    ldr r0, adr_nCard
    ldr r0, [r0]
    ldr r1, adr_shflIndx
    bl shuffle

    ldr r0, adr_nCard
    ldr r0, [r0]
    ldr r1, adr_shflIndx
    bl printArray


        /* Exit stage right */
    add sp, sp, #4
    pop {lr}
    bx lr

adr_cardVal: .word cardVal
adr_shflIndx: .word shflIndx
adr_nCard: .word nCard
adr_newLine: .word newLine

