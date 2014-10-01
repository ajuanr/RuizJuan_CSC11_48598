    .global main

main:
    mov r0, #4
    
    @ switch case(r0)
    cmp r0, #1
    beq _isOne
    cmp r0, #2
    beq _isTwo
    cmp r0, #3
    beq _isThree
    bal _default

_isOne:
    @ do something then exit

    bal _exit

_isTwo:
    @ do something then exit
    bal _exit

_isThree:
    @ do something then exit
    bal _exit

_default:
    @ do something then exit
    bal _exit

_exit:
    mov r7, #0
    swi 0
