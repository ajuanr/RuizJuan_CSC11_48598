@ Juan Ruiz
@ The more efficient implemenation of the
@ original divmod function

    @ declare variables
     .global main
main:
    mov r2, #111  @ var a
    mov r3, #5    @ var b
    mov r4, #1    @ flag: 0=a/b  or  1=a%b
    mov r6, #0    @ s -> r6 has the present scale 10^
    mov r7, #0    @ sf -> r7 scale factor = r3*r6 to subtract
    mov r8, #10    @ factor -> r8 shift factor 10
    mov r9, #0
    mov r0, #0    @ holds a/b if flag not set
    mov r1, r2   @ holds a%b if flag not set

_divmod:
    cmp r3, r1       @ check is denom < numer
    blt _scale       @ start subtraction
    cmp r4, #1 
    beq _swap

@ outer do while of divmod function
_doOuter:
    bge _scale
    
_doOuterTst:
    mov r10, #1       @ use register 10 for next comparison
    cmp r10, r6       @ in order to be able to use blt instead of bge
    bge _doOuter
    cmp r4, #0        @ check the flag 
    beq _exit         @ flag not set 
    bal _swap         @ flag is set
    
_doInner:
    add r0, r0, r6     @ increase by scale
    sub r1, r1, r7     @ subtract by b*scale
    cmp r1, r7      
    bge _doInner       @ test at end to get do/while functionality
    blt _doOuterTst
    cmp r6, #1
    beq _swap
    @ swap was not required
    bal _exit

_scale:
    mov r6, #1
    mul r7, r3, r6
    mul r9, r7, r8

_scaleLoop:
    cmp r9, r1         @ check if we should continue this function loop
    bge _doInner       @ if not, exit scaling
    mul r10, r6, r8    @ scale factor, r10 is temp to keep compiler happy
    mov r6, r10      
    mul r7, r3, r6     @ subtraction factor
    mul r9, r7, r8     @ next subtraction factor to test
    bge _scaleLoop

_swap:
    mov r5, r0    @ r5 is temp
    mov r0, r1
    mov r1, r5

_exit:
    mov r7, #1
    swi 0
