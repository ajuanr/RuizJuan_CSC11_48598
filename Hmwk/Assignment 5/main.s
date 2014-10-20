.data
/* First message */
.balign 4
message1: .asciz "Hey, type in two numbers: "

/* Division result message */
.balign 4
message2: .asciz "a/b = %d  and  a%%b = %d\n"

/* Format pattern for scanf */
.balign 4
scan_pattern : .asciz "%d %d"

/* Where scanf will store the number read */
.balign 4
number_read: .word 0

.balign 4
denom_read: .word 0

.text

.global main
main:
    push {lr}

    ldr r0, address_of_message1      /* r0 <- &message1 */
    bl printf                        /* call to printf */

    ldr r0, address_of_scan_pattern  /* r0 <- &scan_pattern */
    ldr r1, address_of_number_read   /* r1 <- &number_read */
    ldr r2, address_of_denom_read
    bl scanf                         /* call to scanf */

    ldr r1, address_of_number_read   /* r0 <- &number_read */
    ldr r1, [r1]                     /* r0 <- *r0 */
    ldr r2, address_of_denom_read
    ldr r2, [r2]

    bl divMod

    mov r2, r1
    mov r1, r0

    /* Print a/b */
    ldr r0, address_of_message2      /* r0 <- &message2 */
    bl printf                        /* call to printf */

    pop {lr}
    bx lr                            /* return from main using lr */
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_scan_pattern : .word scan_pattern
address_of_number_read : .word number_read
address_of_denom_read : .word denom_read
