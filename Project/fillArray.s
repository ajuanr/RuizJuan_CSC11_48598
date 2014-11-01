.data
/* Array holding elements to guess */
.balign 4
master: .skip 12

/* To check values in array */
.balign 4
numRead: .asciz "%d, "

/* Message to user */
.balign 4
message: .asciz "This array contains 3 elements\n"

.text
    .global main
main:
   /* Save the link registers */
   push {lr}

   /* Prompt for user */
   ldr r0, address_of_message
   bl printf

   /* Save the array */
   @ldr r1, address_of_master

   /* fill the array */
   mov r2, #0
   fillLoop:
       cmp r2, #3
       beq print
       add r2, #1
       @str r2, [r1, +r2, LSL #2]  /* *(r1 + r2*4) ← r2 */
       bal fillLoop

   /* print the elements */
   print:
       mov r2, #0
       printLoop: 
           cmp r2, #3
           beq exit
           ldr r0, address_of_num
           mov r1, r2 
           bl printf
           add r2, #1
           @bal printLoop
   exit:
   pop {lr} 
   bx lr

address_of_master: .word master
address_of_message: .word message
address_of_num: .word numRead

.global printf
