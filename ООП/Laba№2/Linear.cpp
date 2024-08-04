//Linear.cpp
#include "Linear.h"

Linear::Linear(double first, double difference)
{
    a = first;
    d = difference;
}
double Linear:: sumOfProgression(int n)
{
    return (n / 2.0) * (2 * a + (n - 1) * d);
}