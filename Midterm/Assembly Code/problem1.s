.data



.text
    .global main
main:
    push {lr}
    mov r0, #0            /* total pay */
    mov r1, #10      // r1 holds pay rate
    mov r2, #60      // r2 holds hours worked
    int r3;               // temp
    int r4;               // holds the hours > than pay differential

    // check if triple time applies
    if ( r2 > 40) {
        sub r4, r2, #40;           // r4 holds hours > 40 worked
        mul r3, r1, 3;            // triple time pay
        mul r3, r4, r3;           // r3 holds that amount of triple time pay
        sub r2,  r2, r4;           // move hours into double time
        add r0, r0,  r3;           // add to total pay
    }

    // check if double time applies
    if ( r2 > 20) {
        r4 = r2 - 20;           // r4 holds hours > 20 worked
        r3 = r1 * 2;            // double time pay
        r3 = r3 * r4;           // r3 holds that amount of double time pay
        r2 = r2 - r4;           // move hours into straight time
        r0 = r0 + r3;           // add to total pay
    }

    // check if straight time applies
    if ( r1 > 0) {
        r3 = r1 * r2;
        r0 = r0 + r3;
    }
    return r0;
}

    doubleTime
