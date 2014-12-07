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
/************************************
 ****** Output messages go here *****
 ***********************************/
.balign 4
mess: .asciz "Value is: %d\n"

.balign 4
shwPlyr: .asciz "You have:   "

.balign 4
shwDlr: .asciz "Dealer has: "

.balign 4
bjMess: .asciz "Blackjack!\n"

.balign 4
hitStand: .asciz "Do you want to hit(h) or stand(s): "

.balign 4
plyrBst: .asciz "You have busted\n"

.balign 4
dlrBst: .asciz "Dealer has busted\n"

.balign 4
plyrWins: .asciz "Player wins\n"

.balign 4
dlrWins:  .asciz "Dealer Wins\n"

.balign 4
push: .asciz "Push\n"

.balign 4
betMsg: .asciz "How much would you like to bet: "

.balign 4
prntBal: .asciz "Your balance is  $%f\n"

.balign 4
playMsg: .asciz "Do you want to play again(y)? "

.balign 4
brkMsg: .asciz "You are broke.\n"

/************************************
 ****** Input formats  go here ******
 ***********************************/
hsFormat: .asciz " %c"

betForm: .asciz "%f"

/***********************************
 ******** Data goes here ***********
 **********************************/
.balign 4
plyrScr: .word 0

.balign 4
dlrScr: .word 0

.balign 4
hsChoice: .word 0

.balign 4
playAns: .word 0

.balign 4
balance: .float 10.00

.balign 4
betAmnt: .float 0

/* blackjack win payout 3:2 */
.balign 4
bjPay: .float 1.5

/* arrays holding the hand of the player and dealer 
 * max number of cards with one deck is 11: A A A A 2 2 2 2 3 3 3 = 21
 * array padded with room for three more cards/
*/
.balign 4
dlrHnd: .skip 56

.balign 4
plyrHnd: .skip 56

.balign 4
spltHnd: .skip 56

/* this array holds the value of the 52 cards in the deck 
 * card =  2, 3, 4, 5, 6, 7, 8, 9, 10, J,  Q,  K,  A */
.balign 4
cardVal: 
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
     .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11

/* This array will hold the index of which card to draw next */
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

    ldr r0, adr_nCard       /* initialize index with 0-51 */
    ldr r0, [r0]
    ldr r1, adr_shflIndx
    bl fillArray

    ldr r0, adr_nCard        /* shuffle the index */
    ldr r0, [r0]
    ldr r1, adr_shflIndx
    bl shuffle

    mov r5, #0                    /* r5 holds number of cards that have been dealt */                   

    /* Start the game here */
    play:

    ldr r0, adr_newLine
    bl printf

    ldr r0, adr_balance
    vldr s10, [r0]
    vcvt.f64.f32 d0, s10
    vmov r2, r3, d0
    ldr r0, adr_prntBal
    bl printf

    ldr r0, adr_betMsg
    bl printf

    ldr r0, adr_betForm
    ldr r1, adr_betAmnt
    bl scanf

    ldr r0, adr_balance
    vldr s10, [r0]
    ldr r0, adr_betAmnt
    vldr s11, [r0]
   
    vcmp.f32 s10, s11
    blt play 

    ldr r0, adr_newLine
    bl printf

    mov r6, #0                    /* r6 holds number of cards player has been dealt */
    mov r7, #0                    /* r7 holds number of cards dealer has been dealt */

    dealPlyr:
       mov r0, r5
       ldr r1, adr_shflIndx
       ldr r2, adr_plyrHnd
       mov r3, r6
       bl deal
       add r5, r5, #1    
       add r6, r6, #1              /* increment num  cards dealt to player */
       cmp r6, #2
       bne dealPlyr

    dealDlr:
       ldr r1, adr_shflIndx
       ldr r2, adr_dlrHnd
       mov r3, r7
       bl deal
       add r5, r5, #1    
       add r7, r7, #1              /* increment num cards dealt to dealer */
       cmp r7, #2
       bne dealDlr

    ldr r0, adr_shwDlr
    bl printf

    mov r0, #1                     /* don't show dealer hole card */
    ldr r1, adr_dlrHnd
    bl printArray


    ldr r0, adr_shwPlyr            /* show player what they've got */
    bl printf
    mov r0, r6
    ldr r1, adr_plyrHnd
    bl printArray


    /* Check if player has blackjack  only after intial cards are dealt */
    mov r0, r6                /* sum the total */
    ldr r1, adr_plyrHnd
    mov r2, #21
    bl sumArray               /* returns sum in r0 */

    cmp r0, #21 
    beq bjWin

    plyrCont:
        ldr r0, adr_newLine
        bl printf

        ldr r0, adr_hitStand
        bl printf
        ldr r0, adr_hsFormat
        ldr r1, adr_hsChoice
        bl scanf

        ldr r1, adr_hsChoice           /* get user choice read by scanf */
        ldr r1, [r1]

        cmp r1, #'h' 
        beq choiceH 
        b choiceS                     /* anything other than 'h' is stand */
        

    choiceH:                          /* player choose to get another card */
       ldr r0, adr_newLine            /* new line */
       bl printf
       mov r0, r5
       ldr r1, adr_shflIndx
       ldr r2, adr_plyrHnd
       mov r3, r6
       bl deal
       add r5, r5, #1
       add r6, r6, #1

       ldr r0, adr_shwPlyr            /* show player what they've got */
       bl printf
       mov r0, r6
       ldr r1, adr_plyrHnd
       bl printArray

       /* after card has been dealt check if player has busted */
       mov r0, r6                /* sum the total */
       ldr r1, adr_plyrHnd
       mov r2, #21
       bl sumArray               /* returns sum in r0 */

       cmp r0, #21 
       bgt plyrBstd

       ldr r1, adr_plyrScr      /* if player has not busted save the score */
       str r0, [r1]  

       beq choiceS              /* don't allow hit when player has 21 */

       b plyrCont

    choiceS:                        /* player stands. Dealer turn */
       ldr r0, adr_newLine
       bl printf
       dealNext:
           mov r0, r5
           ldr r1, adr_shflIndx
           ldr r2, adr_dlrHnd
           mov r3, r7
           bl deal
           add r5, r5, #1
           add r7, r7, #1

           ldr r0, adr_shwDlr            /* show player what dealer has */
           bl printf
           mov r0, r7
           ldr r1, adr_dlrHnd
           bl printArray

           /* after card has been dealt check if dealer has busted */
            mov r0, r7                /* sum the total */
           ldr r1, adr_dlrHnd
           mov r2, #17               /* dealer hits on soft 17 */
           bl sumArray               /* returns sum in r0 */

           cmp r0, #21              /* dealer has busted */ 

           cmp r0, #17              /* dealer no longer hits */
           bge checkWinner 
           b dealNext

