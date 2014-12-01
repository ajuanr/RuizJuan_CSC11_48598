/*
 *
 * File:   main.cpp
 * Author: Juan Ruiz
 * Project 1 - 48598
 *
 * Created on October 27, 2014, 11:43 AM
 * Play a simplefied version of mastermind
 *
 *  Expand later by adding colors to the numbers
 * i.e add red, green, blue
 * choice now becomes something like red 3 or green 3
 */

#include <cstdlib>
#include <iostream>
#include <ctime>
using namespace std;

void fillArray(int *, int);
void print(int *, int);
void guess(int *, int );
int nRight(int *, int *, int);
int nWrong(int *, int *, int);

/*
 *          Main
 */
int main(int argc, char** argv) {
    srand(static_cast<unsigned int>(time(0)));
    /// create a pseudo-2d 3x3 array
    /// initialize all elements to zero
    const int SIZE = 3;
    int r0[SIZE];
    fillArray(r0, SIZE);
    int guessArray[SIZE];
    
    //print(r0, SIZE);
    //print(guessArray, SIZE);
    
    while (nRight(r0, guessArray, SIZE) != SIZE) {
        guess(guessArray, SIZE);
        cout << nRight(r0, guessArray, SIZE) << " in corrent position\n";
        cout << nWrong(r0, guessArray, SIZE) << " in wrong position\n";
        cout << endl;
    }
    return 0;
}

// r1 is the number of elements to guess
void fillArray(int *r0, int r1) {
    for (int r2 = 0; r2 != r1; ++r2) {
        int r3 = rand() % 7 + 1;
        *(r0 + r2) = r3;
    }
}

// r1 is the number of elements to guess
void  guess(int *array, int r1) {
    cout << "Enter numbers between 1 and 7\n";
    for (int r2 = 0; r2 != r1; ++r2) {
        cout << "Enter guess " << r2+1 << ": ";
        int r3;
        cin >> r3;
        *(array+r2)=r3;
    }
}

int nRight(int *r1, int *r2, int size) {
    int count = 0;
    for (int i = 0; i != size; ++i)
        if (*(r1+i) == *(r2+i))
            ++count;
    return count;
}

int nWrong(int *r1, int *r2, int size) {
    int count = 0;
    for (int i = 0; i != size; ++i)
        if (*(r1+i) != *(r2+i))
            ++count;
    return count;
}

void print(int * r1, int SIZE) {
    for (int i = 0; i != SIZE; ++i) {
        cout << *(r1+i) << " ";
    }
    cout << endl;
}
