#pragma once
#include <iostream>
#include <string>
#include <map>
using namespace std;

int function(string S, int m, int k)
{
	int count = 0;
	if (S.length() > 100) return -1;
	if (k > m) return -1;
	if (k == 0 || m == 0) return -1;
	for (int i = 0; i < S.length(); i++)
	{
		if ((S[i]>=97 && S[i]<=122) || S[i] == ' '){}
		else {
			return -1;
		}
	}
	int m2 = 0;
	int k2 = 0;
	map <char, int> slovar;
	for (int i = 0; i < S.length(); i++)
	{
		while (S[i] != ' ' && i < S.length())
		{
			m2++;
			slovar[S[i]]++;
			k2 = slovar.size();
			i++;
		}
		if (m2 > 10) return -1;
		if (m == m2 && k == k2) {
			count++;
		}
		m2 = 0;
		k2 = 0;
		slovar.clear();
	}
	return count;
}