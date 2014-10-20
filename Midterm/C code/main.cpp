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
    int r1;               // pay rate
    int r2;               // hours worked
    int r3;               // temp
    int r4;               // holds hours > than pay differential
    cin >> r1 >> r2;
    
    cout << "Hours: " << r1 << endl;
    cout << "Pay rate: " << r2 << endl;
    
    // check if triple time applies
    if ( r2 > 40) {
        r4 = r2 - 40;           // r3 holds hours > 40 worked
        r3 = r1 * 3;            // triple time pay
        r3 = r3 * r4;           // r3 holds that amount of triple time pay
        r2 = r2 - r4;           // move hours into double time
        r0 = r0 + r3;           // add to total pay
        cout << r0 << endl;
    }
    
    // check if double time applies
    if ( r2 > 20) {
        r4 = r2 - 20;           // r3 holds hours > 20 worked
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