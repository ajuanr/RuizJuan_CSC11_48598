/* -- printf02.s */
.data
 
/* First message */
.balign 4
message1: .asciz "Hey, type a number: "
 
/* Second message */
.balign 4
message2: .asciz "Hey, type another number: "

/* Second message */
.balign 4
message3: .asciz "%d times 5 is %d\n"
 
/* Format pattern for scanf */
.balign 4
scan_pattern : .asciz "%d"
 
.balign 4
scan_pattern2 : .asciz "%d"

/* Where scanf will store the number read */
.balign 4
numer_read: .word 0

.balign 4
denom_read: .word 0

.balign 4
return: .word 0
 
.balign 4
return2: .word 0
 
.text
 
/*
Efficient divide funtion
*/
mult_by_5:
    ldr r1, address_of_return2       /* r1 <- &address_of_return */
    str lr, [r1]                     /* *r1 <- lr */
 
 mov r2, #111
    mov r3, #5
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
    bgt _scaleL
    mov r4, r4, lsr#1
    mov r5, r5, lsr#1

    @add sub
    _addSub:
    add r0, r0, r4
    sub r1, r1, r5
    bal _ScaleR

    _asTest:
    cmp r4, #1  @ test whether addSbu loop should continue
    bge _addSub
    blt _exit

    @scale right
    _ScaleR:
    mov r4, r4, lsr#1
    mov r5, r5, lsr#1
    cmp r1, r5
    blt _ScaleR
    bgt _asTest
 
    ldr lr, address_of_return2       /* lr <- &address_of_return */
    ldr lr, [lr]                     /* lr <- *lr */
    bx lr                            /* return from main using lr */
address_of_return2 : .word return2
 
.global main
main:
    ldr r1, address_of_return        /* r1 <- &address_of_return */
    str lr, [r1]                     /* *r1 <- lr */
 
    ldr r0, address_of_message1      /* r0 <- &message1 */
    bl printf                        /* call to printf */
 
    ldr r0, address_of_scan_pattern  /* r0 <- &scan_pattern */
    ldr r1, address_of_numer_read   /* r1 <- &number_read */
    bl scanf                         /* call to scanf */
 
    ldr r0, address_of_scan_pattern2 /* r0 <- &scan_pattern */
    ldr r2, address_of_denom_read             @@@@@@@@@@@@@@@@
    bl scanf                         /* call to scanf */

    ldr r0, address_of_numer_read   /* r0 <- &number_read */
    ldr r0, [r0]                     /* r0 <- *r0 */
    bl mult_by_5
 
    mov r2, r0                       /* r2 <- r0 */
    ldr r1, address_of_numer_read   /* r1 <- &number_read */
    ldr r1, [r1]                     /* r1 <- *r1 */
    ldr r0, address_of_message2      /* r0 <- &message2 */
    bl printf                        /* call to printf */
 
    ldr lr, address_of_return        /* lr <- &address_of_return */
    ldr lr, [lr]                     /* lr <- *lr */
    bx lr                            /* return from main using lr */
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_scan_pattern : .word scan_pattern
address_of_scan_pattern2 : .word scan_pattern2
address_of_numer_read : .word numer_read
address_of_denom_read : .word denom_read
address_of_return : .word return
 
/* External */
.global printf
.global scanf
