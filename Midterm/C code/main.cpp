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
    cin >> r2 >> r1;
    
    if (r2 <=20 ){
        r0 = r1 *r2;
        r2 = r2 - 20; // if >0 worked more than 20 hours
    }
    
    if (r2 > 0 ){
        r2 = r2 - 20;  // move hours into double time range
        r3 = r1 * 2;   // double time
        r3 = r3 * r1;  // mov r3, r3, r1, lsl#1 double time pay
        r0 = r0 + r3;  // add to total pay
        r2 = r2-20;    // move hours into triple time
    }
    if ( r2 > 0 ) {
        r3 = r1 * 3;   // triple time rate
        r3 = r1 * r2;  // triple time pay
        r0 = r0 + r3;
    }
    
    cout << "Pay: " << r0 << endl;
//    cout << "Hours: " << r1 << endl;
//    cout << "Pay rate: " << r2 << endl;
//    
//    // check if triple time applies
//    if ( r1 > 40) {
//        r3 = r1-40;               // holds number of hours over 40
//        r1 = r1 - 20;             // shift hours into double time
//        r3 = r3 * r2*3;           // r3 holds that amount of triple time pay
//        r0 = r0 + r3;             // add to total pay
//    }
//    
//    // check if double time applies
//    if ( r1 > 20) {
//        r3 = r1-20;               // holds number of hours over 20
//        cout << "r3: " << r3 << endl;
//        r1 = r1 - 20;            // shift hours into straight time
//        r3 = r3 * r2*2;           //r3 now holds that amount of triple time pay
//        cout << "r3: " << r3 << endl;
//        r0 = r0 + r3;
//        cout << r0 << endl;
//    }
//    
//    // check if straight time applies
//    if ( r1 > 0) {
//        r3 = r1 * r2;
//        r0 = r0 + r3;
//    }
//    cout << "Pay: ";
//    cout << r0 << endl;
    
}