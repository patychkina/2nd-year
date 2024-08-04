//Triangle.h
#pragma once
struct Point
{
    double x = 0;
    double y = 0;
};
//Спецификация класса
class Triangle
{//Поля класса
    double _xA = 0;
    double _yA = 0;
    double _xB = 0;
    double _yB = 0;
    double _xC = 0;
    double _yC = 0;
public:
    //Конструктор класса с параметрами
    Triangle(double xA, double yA, double xB, double yB, double xC, double yC);
    //Методы
    Point determinationOfTheCenterOfGravity();//Определения центра тяжести
   
    double square();//Нахождение площади треугольника
   
    void perimeter(double &P);//Нахождение периметра треугольника
    
    void moving(double deltaX, double deltaY);//Перемещение треугольника
   
    void sizeChanges(char s);//Изменения размеров
  
    char comparisonSquare(Triangle t);//Сравнение площадей фигур
   
    void coutT();//Вывод координат треугольника
  
};
