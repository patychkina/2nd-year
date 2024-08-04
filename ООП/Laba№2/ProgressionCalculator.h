//ProgressionCalculator.h
#pragma once
#include <vector>
using namespace std;

//Дополнительный класс обеих прогрессий для аргумента, зменяющегося в заданном интервале
class ProgressionCalculator {
public:
    vector <pair<double, double>> bothProgressions(double a, double d, double b, double r, int start, int end);// Считает арифметическую и геометрическую прогрессию для разных аргументов
};