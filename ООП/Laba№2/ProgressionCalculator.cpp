//ProgressionCalculator.cpp
#include "ProgressionCalculator.h"
#include "Linear.h"
#include "Exponential.h"
#include <vector>
using namespace std;

vector <pair<double, double>> ProgressionCalculator::bothProgressions(double a, double d, double b, double r, int start, int end)
{
    Linear Lin(a, d);
    Exponential Ex(b, r);
    vector <pair<double, double>> arr;
    for (int i = start; i < end + 1; i++)
    {
        double AP = Lin.sumOfProgression(i);
        double GP = Ex.sumOfProgression(i);
        arr.push_back(pair<double, double>(AP, GP));
    }
    return arr;
}