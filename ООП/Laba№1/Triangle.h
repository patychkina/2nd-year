//Triangle.h
#pragma once
struct Point
{
    double x = 0;
    double y = 0;
};
//������������ ������
class Triangle
{//���� ������
    double _xA = 0;
    double _yA = 0;
    double _xB = 0;
    double _yB = 0;
    double _xC = 0;
    double _yC = 0;
public:
    //����������� ������ � �����������
    Triangle(double xA, double yA, double xB, double yB, double xC, double yC);
    //������
    Point determinationOfTheCenterOfGravity();//����������� ������ �������
   
    double square();//���������� ������� ������������
   
    void perimeter(double &P);//���������� ��������� ������������
    
    void moving(double deltaX, double deltaY);//����������� ������������
   
    void sizeChanges(char s);//��������� ��������
  
    char comparisonSquare(Triangle t);//��������� �������� �����
   
    void coutT();//����� ��������� ������������
  
};
