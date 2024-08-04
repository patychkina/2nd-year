//Triangle.cpp
#include "Triangle.h"
#include <iostream>
using namespace std;

Triangle::Triangle(double xA, double yA, double xB, double yB, double xC, double yC)
{
    _xA = xA;
    _yA = yA;
    _xB = xB;
    _yB = yB;
    _xC = xC;
    _yC = yC;
}
Point Triangle::determinationOfTheCenterOfGravity()
{
    Point p;
    p.x = (_xA + _xB + _xC) / 3.0;
    p.y = (_yA + _yB + _yC) / 3.0;
    return p;
}
double Triangle::square()
{
    return abs((_xB - _xA) * (_yC - _yA) - (_xC - _xA) * (_yB - _yA)) / 2.0;
}
void Triangle::perimeter(double &P)
{
    double AB = 0, BC = 0, CA = 0;
    if (pow(_xB - _xA, 2) + pow(_yB - _yA, 2) < 0 || pow(_xB - _xC, 2) + pow(_yB - _yC, 2) < 0 || pow(_xC - _xA, 2) + pow(_yC - _yA, 2) < 0)
        throw 1;
    else
    {
        AB = sqrt(pow(_xB - _xA, 2) + pow(_yB - _yA, 2));
        BC = sqrt(pow(_xB - _xC, 2) + pow(_yB - _yC, 2));
        CA = sqrt(pow(_xC - _xA, 2) + pow(_yC - _yA, 2));
        P = AB + BC + CA;
    }
}
void Triangle::moving(double deltaX, double deltaY)
{
    _xA += deltaX;
    _yA += deltaY;
    _xB += deltaX;
    _yB += deltaY;
    _xC += deltaX;
    _yC += deltaY;
}
void Triangle::sizeChanges(char s)
{
    Point p;
    p.x = (_xA + _xB + _xC) / 3.0;
    p.y = (_yA + _yB + _yC) / 3.0;
    switch (s)
    {
    case '+':
    {
        _xA = p.x + (_xA - p.x) * 2.0;
        _yA = p.y + (_yA - p.y) * 2.0;
        _xB = p.x + (_xB - p.x) * 2.0;
        _yB = p.y + (_yB - p.y) * 2.0;
        _xC = p.x + (_xC - p.x) * 2.0;
        _yC = p.y + (_yC - p.y) * 2.0;
        break;
    }
    case '-':
    {
        _xA = p.x + (_xA - p.x) * 0.5;
        _yA = p.y + (_yA - p.y) * 0.5;
        _xB = p.x + (_xB - p.x) * 0.5;
        _yB = p.y + (_yB - p.y) * 0.5;
        _xC = p.x + (_xC - p.x) * 0.5;
        _yC = p.y + (_yC - p.y) * 0.5;
        break;
    }
    default:
        cout << "¬веденный символ неверный" << endl;
        break;
    }
}
char Triangle::comparisonSquare(Triangle t)
{
    double S1 = this->square();
    double S2 = t.square();
    if (S1 > S2)
        return '>';
    else
    {
        if (S1 < S2)
            return '<';
        else
            return '=';
    }
}
void Triangle::coutT()
{
    cout << "xA = " << _xA << " yA = " << _yA << endl;
    cout << "xB = " << _xB << " yB = " << _yB << endl;
    cout << "xC = " << _xC << " yC = " << _yC << endl;
}