//ProgressionCalculator.h
#pragma once
#include <vector>
using namespace std;

//�������������� ����� ����� ���������� ��� ���������, ������������ � �������� ���������
class ProgressionCalculator {
public:
    vector <pair<double, double>> bothProgressions(double a, double d, double b, double r, int start, int end);// ������� �������������� � �������������� ���������� ��� ������ ����������
};