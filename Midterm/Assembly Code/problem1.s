.data
output: .asciz "Your pay is %d\n"


.text
    .global main
main:
    push {lr}
    mov r0, #0                    /* total pay */
    mov r1, #10                   /* r1 holds pay rate */
    mov r2, #60                   /* r2 holds hours worked */

    /* check if triple time applies */
    cmp r2, #40
    blt doubleTime
        sub r4, r2, #40           /* r4 holds hours > 40 worked */
        add r3, r3, r3, LSL #1
              @mul r3, r1, #3            /* triple time pay */
        mul r3, r4, r3            /* r3 holds that amount of triple time pay */
        sub r2, r2, r4            /* move hours into double time */
        add r0, r0,  r3           /* add to total pay */

    doubleTime:
    /* check if double time applies */
    cmp r2, #20
    blt straightTime
        sub r4, r2, #20           /* r4 holds hours > 20 worked */
        mov r3, r3, LSL #1
               @mul r3, r1, #2            /* double time pay */
        mul r3, r4, r3           /* r3 holds that amount of double time pay */
        sub r2, r2, r4           /* move hours into straight time */
        add r0, r0, r3           /* add to total pay */

    straightTime:
    cmp r2, #0
    blt exit
        mul r3, r1, r2
        add r0, r0, r3

    exit:
        
        pop {r4, lr}
        bx lr

address_of_output: .word output
