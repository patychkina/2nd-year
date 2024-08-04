//Laba№2
#include <iostream>
#include <math.h>
#include <vector>
#include "Progression.h"
#include "Linear.h"
#include "Exponential.h"
#include "ProgressionCalculator.h"
using namespace std;

int main()
{
    setlocale(LC_ALL, "Russian");
    double a, d, b, r;
    int start, end;
    vector <pair<double, double>> arr;
    ProgressionCalculator PC;
    cout << "Введите значение первого числа арифметической прогрессии: a = ";
    cin >> a;
    cout << endl;
    cout << "Введите значение разности арифметической прогрессии: d = ";
    cin >> d;
    cout << endl;
    cout << "Введите значение первого числа геометрической прогрессии: b = ";
    cin >> b;
    cout << endl;
    cout << "Введите значение знаменателя геометрической прогрессии: r = ";
    cin >> r;
    cout << endl;
    cout << "Введите начальное значение изменяющегося аргумента: start = ";
    cin >> start;
    cout << endl;
    cout << "Введите конечное значение изменяющегося аргумента: end = ";
    cin >> end;
    cout << endl;
    arr = PC.bothProgressions(a, d, b, r, start, end);
    for (int i = start; i < end + 1; i++)
    {
        cout << "Сумма " << i << " членов арифметической прогрессии = " << arr[i - start].first << endl;
        cout << "Сумма " << i << " членов геометрической прогрессии = " << arr[i - start].second << endl;
        cout << endl;
    }
}