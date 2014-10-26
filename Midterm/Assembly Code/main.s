.data

.balign 4
prompt: .asciz "enter a number: "

.balign 4
format: .asciz "%d"

.balign 4
output: .asciz "Your choice was %d\n"

.balign 4
num: .word 0

.text
    
.global main

main:
    push {lr}

    ldr r0, address_of_prompt
    bl printf

    ldr r0, address_of_format
    ldr r1, address_of_num
    bl scanf

    ldr r0, address_of_output
    ldr r1, address_of_num
    ldr r1, [r1]
    bl printf

    pop {lr}
    bx lr

address_of_prompt: .word prompt
address_of_format: .word format
address_of_output: .word output
address_of_num: .word num
