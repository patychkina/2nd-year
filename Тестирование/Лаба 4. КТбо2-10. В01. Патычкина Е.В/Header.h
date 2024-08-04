#pragma once
#include <iostream>
#include <vector>
#include <string>
using namespace std;

struct Abonent{
    int id;
    double x;
    double y;
};

struct History {
    int id;
    double price;
};

struct Result {
    int id;
    double total_price;
    double distant;
};

struct Info {
    int id =0;
    double sum=0;
    int count=0;
    double dist=0;
    double P = 0;
};

 pair <double,vector <Result>> function(vector <Abonent> &Abon_array, vector <History> &His_array)
{
     int N = Abon_array.size();
     double total_P = 0;
     int count_hist_abon = 0;
     double medium_P = 0;
     vector<Result> Res_array;
     if (Abon_array[0].x < -10000 || Abon_array[0].x > 10000 || Abon_array[0].y < -10000 || Abon_array[0].y > 10000) throw invalid_argument("Restoran location error!");
     if (Abon_array.size() < 1 || Abon_array.size() > 10000) throw invalid_argument("Abonents array size error!");
     if (His_array.size() < 0 || His_array.size() > 1000000) throw invalid_argument("History array size error!");
     for (int i = 1; i < N; i++)
     {
         if (Abon_array[i].id != i) throw invalid_argument("Abonents ID error!");
     }
     for (int i = 0; i < His_array.size(); i++)
     {
         if (His_array[i].id >= N) throw invalid_argument("History ID error!");
         if (His_array[i].price < 1 || His_array[i].price> 1000000) throw invalid_argument("History price error!");
     }
     vector <Info> Information;
     Information.resize(N);
     double x0, y0;
     x0 = Abon_array[0].x;
     y0 = Abon_array[0].y;
     for (int i = 0; i < His_array.size(); i++)
     {
         int id;
         double price;
         double x, y;
         id = His_array[i].id;
         price = His_array[i].price;
         Information[id].id = id;
         Information[id].sum += price;
         Information[id].count += 1;
         x = Abon_array[id].x;
         y = Abon_array[id].y;
         if (x < x0-10000.0001 || x > x0 + 10000 || y < y0 - 10000 || y > y0 + 10000) throw invalid_argument("Abonent location error!");
         Information[id].dist = sqrt((x0 - x) * (x0 - x) + (y0 - y) * (y0 - y));
     }
     for (int i = 1; i < N; i++)
     {
         Information[i].P = Information[i].sum / (2.0 * Information[i].count * Information[i].dist);
         if (Information[i].id != 0)
         {
             count_hist_abon++;
             total_P += Information[i].P;
         }
     }
     medium_P = total_P / (N-1);
     for (int i = 1; i < N; i++)
     {
         if (Information[i].P >= medium_P)
         {
             Res_array.push_back({ Information[i].id, Information[i].P, Information[i].dist });
         }
     }
     return { medium_P, Res_array };
}