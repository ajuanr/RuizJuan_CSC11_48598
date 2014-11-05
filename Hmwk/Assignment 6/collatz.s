.global collatz
collatz:
    /* r0 contains the first argument */
    push {r4}
    sub sp, sp, #4 /* Make sure the stack is 8 byte aligned */ 
    mov r4, r0
    mov r3, #4194304
    collatz_repeat: 
        mov r1, r4
        mov r0, #0
        collatz_loop:
        cmp r1, #1
        beq collatz_end 
        and r2, r1, #1
        cmp r2, #0
        bne collatz_odd

  collatz_even:
       mov r1, r1, ASR #1
       b collatz_end_loop
  collatz_odd:
       add r1, r1, r1, LSL #1
       add r1, r1, #1
   collatz_end_loop:
       add r0, r0, #1
       b collatz_loop
  collatz_end:
    sub r3, r3, #1
    cmp r3, #0
    bne collatz_repeat
  add sp, sp, #4 /* Make sure the stack is 8 byte aligned */ 
  pop {r4}
  bx lr

.global collatz2
collatz2:
    /* r0 contains the first argument */
    push {r4}
    sub sp, sp, #4 /* Make sure the stack is 8 byte aligned */ 
    mov r4, r0
    mov r3, #4194304
    collatz2repeat:
        mov r1, r4
        mov r0, #0
   collatz2_loop:
       cmp r1, #1
       beq collatz2_end
       and r2, r1, #1
       cmp r2, #0
       moveq r1, r1, ASR #1
       addne r1, r1, r1, LSL #1
       addne r1, r1, #1    /* if r2 != 0, r1 <- r1 + 1 */
  collatz2_end_loop:
       add r0, r0, #1
       b collatz2_loop
  collatz2_end:
       sub r3, r3, #1
       cmp r3, #0
       bne collatz2repeat
       add sp, sp, #4
pop {r4}
bx lr

