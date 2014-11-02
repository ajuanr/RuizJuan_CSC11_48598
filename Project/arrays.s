.data
/* Array holding elements to guess */
.balign 4
a: .skip 12

/* Array holding the numbers entered by user */
.balign 4
usrAray: .skip 12

/* Prompt */
prompt: .asciz "Enter a number between 0-7\n"

/* scan format */
format: .asciz "%d"

/* To check values in array */
numRead: .asciz "%d\n"

/* Read in a number */

/* Message to user */
message: .asciz "This step is working\n"

.text
/* Generate a random number */
random:
    push {lr}                 /* Push lr onto the top of the stack */
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
    mov r4, #0                       /* r4 holds the index */
    fillLoop:
        cmp r4, #3                   /* have we reached 3 yet */
        beq exit_fill
        bl random
        ldr r2, address_of_a         /* r0 <- master */
        str r1, [r2, r4, lsl #2]     /* (*r1  ← r2) + #4 */
        add r4, r4, #1
        bal fillLoop
   
    /* Exit the function */    
    exit_fill:
      pop {r4, lr}
      bx lr

/* Get player guess */
read:
    push {r4,lr}
    ldr r2, address_of_usrAray
    mov r4, #0   
    readLoop:
        cmp r4, #3
        beq exit_read
        ldr r0, address_of_prompt
        bl printf
        ldr r0, address_of_format
        push {r1}
        bl scanf
        ldr r1, [sp]                /* r1 holds number read */
        str r1, [r2, r4, lsl #2]
        pop {r1}
        add r4, r4, #1 
    exit_read:
        pop {r4, lr}
        bx lr

/* end read */

/* print the array elements */
print:
  push {lr}
  ldr r1, address_of_a
  mov r2, #0
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
    /* for random number */
    mov r0,#0                    /* Set time(0) */
    bl time                      /* Call time */
    bl srand                     /* Call srand */

    bl fill
    bl read
@    bl print
   
    ldr r0, address_of_numRead
    ldr r1, address_of_a
    ldr r1, [r1, +#0]
    bl printf

    ldr r0, address_of_numRead
    ldr r1, address_of_a
    ldr r1, [r1, +#4]
    bl printf
    ldr r0, address_of_numRead
    ldr r1, address_of_a
    ldr r1, [r1, +#8]
    bl printf

    pop {lr} 
    bx lr

address_of_a: .word a
address_of_usrAray: .word usrAray
address_of_message: .word message
address_of_numRead: .word numRead
address_of_prompt: .word prompt
address_of_format: .word format

/* External functions */
.global printf
.global scanf
.global time
.global srand
.global rand
