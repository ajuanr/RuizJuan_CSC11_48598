     .global main

main:
    mov r0, #1
    mov r1, #0
    cmp r0,r1
    blt _lessThan
    bge _grtrThan
    @ continue without branching
    @ set r0 to 0 if if is false
    mov r0, #0
    bal _exit

_lessThan:
    @ do somthething then go somewhere else if necessary
    mov r0, #0
    bal _exit

_grtrThan:
    @ do somthething then go somewhere else if necessary
    mov r0, #3
    bal _exit
 
_exit:
    mov r7, #0
    swi 0   
