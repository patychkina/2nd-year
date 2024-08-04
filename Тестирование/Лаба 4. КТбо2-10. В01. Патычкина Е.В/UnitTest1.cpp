#include "pch.h"
#include "CppUnitTest.h"
#include "..\Laba4\Header.h"
#include <iostream>
#include <fstream>

void readAbon(vector <Abonent> &Abon_array)
{
	fstream Abon = fstream("..\\tests\\Abonents.txt", ios::in);//Считываемые данные
	
	streambuf* CIN = cin.rdbuf();
	
	cin.rdbuf(Abon.rdbuf());
	
	cin.rdbuf(CIN);

	int id, n;
	double x, y;

	Abon >> x >> y;
	Abon_array.push_back({ 0, x,y });
	Abon >> n;
	for (int i = 1; i <= n; i++)
	{
		Abon >> id>> x >> y;
		Abon_array.push_back({ id, x, y });
	}

	Abon.close();

}

void readHistory(vector <History>& Hist_array)
{
	fstream Hist = fstream("..\\tests\\OrderHistory.txt", ios::in);//Считываемые данные

	streambuf* CIN = cin.rdbuf();

	cin.rdbuf(Hist.rdbuf());

	cin.rdbuf(CIN);

	int id, n;
	double s;

	Hist >> n;
	for (int i = 0; i < n; i++)
	{
		Hist >> id >> s;
		Hist_array.push_back({ id,s });
	}

	Hist.close();
}

