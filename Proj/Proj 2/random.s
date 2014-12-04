/* r0 holds mininum 
 * r1 holds maximum */
.global random
random:
    push {r4, r5, r6, lr}

    mov r4,r1                         /* Save r1 to r2 */
	                              /* We want rand()%8 */
    mov r5, r0

    bl rand                           /* Call rand */
    
    mov r1, r0, asr #1                /* In case random return is negative */
    mov r2, r1
    bl divMod                         /* Call divMod function to get remainder */

    mov r0, r1                        /* return result in r0 */

    pop {r4, r5, r6, lr}                      /* Pop the top of the stack and put it in lr */
    bx lr                             /* Leave main */
/* Exit random number generator */
