/*
 * File:   main.cpp
 * Author: rcc
 *
 * Created on October 20, 2014, 11:43 AM
 */

#include <cstdlib>
#include <iostream>
using namespace std;

void problem1();
void problem2();
void bill(int&, int&);
void prob2();
/*
 *
 */
int main(int argc, char** argv) {
    problem2();
    return 0;
}

void problem1() {
    cout << "Enter the pay rate and hours worked: ";
    int r1;               // pay rate
    int r2;               // hours worked
    int r3;               // temp
    
    cin >> r1 >> r2;
    
    int r0 = 5 * r1;                 // r0 will hold bill amount
    r0 = r0 + 25;                  // r0 now holds base bill
    
    int r4 = 11 * r1;               // holds hours > than pay differential
    
    /// remember r4 must be preserved: push {r4}
    // check if triple time applies
    if ( r2 > 40) {
        r4 = r2 - 40;           // r4 holds hours > 40 worked
        r3 = r1 * 3;            // triple time pay
        r3 = r3 * r4;           // r3 holds that amount of triple time pay
        r2 = r2 - r4;           // move hours into double time
        r0 = r0 + r3;           // add to total pay
        cout << r0 << endl;
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
    cout << "Pay: " << r0 << endl;
    
}

void problem2() {
    cout << "Which package do you have: 1,2,or 3: ";
    int r1;             // r1 will hold the package;
    cin >> r1;
    cout << "How many hours did you use: ";
    int r2;             // r2 will hold the hours
    cin >> r2;

    int r0 = 5 * r1;                 // r0 will hold bill amount
    r0 = r0 + 25;                  // r0 now holds base bill
                                    // always part of bill
    int r3 = 11*r1;             // base hours allowed
    r1 = 4 - r1;                // this is the rate charge
    r3 = r3<<1;                // hours over this charged at max rate
    
    int r4;                     // holds hours over differential
    // preserve this value. push {r4}
    
    //nt r5 = 4 - r1;             // r5 holds the charge per hour over base
    if (r2 > r3) {
        r4 = r2 - r3;           // r4 holds hours > than highest cost
        r1=r1<<1;               // change rate to max rate
        r2 = r2 - r4;           // move hours into lower tier
        r4 = r4 * r1;           // hours over times rate
        
        r0 = r0 + r4;           // add to total pay
        r1=r1>>1;               // shift rate back down
    }
    
    // shift hour tier
    r3 = r3>>1;
    if (r2 > r3) {
        r4 = r2 - r3;           // r4 holds hours > than base cost
        r4 = r4 * r1;
        
        r2 = r2 - r4;           // move hours into lower tier
        
        r0 = r0 + r4;           // add to total pay
        
    }
    cout << "r0: " << r0 << endl;
}