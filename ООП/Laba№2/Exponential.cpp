//Exponential.cpp
#include "Exponential.h"
#include <math.h>

Exponential::Exponential(double first, double ratio)
{
    b = first;
    r = ratio;
}

double Exponential:: sumOfProgression(int n)
{
    return b * (1 - pow(r, n)) / (1 - r);
}