/* don't seperate from dealNext */
    checkWinner:
       ldr r1, adr_plyrScr
       ldr r1, [r1]
       cmp r1, r0                   /* dealer hand in r0, player hand in r1 */
       beq pushWon
       bgt plyrWon
       blt dlrWon

       pushWon:
           ldr r0, adr_newLine
           bl printf
           ldr r0, =push
           bl printf
           b playAgain
       plyrWon:
           ldr r0, adr_newLine
           bl printf
           ldr r0, =plyrWins
           bl printf

           /* add bet to player balance */
           ldr r0, adr_balance
           vldr s10, [r0]
           ldr r1, adr_betAmnt
           vldr s11, [r1]
           vadd.f32 s10, s10, s11
           vstr s10, [r0]                   /* save the new balance */
           vcvt.f64.f32 d0, s10             /* print the  new balance */
           vmov r2, r3, d0
           ldr r0, adr_prntBal 
           bl printf

           b playAgain

       dlrWon:
           ldr r0, adr_newLine
           bl printf
           ldr r0, =dlrWins
           bl printf

           /* subtract bet amount from player */
           ldr r0, adr_balance
           vldr s10, [r0]
           ldr r1, adr_betAmnt
           vldr s11, [r1]
           vsub.f32 s10, s10, s11
           vstr s10, [r0]                   /* save the new balance */
           vcvt.f64.f32 d0, s10
           vmov r2, r3, d0
           ldr r0, adr_prntBal 
           bl printf

           b playAgain

    plyrBstd:
        ldr r0, adr_newLine
        bl printf
        ldr r0, adr_plyrBst
        bl printf

        /* subtract bet amount from player */
        ldr r0, adr_balance
        vldr s10, [r0]
        ldr r1, adr_betAmnt
        vldr s11, [r1]
        vsub.f32 s10, s10, s11
        vstr s10, [r0]                   /* save the new balance */
        vcvt.f64.f32 d0, s10
        vmov r2, r3, d0
        ldr r0, adr_prntBal 
        bl printf

        b playAgain

    dlrBstd:
        /* add bet amount from player */
        ldr r0, adr_dlrBst
        bl printf

        /* add bet to player balance */
        ldr r0, adr_balance
        vldr s10, [r0]
        ldr r1, adr_betAmnt
        vldr s11, [r1]
        vadd.f32 s10, s10, s11
        vstr s10, [r0]                   /* save the new balance */

        vcvt.f64.f32 d0, s10
        vmov r2, r3, d0
        ldr r0, adr_prntBal 
        bl printf

        b playAgain

    bjWin:
        ldr r0, adr_bjMess
        bl printf

        /* add bet to player balance */
        ldr r0, adr_balance
        vldr s10, [r0]
        ldr r1, adr_betAmnt
        vldr s11, [r1]

        ldr r0, adr_bjPay
        vldr s12, [r0]
     
        vmul.f32 s11, s12, s11        /* increase original bet amount to 3:2 */

        vadd.f32 s10, s10, s11

        ldr r0, adr_balance
        vstr s10, [r0]
        vcvt.f64.f32 d0, s10
        vmov r2, r3, d0
        ldr r0, adr_prntBal 
        bl printf
        
        b playAgain

    playAgain:
        /* check if player is broke */
        ldr r0, adr_balance
        vldr s10, [r0]
        vcvt.s32.f32 s10, s10
        vmov r2, s10
        mov r1, #0
        cmp r2, r1
        ble broke

        ldr r0, adr_newLine
        bl printf

        ldr r0, adr_playMsg
        bl printf

        ldr r0, adr_hsFormat                     /* re-use hsFormat to read in char */
        ldr r1, adr_playAns 
        bl scanf
        
        ldr r0, adr_playAns
        ldr r0, [r0]
        cmp r0, #'y'
        beq play        

    broke:                                        /* player has no money remaining */
        ldr r0, adr_brkMsg
        bl printf
        
        /* Exit stage right */
    exit:
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
adr_shwDlr: .word shwDlr
adr_shwPlyr: .word shwPlyr
adr_bjMess: .word bjMess
adr_hitStand: .word hitStand
adr_hsFormat: .word hsFormat
adr_hsChoice: .word hsChoice
adr_dlrBst: .word dlrBst
adr_plyrBst: .word plyrBst
adr_plyrScr: .word plyrScr
adr_betMsg: .word betMsg
adr_betForm: .word betForm
adr_betAmnt: .word betAmnt
adr_prntBal: .word prntBal
adr_balance: .word balance
adr_bjPay: .word bjPay
adr_playMsg: .word playMsg
adr_playAns: .word playAns
adr_brkMsg: .word brkMsg
