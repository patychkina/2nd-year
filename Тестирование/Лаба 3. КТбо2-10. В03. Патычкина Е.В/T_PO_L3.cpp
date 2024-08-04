#include <iostream>
#include <vector>
#include <string>
#include "Header.h"

int main()
{
    int n = 7;
    vector <float> Tmax, Tmin;
    //Tmin = { -3, -5,  4, 0, -1.2, 5, 8 };
    //Tmax = { 10, -2, 5, 15, 16, 5, 14 };
    pair <float, float> result;
    result = found(Tmin, Tmax);
    cout << result.first << " " << result.second << endl;
}

