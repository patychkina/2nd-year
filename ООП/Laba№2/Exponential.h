//Exponential.h
#pragma once
#include "Progression.h"

//����� �������������� ����������
class Exponential : public Progression
{
private:
    double b; // ������ ���� ����������
    double r; // �����������

public:
    Exponential(double first, double ratio);//�����������

    double sumOfProgression(int n) override;//����� �������������� ����������
};
