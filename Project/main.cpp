/*
 *
 * File:   main.cpp
 * Author: Juan Ruiz
 * Project 1 - 48598
 *
 * Created on October 27, 2014, 11:43 AM
 */

#include <cstdlib>
#include <iostream>
using namespace std;

void print(char *, int=3, int=3);


/*
 *          Main
 */
int main(int argc, char** argv) {
    /// create a pseudo-2d 3x3 array
    /// initialize all elements to zero
    char r0[9] = {'*'};
    
    print(r0);
    
    
    return 0;
}

/// r0 holds the array
/// r1 holds the rows
/// r2 holds the columns
void print(char *r0, int r1, int r2) {
    /// r4 holds the length of the array
    int r4 = r1 * r2;
    for (int r3 = 0; r3 != r4; ++r3) {
        cout << r3 << endl;
        if (r3 == r2 )
            cout << endl;
        cout << *(r0 + r3);
        
    }
}