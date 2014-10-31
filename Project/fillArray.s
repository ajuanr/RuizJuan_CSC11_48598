.data
/* Array holding elements to guess */
.balign 4
master: .skip 12

/* To check values in array */
.balign 4
num: .asciz "%d"

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
   
   mov r2, #0
   loop:
   cmp r2, #3
   beq exit
   
   str r2, [r1, +r2, lsl #1]
   add r2, #1
   bal loop

   exit:
   add sp, #4
   pop {lr} 



address_of_master: .word master
address_of_message: .word message
