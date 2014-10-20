/* Return a/b and a%b */

.data

message1: .asciz "Enter two numbers: "
format: .asciz "%d %d"
message2: .asciz "%d / %d = %d"
message3: .asciz "%d %% %d = %d"

.text

.global main
main:
    push {lr}    /* push lr onto stack */
    
    mov r3, #25
    mov r2, #6
    mov r1, r3

    ldr r0, address_of_message1
    bl printf

    ldr r0, address_of_format
    push {r2}    /* Move b onto top of stack */
    bl scanf

    ldr r1, [r1]
    ldr r2, [sp]
    
    @bl divmod

end:
    pop {lr}
    bx lr

address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_format : .word format