void readRes(double &Expected_P, int & Expected_count, vector<Result> &Expected_array)
{
	fstream Res = fstream("..\\tests\\Result.txt", ios::in);//Считываемые данные

	streambuf* CIN = cin.rdbuf();

	cin.rdbuf(Res.rdbuf());

	cin.rdbuf(CIN);

	int id, n;
	double p, d;
	Res >> Expected_P;
	Res >> Expected_count;
	for (int i = 0; i < Expected_count; i++)
	{
		Res >> id >> p >> d;
		Expected_array.push_back({ id,p,d });
	}
	Res.close();
}

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UnitTest1
{
	TEST_CLASS(UnitTest1)
	{
	public:
		
		TEST_METHOD(TestMethod1)
		{
			vector <Abonent> Abon_array;
			vector <History> Hist_array;
			vector<Result> Res_array;
			vector<Result> Expected_array;
			double Expected_P;
			int Expected_count;
			readAbon(Abon_array);
			readHistory(Hist_array);
			double medium_P;
			pair <double, vector <Result>> Res;
			Res = function(Abon_array, Hist_array);
			Res_array = Res.second;
			medium_P = Res.first;
			int n = Res_array.size();
			readRes(Expected_P, Expected_count, Expected_array);
			Assert::IsTrue(abs(Expected_P- medium_P) < 0.0001);
			Assert::AreEqual(Expected_count, n);
			for (int i = 0; i < n; i++)
			{
				int Expected_id, id;
				double Expected_p, p, Expected_d, d;
				Expected_id = Expected_array[i].id;
				id = Res_array[i].id;
				Expected_p = Expected_array[i].total_price;
				p = Res_array[i].total_price;
				Expected_d = Expected_array[i].distant;
				d = Res_array[i].distant;
				Assert::AreEqual(Expected_id, id);
				Assert::IsTrue(abs(Expected_p - p) < 0.0001);
				Assert::IsTrue(abs(Expected_d - d) < 0.0001);
			}
		}
		TEST_METHOD(TestMethod2)
		{
			vector <Abonent> Abon_array;
			vector <History> Hist_array;
			vector<Result> Res_array;
			vector<Result> Expected_array;
			double Expected_P;
			int Expected_count;
			readAbon(Abon_array);
			readHistory(Hist_array);
			double medium_P;
			pair <double, vector <Result>> Res;
			try
			{
				Res = function(Abon_array, Hist_array);
				Res_array = Res.second;
				medium_P = Res.first;
				int n = Res_array.size();
				readRes(Expected_P, Expected_count, Expected_array);
				Assert::IsTrue(abs(Expected_P - medium_P) < 0.0001);
				Assert::AreEqual(Expected_count, n);
				for (int i = 0; i < n; i++)
				{
					int Expected_id, id;
					double Expected_p, p, Expected_d, d;
					Expected_id = Expected_array[i].id;
					id = Res_array[i].id;
					Expected_p = Expected_array[i].total_price;
					p = Res_array[i].total_price;
					Expected_d = Expected_array[i].distant;
					d = Res_array[i].distant;
					Assert::AreEqual(Expected_id, id);
					Assert::IsTrue(abs(Expected_p - p) < 0.0001);
					Assert::IsTrue(abs(Expected_d - d) < 0.0001);
					Assert::Fail(L"Ждали исключение, а его нет!");
				}
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("Restoran location error!"), s);
			}
			catch (exception& Ex)
			{
				string type = typeid(Ex).name();
				string s = string(Ex.what());
				wstring s2 = L"Ждали исключение типа invalid_argument, а получили исключение ";
				wstring s3 = wstring(s.begin(), s.end());
				wstring s4 = L" типа ";
				wstring s5 = wstring(type.begin(), type.end());
				wstring s_res = s2 + s3 + s4 + s5;
				Assert::Fail(s_res.c_str());
			}
			catch (...)
			{
				Assert::Fail(L"Исключение неизвестного типа");
			}
		}
		TEST_METHOD(TestMethod3)
		{
			vector <Abonent> Abon_array;
			vector <History> Hist_array;
			vector<Result> Res_array;
			vector<Result> Expected_array;
			double Expected_P;
			int Expected_count;
			readAbon(Abon_array);
			readHistory(Hist_array);
			double medium_P;
			pair <double, vector <Result>> Res;
			try
			{
				Res = function(Abon_array, Hist_array);
				Res_array = Res.second;
				medium_P = Res.first;
				int n = Res_array.size();
				readRes(Expected_P, Expected_count, Expected_array);
				Assert::IsTrue(abs(Expected_P - medium_P) < 0.0001);
				Assert::AreEqual(Expected_count, n);
				for (int i = 0; i < n; i++)
				{
					int Expected_id, id;
					double Expected_p, p, Expected_d, d;
					Expected_id = Expected_array[i].id;
					id = Res_array[i].id;
					Expected_p = Expected_array[i].total_price;
					p = Res_array[i].total_price;
					Expected_d = Expected_array[i].distant;
					d = Res_array[i].distant;
					Assert::AreEqual(Expected_id, id);
					Assert::IsTrue(abs(Expected_p - p) < 0.0001);
					Assert::IsTrue(abs(Expected_d - d) < 0.0001);
					Assert::Fail(L"Ждали исключение, а его нет!");
				}
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("History array size error!"), s);
			}
			catch (exception& Ex)
			{
				string type = typeid(Ex).name();
				string s = string(Ex.what());
				wstring s2 = L"Ждали исключение типа invalid_argument, а получили исключение ";
				wstring s3 = wstring(s.begin(), s.end());
				wstring s4 = L" типа ";
				wstring s5 = wstring(type.begin(), type.end());
				wstring s_res = s2 + s3 + s4 + s5;
				Assert::Fail(s_res.c_str());
			}
			catch (...)
			{
				Assert::Fail(L"Исключение неизвестного типа");
			}
		}
		TEST_METHOD(TestMethod3)
		{
			vector <Abonent> Abon_array;
			vector <History> Hist_array;
			vector<Result> Res_array;
			vector<Result> Expected_array;
			double Expected_P;
			int Expected_count;
			readAbon(Abon_array);
			readHistory(Hist_array);
			double medium_P;
			pair <double, vector <Result>> Res;
			try
			{
				Res = function(Abon_array, Hist_array);
				Res_array = Res.second;
				medium_P = Res.first;
				int n = Res_array.size();
				readRes(Expected_P, Expected_count, Expected_array);
				Assert::IsTrue(abs(Expected_P - medium_P) < 0.0001);
				Assert::AreEqual(Expected_count, n);
				for (int i = 0; i < n; i++)
				{
					int Expected_id, id;
					double Expected_p, p, Expected_d, d;
					Expected_id = Expected_array[i].id;
					id = Res_array[i].id;
					Expected_p = Expected_array[i].total_price;
					p = Res_array[i].total_price;
					Expected_d = Expected_array[i].distant;
					d = Res_array[i].distant;
					Assert::AreEqual(Expected_id, id);
					Assert::IsTrue(abs(Expected_p - p) < 0.0001);
					Assert::IsTrue(abs(Expected_d - d) < 0.0001);
					Assert::Fail(L"Ждали исключение, а его нет!");
				}
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("Abonents ID error!"), s);
			}
			catch (exception& Ex)
			{
				string type = typeid(Ex).name();
				string s = string(Ex.what());
				wstring s2 = L"Ждали исключение типа invalid_argument, а получили исключение ";
				wstring s3 = wstring(s.begin(), s.end());
				wstring s4 = L" типа ";
				wstring s5 = wstring(type.begin(), type.end());
				wstring s_res = s2 + s3 + s4 + s5;
				Assert::Fail(s_res.c_str());
			}
			catch (...)
			{
				Assert::Fail(L"Исключение неизвестного типа");
			}
		}
	};
}
