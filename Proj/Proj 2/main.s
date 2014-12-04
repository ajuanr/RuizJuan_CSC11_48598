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
dealer: .skip 56

.balign 4
player: .skip 56

/* this array holds the value of the 52 cards in the deck */
.balign 4
cardVal: .skip 220

/* this array holds the index of the next card to be dealt */
.balign 4
shuflIndx: .skip 220

.text global
