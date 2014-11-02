.data
/* Array holding elements to guess */
.balign 4
a: .skip 12

/* To check values in array */
numRead: .asciz "%d\n"

/* Message to user */
message: .asciz "This step is working\n"

.text
/* Generate a random number */
random:
    push {lr}                 /* Push lr onto the top of the stack */

    mov r0,#0                    /* Set time(0) */
    bl time                      /* Call time */
    bl srand                     /* Call srand */
    bl rand                      /* Call rand */

    mov r1,r0,ASR #1             /* In case random return is negative */
    mov r2,#8                   /* Move 8 to r2 */
	                         /* We want rand()%8 */
    bl divMod                    /* Call divMod function to get remainder */

	
    pop {lr}                     /* Pop the top of the stack and put it in lr */
    bx lr                        /* Leave main */
/* Exit random number generator */

/* fill the array */
fill:
    push {r4,lr}
    /* Save the array */
    mov r4, #0
    fillLoop:
        cmp r4, #3                   /* have we reached 3 yet */
        beq exit_fill
        bl random
        ldr r2, address_of_a         /* r0 <- master */
        
        str r1, [r2, r3, lsl #2]     /* (*r1  ← r2) + #4 */
        add r4, r4, #1
        bal fillLoop
   
    /* Exit the function */    
    exit_fill:
      pop {r4, lr}
      bx lr


/* print the array elements */
print:
  push {lr}
  ldr r1, address_of_a
  mov r2, #0
  printLoop:
     cmp r3, #3
     beq exit_print
     ldr r1, [r1, r2, lsl #2]
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

    /* for random number */

    bl fill
    bl print
   
    ldr r0, address_of_numRead
    ldr r1, address_of_a
    ldr r1, [r1, +#0]
    bl printf

    pop {lr} 
    bx lr

address_of_a: .word a
address_of_message: .word message
address_of_numRead: .word numRead

/* External functions */
.global printf
.global time
.global srand
.global rand
