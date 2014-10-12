/* -- printf02.s */
.data
 
/* First message */
.balign 4
message1: .asciz "Hey, type in two numbers: "
 
/* Division result message */
.balign 4
message2: .asciz "%d \\ %d = %d\n"

/* Mod result message */
.balign 4
message3: .asciz "%d %% %d = %d\n"

/* Format pattern for scanf */
.balign 4
scan_pattern : .asciz "%d %d"
 
/* Where scanf will store the number read */
.balign 4
number_read: .word 0

.balign 4
denom_read: .word 0
 
.balign 4
return: .word 0
 
.balign 4
return2: .word 0

.balign 4
return3: .word 0

/* Prompt to quit */
.balign 4
prompt: .asciz "-1 to quit: "

/* User input to repeat division */
.balign 4
ans_format: .asciz "%d"

.balign 4
ans: .word 0
 
.text
 
/*
divide function
*/
divide:
    @ declare variables in intitialize r2/r3 => r0  r2%r3 =>r1
    ldr r2, address_of_number_read
    ldr r2, [r2]
    ldr r3, address_of_denom_read
    ldr r3, [r3]
    mov r4, #1
    mov r5, r3
    mov r0, #0
    mov r1, r2

    @ divmod
    cmp r1, r3   @ compare and exit if a < b
    blt _exit
    
    @scale left
    _scaleL:
    mov r4, r4, lsl#1
    mov r5, r5, lsl#1
    cmp r1, r5
    bge _scaleL
    mov r4, r4, lsr#1
    mov r5, r5, lsr#1
    
    @add sub
    _addSub:
    add r0, r0, r4
    sub r1, r1, r5
    bal _ScaleR

    _asTest:
    cmp r4, #1  @ test whether addSub loop should continue
    bge _addSub 
    bal _exit

    @scale right
    _ScaleR:
    mov r4, r4, lsr#1
    mov r5, r5, lsr#1
    cmp r1, r5
    blt _ScaleR
    bge _asTest

    _exit:
    bx lr

address_of_return2 : .word return2

/* Perform division, asks user whether or not to repeat */ 
divRead:
    ldr r1, address_of_return        /* r1 <- &address_of_return */
    str lr, [r1]                     /* *r1 <- lr */
 
    ldr r0, address_of_message1      /* r0 <- &message1 */
    bl printf                        /* call to printf */
 
    ldr r0, address_of_scan_pattern  /* r0 <- &scan_pattern */
    ldr r1, address_of_number_read   /* r1 <- &number_read */
    ldr r2, address_of_denom_read
    bl scanf                         /* call to scanf */
 
    ldr r0, address_of_number_read   /* r0 <- &number_read */
    ldr r0, [r0]                     /* r0 <- *r0 */
    ldr r2, address_of_denom_read
    ldr r2, [r2]
    bl divide
 
    mov r8, r0                       /* holds a/b */
    mov r9, r1                       /* holds a%b */

    /* Print a/b */
    ldr r2, address_of_denom_read
    ldr r2, [r2]
    mov r3, r8 
    ldr r1, address_of_number_read   /* r1 <- &number_read */
    ldr r1, [r1]                     /* r1 <- *r1 */
    ldr r0, address_of_message2      /* r0 <- &message2 */
    bl printf                        /* call to printf */
 
    /* Print a%b */
    ldr r1, address_of_number_read
    ldr r1, [r1]
    ldr r2, address_of_denom_read
    ldr r2, [r2]
    mov r3, r9
    ldr r0, address_of_message3
    bl printf

    ldr lr, address_of_return        /* lr <- &address_of_return */
    ldr lr, [lr]                     /* lr <- *lr */
    bx lr                            /* return from main using lr */
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_scan_pattern : .word scan_pattern
address_of_number_read : .word number_read
address_of_return : .word return
address_of_denom_read : .word denom_read
address_of_message3: .word message3

.global main
main:
    _doWhile:
    bl divRead

    ldr r0, address_of_prompt
    bl printf

    ldr r0, address_of_ans_format
    ldr r1, address_of_ans
    bl scanf
    
    ldr r0, address_of_ans
    ldr r0, [r0]

    cmp r0, #-1
    bgt _doWhile

    mov r7, #1
    swi 0

address_of_return3 : .word return3
address_of_prompt : .word prompt
address_of_ans : .word ans
address_of_ans_format : .word ans_format

 
/* External */
.global printf
.global scanf
