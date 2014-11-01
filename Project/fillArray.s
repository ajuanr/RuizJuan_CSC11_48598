.data
/* Array holding elements to guess */
.balign 4
a: .skip 12

/* To check values in array */
.balign 4
numRead: .asciz "%d, "

/* Message to user */
.balign 4
message: .asciz "array contains 3 elements\n"

.text
   /* print the array elements */
   print:
      push {lr}
      mov r2, #0
      printLoop:
         cmp r2, #3
         beq end
         ldr r0, address_of_numRead
         mov r1, r2
         bl printf
         add r2, r2, #1
@         bal printLoop
    /* exit print function */
    end:
    pop {lr}
    bx lr

    .global main
main:
   /* Save the link registers */
   push {lr}

   /* Prompt for user */
   ldr r0, address_of_message
   bl printf

   /* Save the array */
   ldr r1, address_of_a       /* r1 <- master */

   /* fill the array */
   mov r2, #0
   fillLoop:
       cmp r2, #3            /* have we reached 3 yet */
       beq exit              /* r2 == 3 */
       str r2, [r1, r2, lsl #2]     /* (*r1  ← r2) + #4 */
       add r2, r2, #1
       bal fillLoop


   exit:
   bl print
       pop {lr} 
       bx lr

address_of_a: .word a
address_of_message: .word message
address_of_numRead: .word numRead

.global printf
