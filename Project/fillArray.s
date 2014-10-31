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
   push {lr}
   sub sp, #4

   ldr r0, address_of_message
   bl printf

   ldr r1, address_of_master
   

   /* fill the array */
   mov r2, #0
   fillLoop:
       cmp r2, #3
       beq exit
       str r2, [r1], +#4       /* r1+r2*4 <- r2 */
       add r2, #1
       bal fillLoop

   /* print the elements */
   ldr r0, address_of_num
   @sub r1, r2, lsl #2
   mov r2, #0
   printLoop: 
       cmp r2, #3
       beq exit
       mov r1, #7
       bl printf
       add r2, #1
       bal printLoop

   exit:
   add sp, #4
   pop {lr} 



address_of_master: .word master
address_of_message: .word message
address_of_num: .word numRead
