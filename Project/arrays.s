.data
/* Array holding elements to guess */
.balign 4
a: .skip 12

/* Array holding the numbers entered by user */
.balign 4
usrAray: .skip 12

/* Prompt */
prompt: .asciz "Enter three numbers between 0-7\n"

/* Result of guess */
result: .asciz "You got %d in the correct spot and %d in the wrong spot\n"

/* scan format */
.balign 4
format: .asciz "%d %d %d"

/* To check values in array */
numRead: .asciz "%d\n"

/* Read in a number */
.balign 4
num1: .word 0

.balign 4
num2: .word 0

.balign 4
num3: .word 0

.text
/* Generate a random number */
random:
    push {lr}                 /* Push lr onto the top of the stack */
    bl rand                      /* Call rand */

    mov r1, r0, asr #1             /* In case random return is negative */
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
    push {lr}
    ldr r0, address_of_prompt
    bl printf

    ldr r0, address_of_format
    ldr r1, address_of_num1
    ldr r2, address_of_num2
    ldr r3, address_of_num3
    bl scanf

    pop {lr}
    bx lr
/* end read */

/* print the array elements */
game:
     push {r4,lr}
     mov r4, #3     /* max possible right/wrong */
     guess:
        mov r0, #0     /* holds number correct */
        mov r1, #0     /* holds number incorrect */
        bl read                  /* get user guess */

        /* compare first value with guess */
        ldr r2, address_of_num1  
        ldr r2, [r2]
        ldr r3, address_of_a
        ldr r3, [r3, +#0]
        cmp r2, r3               /* does player guess match value in array */
        beq guess2               /* numbers matched don't add to wrong guess */
        add r1, r1, #1           /* numbers not equal*/

        guess2:
            ldr r2, address_of_num2
            ldr r2, [r2]
            ldr r3, address_of_a
            ldr r3, [r3, +#4]
            cmp r2, r3
            beq guess3
            add r1, r1, #1

        guess3:
            ldr r2, address_of_num3
            ldr r2, [r2]
            ldr r3, address_of_a
            ldr r3, [r3, +#8]
            cmp r2, r3
            beq done
            add r1, r1, #1

        done:                      /* Player has entered numbers */
            sub r0, r4, r1         /* r0 now holds number of correct guesses */ 
            cmp r0, #3             /* if r0==3 then all guesses were correct */ 
                                   /* Right/wrong in r0/r1, put in r1, r2 for printing */
            mov r2, r1
            mov r1, r0
            ldr r0, address_of_result
            bl printf       
            blt guess


  /* exit print function */
  exit_print:
       pop {r4, lr}
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
    bl game
   
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
address_of_numRead: .word numRead
address_of_prompt: .word prompt
address_of_format: .word format
address_of_num1: .word num1
address_of_num2: .word num2
address_of_num3: .word num3
address_of_result: .word result

/* External functions */
.global printf
.global scanf
.global time
.global srand
.global rand
