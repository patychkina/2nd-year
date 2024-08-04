#pragma once
#include <iostream>
using namespace std;

struct Point {
    double x;
    double y;
};

double len_vector(Point a)
{
    return sqrt(a.x * a.x + a.y * a.y);
}

double scalar_product(Point a, Point b)
{
    return (a.x * b.x + a.y * b.y);
}

pair <Point, Point> function(Point a, Point b)
{
    double det = a.x * b.y - a.y * b.x;
    Point A, B;
    bool flag = false;
    if (a.x > 1000 || a.x < -1000 || a.y>1000 || a.y < -1000 || b.x>1000 || b.x < -1000 || b.y>1000 || b.y < -1000)
        return { {0,0}, {0,0} };
    //Если вектор А правее, то меняем вектора А и В местами
    if (det < 0) {
        swap(a.x, b.x);
        swap(a.y, b.y);
        flag = true;
    }
    Point zero_vec = { 0.0 , 0.0 };
    Point vectorA = { zero_vec.x - a.x, zero_vec.y - a.y };
    Point vectorB = { zero_vec.x - b.x, zero_vec.y - b.y };
    //Длина векторов
    double lenA = len_vector(vectorA);
    double lenB = len_vector(vectorB);
    //Скалярное произведение векторов
    double scal = scalar_product(a, b);
    //Косинус угла
    double val_cos = scal / (lenA * lenB);
    //Значение угла между векторами
    double arccos = roundf(acos(val_cos) * 180 / 3.14159265);
    double angle = (90 - arccos) / 2 * 3.14159265 / 180;
    A.x = a.x * cos(-angle) - a.y * sin(-angle);
    A.y = a.x * sin(-angle) + a.y * cos(-angle);

    B.x = b.x * cos(angle) - b.y * sin(angle);
    B.y = b.x * sin(angle) + b.y * cos(angle);

    if (flag)
    {
        swap(A.x, B.x);
        swap(A.y, B.y);
    }
    return { A, B };
}