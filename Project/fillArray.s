.data
/* Array holding elements to guess */
.balign 4
a: .skip 12

/* To check values in array */
numRead: .asciz "%d, "

/* Message to user */
message: .asciz "array contains 3 elements\n"

.text

   /* fill the array */
   fill:
       push {lr}
       /* Save the array */
       ldr r1, address_of_a         /* r1 <- master */
       mov r2, #0
         ldr r0, address_of_message
   fillLoop:
       cmp r2, #3                   /* have we reached 3 yet */
       beq exit_fill
       add r2, r2, #1
       str r2, [r1, r2, lsl #2]     /* (*r1  ← r2) + #4 */
         bl printf
       bal fillLoop
   
       /* Exit the function */    
       exit_fill:
         pop {lr}
         bx lr


   /* print the array elements */
   print:
     push {lr}
     mov r2, #0
     mov r1, r2
     printLoop:
         cmp r2, #3
         beq exit_print
         add r2, r2, #1
         bal printLoop
    /* exit print function */
    exit_print:
    pop {lr}
    bx lr

    .global main
main:
   /* Save the link registers */
   push {lr}


   bl fill
   @bl print

   pop {lr} 
   bx lr

address_of_a: .word a
address_of_message: .word message
address_of_numRead: .word numRead

.global printf
