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
   sub sp, #4

   /* Prompt for user */
   ldr r0, address_of_message
   bl printf

   /* Save the array */
   ldr r2, address_of_master

   /* fill the array */
   mov r3, #0
   fillLoop:
       cmp r3, #3
       beq exit
       str r3, [r2], +#4       /* r1+r2*4 <- r2 */
       add r3, #1
       bal fillLoop

   /* print the elements */
   ldr r0, address_of_num
   mov r3, #0
   printLoop: 
       cmp r3, #3
       beq exit
       ldr r1, [r2], +#4
       ldr r1, [r1]
       bl printf
       add r3, #1
       bal printLoop

   exit:
   add sp, #4
   pop {lr} 



address_of_master: .word master
address_of_message: .word message
address_of_num: .word numRead
