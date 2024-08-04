#include "pch.h"
#include "CppUnitTest.h"
#include "../T_PO_L3/Header.h"
#include <iostream>
#include <vector>
using namespace std;

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UnitTest1
{
	TEST_CLASS(UnitTest1)
	{
	public:
		
		TEST_METHOD(TestMethod1)
		{
			pair <float, float> result;
			pair <float, float> expected = { 0.0 , 17.2 };
			vector <float> Tmax, Tmin;
			Tmin = { -3, -5,  4, 0, -1.2, 5, 8 };
			Tmax = { 10, -2, 5, 15, 16, 5, 14 };
			result = found(Tmin, Tmax);
			Assert::IsTrue(abs(result.first - expected.first) < 0.1);
			Assert::IsTrue(abs(result.second - expected.second) < 0.1);
		}
		TEST_METHOD(TestMethod2)
		{
			try
			{
				pair <float, float> result;
				//pair <float, float> expected = { 0.0 , 17.2 };
				vector <float> Tmax, Tmin;
				Tmin = { -250.1, -5,  4, 0, -1.2, 5, 8 };
				Tmax = { 10, -2, 5, 15, 16, 5, 14 };
				result = found(Tmin, Tmax);
				Assert::Fail(L"Ждали исключение, а его нет!");
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("The following elements of the TMIN sequence are out of range : 1 !"), s);
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
			try
			{
				pair <float, float> result;
				//pair <float, float> expected = { 0.0 , 17.2 };
				vector <float> Tmax, Tmin;
				Tmin = { 1000.1, -5,  4, 0, -1.2, 5, 8 };
				Tmax = { 10, -2, 5, 15, 16, 5, 14 };
				result = found(Tmin, Tmax);
				Assert::Fail(L"Ждали исключение, а его нет!");
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("The following elements of the TMIN sequence are out of range : 1 !"), s);
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
		TEST_METHOD(TestMethod4)
		{
			try
			{
				pair <float, float> result;
				vector <float> Tmax, Tmin;
				Tmin = { 10, -2, 5, 15, 16, 5, 14 };
				Tmax = { -250.1, -5,  4, 0, -1.2, 5, 8 };
				result = found(Tmin, Tmax);
				Assert::Fail(L"Ждали исключение, а его нет!");
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("The following elements of the TMAX sequence are out of range : 1 !"), s);
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
		TEST_METHOD(TestMethod5)
		{
			try
			{
				pair <float, float> result;
				vector <float> Tmax, Tmin;
				Tmin =  { 10, -2, 5, 15, 16, 5, 14 };
				Tmax = { 1000.1, -5,  4, 0, -1.2, 5, 8 };
				result = found(Tmin, Tmax);
				Assert::Fail(L"Ждали исключение, а его нет!");
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("The following elements of the TMAX sequence are out of range : 1 !"), s);
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
		TEST_METHOD(TestMethod6)
		{
			try
			{
				pair <float, float> result;
				vector <float> Tmax, Tmin;
				Tmin = { -3, -5,  4, 0, -1.2, 5, 8 };
				Tmax = { 10, -2, 5, 15, 16, 5, 14, 1 };
				result = found(Tmin, Tmax);
				Assert::Fail(L"Ждали исключение, а его нет!");
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("The sizes of sequences TMIN and TMAX are inconsistent!"), s);
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
		TEST_METHOD(TestMethod7)
		{
			try
			{
				pair <float, float> result;
				vector <float> Tmax, Tmin;
				Tmin = { -3, -5,  4, 0, -1.2, 5, 8, 1 };
				Tmax = { 10, -2, 5, 15, 16, 5, 14 };
				result = found(Tmin, Tmax);
				Assert::Fail(L"Ждали исключение, а его нет!");
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("The sizes of sequences TMIN and TMAX are inconsistent!"), s);
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
		TEST_METHOD(TestMethod8)
		{
			try
			{
				pair <float, float> result;
				vector <float> Tmax, Tmin;
				Tmin = { 3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2, 3.2};
				Tmax = { 10, -2, 5, 15, 16, 5, 14 };
				result = found(Tmin, Tmax);
				Assert::Fail(L"Ждали исключение, а его нет!");
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("Size TMIN is not correct!"), s);
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
		TEST_METHOD(TestMethod9)
		{
			try
			{
				pair <float, float> result;
				vector <float> Tmax, Tmin;
				Tmin = { -3, -5,  4, 0, -1.2, 5, 8};
				Tmax = { 3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2,  3.2, 3.2, 3.2 , 3.2, 3.2, 3.2, 3.2, 3.2 , 3.2, 3.2, 3.2 };
				result = found(Tmin, Tmax);
				Assert::Fail(L"Ждали исключение, а его нет!");
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("Size TMAX is not correct!"), s);
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
		TEST_METHOD(TestMethod10)
		{
			pair <float, float> result;
			pair <float, float> expected = { 0.0 , 0.0 };
			vector <float> Tmax, Tmin;
			Tmin = {};
			Tmax = {};
			result = found(Tmin, Tmax);
			Assert::IsTrue(abs(result.first - expected.first) < 0.1);
			Assert::IsTrue(abs(result.second - expected.second) < 0.1);
		}
		TEST_METHOD(TestMethod11)
		{
			try
			{
				pair <float, float> result;
				vector <float> Tmax, Tmin;
				Tmin = {};
				Tmax = { 10, -2, 5, 15, 16, 5, 14 };
				result = found(Tmin, Tmax);
				Assert::Fail(L"Ждали исключение, а его нет!");
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("The sizes of sequences TMIN and TMAX are inconsistent!"), s);
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
		TEST_METHOD(TestMethod12)
		{
			try
			{
				pair <float, float> result;
				vector <float> Tmax, Tmin;
				Tmin = { 10, -2, 5, 15, 16, 5, 14 };
				Tmax = { -3 , -5,  -250.1, 0, -1.2, -250.1, 8 };
				result = found(Tmin, Tmax);
				Assert::Fail(L"Ждали исключение, а его нет!");
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("The following elements of the TMAX sequence are out of range : 3 6 !"), s);
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
		TEST_METHOD(TestMethod13)
		{
			try
			{
				pair <float, float> result;
				vector <float> Tmax, Tmin;
				Tmin = { 10, -2, 5, 15, 16, 5, 14 };
				Tmax = { 1, -5,  4,1000.1, -1.2, 5, 1000.1 };;
				result = found(Tmin, Tmax);
				Assert::Fail(L"Ждали исключение, а его нет!");
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("The following elements of the TMAX sequence are out of range : 4 7 !"), s);
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
		TEST_METHOD(TestMethod14)
		{
			try
			{
				pair <float, float> result;
				vector <float> Tmax, Tmin;
				Tmin =  { -3, -5, -250.1, 0, -1.2, -250.1, 8 };
				Tmax = { 10, -2, 5, 15, 16, 5, 14 };
				result = found(Tmin, Tmax);
				Assert::Fail(L"Ждали исключение, а его нет!");
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("The following elements of the TMIN sequence are out of range : 3 6 !"), s);
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
		TEST_METHOD(TestMethod15)
		{
			try
			{
				pair <float, float> result;
				vector <float> Tmax, Tmin;
				Tmin =  { 1, -5, 4, 1000.1, -1.2, 5, 1000.1 };
				Tmax = { 10, -2, 5, 15, 16, 5, 14 };
				result = found(Tmin, Tmax);
				Assert::Fail(L"Ждали исключение, а его нет!");
			}
			catch (invalid_argument& Ex)
			{
				string s = string(Ex.what());
				Assert::AreEqual(string("The following elements of the TMIN sequence are out of range : 4 7 !"), s);
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
