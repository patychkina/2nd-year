#include "pch.h"
#include "CppUnitTest.h"
#include <string>
#include "../Laba2/Function.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UnitTest
{
	TEST_CLASS(UnitTest)
	{
	public:
		
		TEST_METHOD(TestMethod1)
		{
			string s = "abc abab abba ababa aab";
			int m, k, count1, count2;
			m = 4;
			k = 2;
			count1 = 2;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod2)
		{
			string s = "abc abab abba ababa aab";
			int m, k, count1, count2;
			m = 3;
			k = 1;
			count1 = 0;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod3)
		{
			string s = " abc   abab abba  ababa aab";
			int m, k, count1, count2;
			m = 4;
			k = 2;
			count1 = 2;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod4)
		{
			string s = "";
			int m, k, count1, count2;
			m = 2;
			k = 1;
			count1 = 0;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod5)
		{
			string s = "abc abab abba ababa aab";
			for (int i = 0; i < 77; i++)
			{
				s += ' ';
			}
			int m, k, count1, count2;
			m = 4;
			k = 2;
			count1 = 2;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod6)
		{
			string s = "abc abab abba ababa aab";
			for (int i = 0; i < 77; i++)
			{
				s += ' ';
			}
			s += 'a';
			int m, k, count1, count2;
			m = 4;
			k = 2;
			count1 = -1;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod7)
		{
			string s = "   ";
			int m, k, count1, count2;
			m = 2;
			k = 1;
			count1 = 0;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod8)
		{
			string s = "a abjsh akss b sdhk";
			int m, k, count1, count2;
			m = 1;
			k = 1;
			count1 = 2;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod9)
		{
			string s = "asdfghjkjh af skjds";
			int m, k, count1, count2;
			m = 10;
			k = 8;
			count1 = 1;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod10)
		{
			string s = "asdfghjkjhh af skjds";
			int m, k, count1, count2;
			m = 10;
			k = 8;
			count1 = -1;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod11)
		{
			string s = "a abjsh akss b sdhk";
			int m, k, count1, count2;
			m = 2;
			k = 3;
			count1 = -1;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod12)
		{
			string s = "asdfghjkjhh af skjds";
			int m, k, count1, count2;
			m = 11;
			k = 8;
			count1 = -1;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod13)
		{
			string s = "aBc abab abba ababa aab";
			int m, k, count1, count2;
			m = 4;
			k = 2;
			count1 = -1;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod14)
		{
			string s = "abc abab 1bba a3aba aab";
			int m, k, count1, count2;
			m = 4;
			k = 2;
			count1 = -1;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod15)
		{
			string s = "abc, aba.b abba ababa aab";
			int m, k, count1, count2;
			m = 4;
			k = 2;
			count1 = -1;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod16)
		{
			string s = "abc abab abba ababa aab";
			int m, k, count1, count2;
			m = 3;
			k = 3;
			count1 = 1;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod17)
		{
			string s = "abcs skjv pwoa hinm";
			int m, k, count1, count2;
			m = 4;
			k = 4;
			count1 = 4;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod18)
		{
			string s = "basnfkiuyt and fkls";
			int m, k, count1, count2;
			m = 10;
			k = 10;
			count1 = 1;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod19)
		{
			string s = "bbbb aaa ffff";
			int m, k, count1, count2;
			m = 4;
			k = 1;
			count1 = 2;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod20)
		{
			string s = "";
			for (int i = 0; i < 50; i++)
			{
				s += "a ";
			}
			int m, k, count1, count2;
			m = 1;
			k = 1;
			count1 = 50;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod21)
		{
			string s = "aБc abab abba ababa aab";
			int m, k, count1, count2;
			m = 4;
			k = 2;
			count1 = -1;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod22)
		{
			string s = "abc abab abba ababa aab";
			int m, k, count1, count2;
			m = 0;
			k = 1;
			count1 = -1;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
		TEST_METHOD(TestMethod23)
		{
			string s = "abc abab abba ababa aab";
			int m, k, count1, count2;
			m = 1;
			k = 0;
			count1 = -1;
			count2 = function(s, m, k);
			Assert::AreEqual(count1, count2);
		}
	};
}
