/* 
 *    To compile:
 *        gcc -c divmod.s
 *        gcc -c arrays.s
 *        gcc -c main.s
 *        gcc divMod.o arrays.o main.o -o proj1     
 */
.data
/* 3-digit array holding the numbers user must guess */
.balign 4
master: .skip 12

/* Instructions to user */
.balign 4
instruct: .asciz "Enter three digits in the correct order to win\n"

/* Prompts user to enter a number */
.balign 4
prompt: .asciz "Enter a number: "

/* Scan format */
.balign 4
scan: .asciz "%d"

/* Tell users what numbers they entered */
.balign 4
numsRead: .asciz "You entered %d, %d, and %d\n"


/*********************************
 ***********   Main   ************
 *********************************/
.text
    .global main

main:
    push {lr}
    sub sp, #4      /* 8-byte align sp */
    ldr r0, address_of_instruct
    bl printf

    /* for random number */
    mov r0,#0                    /* Set time(0) */
    bl time                      /* Call time */
    bl srand                     /* Call srand */

    bl fill
    bl game

    add sp, sp, #4    /* remove padding */ 
    pop {lr}
    bx lr


address_of_instruct: .word instruct   
address_of_numsRead: .word numsRead


.global printf
