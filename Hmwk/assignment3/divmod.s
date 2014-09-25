@ Juan Ruiz
@ Assignment 3 - 48130
@ The more efficient implemenation of the
@ original divmod function

    @ declare variables
     .global main
main:
    mov r2, #111       @ var a
    mov r3, #9         @ var b
    mov r4, #1         @ flag: 0=a/b  or  1=a%b
    mov r6, #0         @ s -> r6 has the present scale 10^
    mov r7, #0         @ sf -> r7 scale factor = r3*r6 to subtract
    mov r8, #10        @ factor -> r8 shift factor 10
    mov r9, #0         @ shift -> r9 Shift test r7*r8
    mov r0, #0         @ holds a/b if flag not set
    mov r1, r2         @ holds a%b if flag not set

_divmod:
    cmp r1, r3         @ check is denom < numer
    bge _scale         @ start subtraction
    bal _finish        @ numer < demon. Nothing to be done

@ outer do while of divmod function
_doOuter:
    bge _scale
    
_doOuterTst:
    cmp r6, #1         @ Test if scaling should continue
    blt _doOuter

    @ if you've reached this point, all loops have finished
    @ prepare to exit
    bal _finish
    
_doInner:
    add r0, r0, r6     @ increase by scale
    sub r1, r1, r7     @ subtract by b*scale
    cmp r1, r7         @ test if doInner loop should repeat
    bge _doInner       @ test at end to get do/while functionality
    blt _doOuterTst
    cmp r6, #1         
    beq _swap
    @ swap was not required
    bal _exit

_scale:
    mov r6, #1         @ scale
    mul r7, r3, r6     @ subtraction factor
    mul r9, r7, r8     @ next subtraction factor test

@ keep shifting scale r6 by 10
_scaleLoop:
    cmp r1, r9         @ check if we should enter the scaleLloop
    bgt _doInner       @ if not, exit scaling
    mul r10, r6, r8    @ scale factor, r10 is temp to keep compiler happy
    mov r6, r10      
    mul r7, r3, r6     @ subtraction factor
    mul r9, r7, r8     @ next subtraction factor to test
    bal _scaleLoop     @ repeat this loop

@ Check if flag is set. Swap if flag is set, otherwise exit
_finish:
    cmp r4, #0         @ check is mod result flag is set
    beq _exit          @ flag was not set
    bal _swap          @ flag was set, swap values

_swap:
    mov r5, r0         @ r5 is temp
    mov r0, r1
    mov r1, r5

_exit:
    mov r7, #1
    swi 0
