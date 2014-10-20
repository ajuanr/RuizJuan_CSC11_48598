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

/*
 * 
 */
int main(int argc, char** argv) {
    problem1();
    return 0;
}

void problem1() {
    cout << "Enter the pay rate and hours worked: ";
    int r0=0;             // total pay
    int r1;               // hours worked
    int r2;               // pay rate
    int r3;               // temp
    cin >> r2 >> r1;
    cout << "Hours: " << r1 << endl;
    cout << "Pay rate: " << r2 << endl;
    
    // check if triple time applies
    if ( r1 > 40) {
        r3 = r1-40;               // holds number of hours over 40
        r1 = r1 - 20;             // shift hours into double time
        r3 = r3 * r2*3;           // r3 holds that amount of triple time pay
        r0 = r0 + r3;             // add to total pay
    }
    
    // check if double time applies
    if ( r1 > 20) {
        r3 = r1-20;               // holds number of hours over 20
        r1 = r1 - 20;            // shift hours into straight time
        r3 = r3 * r2*2;           //r3 now holds that amount of triple time pay
        r0 = r0 + r3;
    }
    
    // check if straight time applies
    if ( r1 > 0) {
        r3 = r1 * r2;
        r0 = r0 + r3;
    }
    cout << "Pay: ";
    cout << r0 << endl;
    
}