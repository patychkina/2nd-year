//Linear.h
#pragma once
#include "Progression.h"

//Класс арифметической прогрессии
class Linear : public Progression
{
private:
    double a; // первый член прогрессии
    double d; // разность
public:
    Linear(double first, double difference);//Конструктор

    double sumOfProgression(int n) override ;//Сумма арифметичекой прогрессии
};
