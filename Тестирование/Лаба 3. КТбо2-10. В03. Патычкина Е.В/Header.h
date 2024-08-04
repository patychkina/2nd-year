#pragma once
#include <iostream>
#include <vector>
using namespace std;

pair <float, float> found(vector <float>& Tmin, vector <float>& Tmax)
{
    pair <float, float> result;
    int n = Tmin.size();
    int i2;
    string s_min = "The following elements of the TMIN sequence are out of range : ";
    string s_max = "The following elements of the TMAX sequence are out of range : ";
    float delte_Tmin = 1000.1;
    float delte_Tmax = -0.1;
    if (Tmin.size() < 0 || Tmin.size() > 100) throw invalid_argument("Size TMIN is not correct!");
    if (Tmax.size() < 0 || Tmax.size() > 100) throw invalid_argument("Size TMAX is not correct!");
    if (Tmin.size() != Tmax.size()) throw invalid_argument("The sizes of sequences TMIN and TMAX are inconsistent!");
    bool flag1 = true, flag2 = true;
    if (Tmin.size() == 0 || Tmax.size() == 0)
    {
        delte_Tmin = 0;
        delte_Tmax = 0;
    }
    for (int i = 0; i < Tmin.size(); i++)
    {
        if (Tmin[i] > 1000 || Tmin[i] < -250)
        {
            i2 = i + 1;
            s_min += to_string(i2);
            s_min += " ";
            flag1 = false;
        }
    }
    if (!flag1)
    {
        s_min += "!";
        throw invalid_argument(s_min);
    }
    for (int i = 0; i < Tmax.size(); i++)
    {
        if (Tmax[i] > 1000 || Tmax[i] < -250)
        {
            i2 = i + 1;
            s_max += to_string(i2);
            s_max += " ";
            flag2 = false;
        }
       
    }
    if (!flag2)
    {
        s_max += "!";
        throw invalid_argument(s_max);
    }
    for (int i = 0; i < n; i++)
    {
        float delte = abs(Tmax[i] - Tmin[i]);
        if (delte > delte_Tmax)
            delte_Tmax = delte;
        if (delte < delte_Tmin)
            delte_Tmin = delte;
    }
    result = { delte_Tmin, delte_Tmax };
    return result;
}