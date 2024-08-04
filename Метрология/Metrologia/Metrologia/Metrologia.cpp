#include <iostream>
#include <vector>
#include <cmath>
using namespace std;

int factorial(int n)
{
    int f = 1, i = 1;
    for (i = 1; i <= n; ++i)
    {
        f = f * i;
    }
    return f;
}

pair<int, int> count_matrix(const vector<vector<int>>& matrix) {
    int negative_count = 0;
    int negative_sum = 0;
    for (const auto& row : matrix) {
        for (int element : row) {
            if (element < 0) {
                negative_count++;
                negative_sum += element;
            }
        }
    }
    negative_count = factorial(negative_count);
    return { negative_count, negative_sum };
}

double y_of_element(int x, int a, int n, int b, int m, int c, int k) {
    double y = ((n * exp(-a)) - (m * exp(-b))) * x / (k * (exp(-1 * (a + c))));
    return y;
}

vector<pair<int, double>> f_table(int x_s, int x_t, int h, const vector<vector<int>>& w,const vector<vector<int>>& v, const vector<vector<int>>& S) {
    pair <int, int> an = count_matrix(w);
    pair <int, int> bm = count_matrix(v);
    pair <int, int> ck = count_matrix(S);
    vector<pair<int, double>> f;
    for (int x = x_s; x <= x_t; x += h) {
        double y = y_of_element(x, an.first, an.second, bm.first, bm.second, ck.first, ck.second);
        f.push_back({ x, y });
    }
    return f;
}

int main() {
    vector<vector<int>> w = { {0, 1, 2, 7}, {-5, 6, 8, 0}, {-5, 7, 90, 4}, {2, 3, 1, 4} };
    vector<vector<int>> v = { {6, 1, 2, 3, -1}, {-4, 6, 5, 8, 0}, {4, 7, 2, 90, 4}, {7, 6, 3, 5, 4}, {1, 7, 2, 90, 4} };
    vector<vector<int>> S = { {6, 1, 2, 390, 3, 5}, {-5, 6, 5, 20, 8, 0}, {-5, 7, 2, 90, 3, 4}, {7, 6, 3, 5, 8, 4}, {4, 3, 7, 2, 90, 4}, {5, 6, 5, 20, 8, 0} };
    int x_s = 0;
    int x_t = 20;
    int h = 4;
    vector<pair<int, double>> f = f_table(x_s, x_t, h, w, v, S);
    cout << "(x, y)\n" << endl;
    for (const auto& pair : f) {
        cout << "(" << pair.first << ", " << pair.second << ")\n";
    }
}



