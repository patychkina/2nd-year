//Exponential.h
#pragma once
#include "Progression.h"

//Класс геометрической прогрессии
class Exponential : public Progression
{
private:
    double b; // первый член прогрессии
    double r; // знаменатель

public:
    Exponential(double first, double ratio);//Конструктор

    double sumOfProgression(int n) override;//Сумма геометрической прогрессии
};
