/* r0 holds mininum 
 * r1 holds maximum */
.global random
random:
    push {r4, r5, r6, lr}

    mov r4,r0                         /* Save min in r4 */
    mov r5, r1                        /* Save max in r5 */

    bl rand                           /* Call rand */
    
    mov r1, r0, asr #1                /* In case random return is negative */
    mov r2, r5
    bl divMod                         /* Call divMod function to get remainder */
                                          /* divmod returns in r1, r1 */

    mov r0, r2                        /* return result in r0 */
    add r0, r0, r4

    pop {r4, r5, r6, lr}                      /* Pop the top of the stack and put it in lr */
    bx lr                             /* Leave main */
/* Exit random number generator */
