//Linear.h
#pragma once
#include "Progression.h"

//����� �������������� ����������
class Linear : public Progression
{
private:
    double a; // ������ ���� ����������
    double d; // ��������
public:
    Linear(double first, double difference);//�����������

    double sumOfProgression(int n) override ;//����� ������������� ����������
};
