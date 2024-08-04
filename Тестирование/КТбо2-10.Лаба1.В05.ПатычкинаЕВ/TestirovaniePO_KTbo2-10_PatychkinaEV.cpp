#include <iostream>
using namespace std;
#include "Function.h"

int main()
{
    Point pointA, pointB;
    std::cout << "A (x y): ";
    std::cin >> pointA.x >> pointA.y;
    std::cout << "B (x y): ";
    std::cin >> pointB.x >> pointB.y;
    pair <Point, Point> res = function(pointA, pointB);
    cout << "Ax = " << res.first.x << " Ay = " << res.first.y << " Bx = " << res.second.x << " By = " << res.second.y << endl;
}
