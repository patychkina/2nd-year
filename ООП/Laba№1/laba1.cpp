//Laba№1
#include <iostream>
#include <math.h>
#include <string.h>
#include "Triangle.h"
using namespace std;

int main()
{
    setlocale(LC_ALL, "Russian");
    double xA, yA, xB, yB, xC, yC, S, S2, P = 0;
    double xA2, yA2, xB2, yB2, xC2, yC2;
    int choose;
    char symbol;
    string answer;
    Point C;
    bool flag = true;
    while (flag)
    {
        cout << "Введите координаты вершин треугольника:" << endl;
        cout << " xA = ";
        cin >> xA;
        cout << " yA = ";
        cin >> yA;
        cout << endl;
        cout << " xB = ";
        cin >> xB;
        cout << " yB = ";
        cin >> yB;
        cout << endl;
        cout << " xC = ";
        cin >> xC;
        cout << " yC = ";
        cin >> yC;
        cout << endl;
        Triangle T(xA, yA, xB, yB, xC, yC);
        cout << "Выберите команду из перечисленных и введите номер команды.\n1) Определения центра тяжести\n2) Нахождение площади треугольника\n3) Нахождение периметра треугольника\n4) Перемещение треугольника\n5) Изменение размеров треугольника\n6) Сравнение площадей двух объектов\n Команда = ";
        cin >> choose;
        cout << endl;
        switch (choose)
        {
        case 1:
        { Point p = T.determinationOfTheCenterOfGravity();
        cout << "x = " << p.x << ' ' << "y = " << p.y << endl;
        break;
        }
        case 2:
        { 
            S = T.square();
            cout << "S = " << S << endl;
            break;
        }
        case 3:
        {
            try
            {
                T.perimeter(P);
                cout << "P = " << P << endl;
            }
            catch (int e)
            {
                if (e == 1)
                {
                    cout << "Извлечение корня из отрицательного числа" << endl;
                    return -1;
                }
            }
            break;
        }
        case 4:
        {   cout << "Введите deltaX и deltaY для перемещения треугольника:" << endl;
        double deltaX, deltaY;
        cout << "deltaX = ";
        cin >> deltaX;
        cout << "deltaY = ";
        cin >> deltaY;
        cout << endl;
        T.moving(deltaX, deltaY);
        T.coutT();
        break;
        }
        case 5:
        { cout << "Введите '+' если хотите увеличить треугольник, '-' в обратном случае" << endl;
        cout << "Символ = ";
        cin >> symbol;
        T.sizeChanges(symbol);
        T.coutT();
        break;
        }
        case 6:
        {  cout << "Введите координаты вершин второго треугольника:" << endl;
        cout << " xA2 = ";
        cin >> xA2;
        cout << " yA2 = ";
        cin >> yA2;
        cout << endl;
        cout << " xB2 = ";
        cin >> xB2;
        cout << " yB2 = ";
        cin >> yB2;
        cout << endl;
        cout << " xC2 = ";
        cin >> xC2;
        cout << " yC2 = ";
        cin >> yC2;
        cout << endl;
        Triangle T2(xA2, yA2, xB2, yB2, xC2, yC2);
        char comparison = T.comparisonSquare(T2);
        S2 = T2.square();
        S = T.square();
        cout << "S1(" << S << ") " << comparison << " S2(" << S2 << ")" << endl;
        break;
        }
        default:
            cout << "Такой команды не существует." << endl;
            break;
        }
        cout << "Если хотите повторить, введите 'continue'" << endl;
        cin >> answer;
        if (answer == "continue")
            flag = true;
        else
            flag = false;
    }
}
