#include "pch.h"
#include "CppUnitTest.h"
#include "../TestirovaniePO_KTbo2-10_PatychkinaEV/Function.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UnitTest1
{
	TEST_CLASS(UnitTest1)
	{
	public:
		
		TEST_METHOD(TestMethod1)
		{
			pair<Point, Point> tr, res;
			Point A = { 1001, 1 };
			Point B = { 1,1 };
			res = function(A, B);
			tr = { {0,0},{0,0} };
			Assert::AreEqual(tr, res);
		}
		TEST_METHOD(TestMethod2)
		{
			pair<Point, Point> tr, res;
			Point A = { -1001, 1 };
			Point B = { 1,1 };
			res = function(A, B);
			tr = { {0,0},{0,0} };
			Assert::AreEqual(tr, res);
		}
		TEST_METHOD(TestMethod3)
		{
			pair<Point, Point> tr, res;
			Point A = { 1, 1001 };
			Point B = { 1,1 };
			res = function(A, B);
			tr = { {0,0},{0,0} };
			Assert::AreEqual(tr, res);
		}
		TEST_METHOD(TestMethod4)
		{
			pair<Point, Point> tr, res;
			Point A = { 1, -1001 };
			Point B = { 1,1 };
			res = function(A, B);
			tr = { {0,0},{0,0} };
			Assert::AreEqual(tr, res);
		}
		TEST_METHOD(TestMethod5)
		{
			pair<Point, Point> tr, res;
			Point A = { 1, 1 };
			Point B = { 1001,1 };
			res = function(A, B);
			tr = { {0,0},{0,0} };
			Assert::AreEqual(tr, res);
		}
		TEST_METHOD(TestMethod6)
		{
			pair<Point, Point> tr, res;
			Point A = { 1, 1 };
			Point B = { -1001,1 };
			res = function(A, B);
			tr = { {0,0},{0,0} };
			Assert::AreEqual(tr, res);
		}
		TEST_METHOD(TestMethod7)
		{
			pair<Point, Point> tr, res;
			Point A = { 1, 1 };
			Point B = { 1,1001 };
			res = function(A, B);
			tr = { {0,0},{0,0} };
			Assert::AreEqual(tr, res);
		}
		TEST_METHOD(TestMethod8)
		{
			pair<Point, Point> tr, res;
			Point A = { 1, 1 };
			Point B = { 1,-1001 };
			res = function(A, B);
			tr = { {0,0},{0,0} };
			Assert::AreEqual(tr, res);
		}
		TEST_METHOD(TestMethod9)
		{
			pair<Point, Point> tr, res;
			Point A = { 1, 0 };
			Point B = { 0,1 };
			res = function(A, B);
			tr = { {1,0},{0,1} };
			Assert::AreEqual(tr, res);
		}
		TEST_METHOD(TestMethod10)
		{
			pair<Point, Point> tr, res;
			Point A = { 0, 0 };
			Point B = { 2,2 };
			res = function(A, B);
			tr = { {0,0},{0,0} };
			Assert::AreEqual(tr, res);
		}

		TEST_METHOD(TestMethod11)
		{
			pair<Point, Point> tr, res;
			Point A = { 2, 2 };
			Point B = { 0,0 };
			res = function(A, B);
			tr = { {0,0},{0,0} };
			Assert::AreEqual(tr, res);
		}
		TEST_METHOD(TestMethod12)
		{
			pair<Point, Point> tr, res;
			Point A = { 4, 4 };
			Point B = { 0,7 };
			res = function(A, B);
			tr = { {5.2263,2.1648},{-2.6788,6.4672} };
			Assert::AreEqual(tr, res);
		}
		TEST_METHOD(TestMethod13)
		{
			pair<Point, Point> tr, res;
			Point A = { 4, 6 };
			Point B = { -4,6 };
			res = function(A, B);
			tr = { {-5.0990,5.0990},{5.0990,5.0990} };
			Assert::AreEqual(tr, res);
		}
		TEST_METHOD(TestMethod14)
		{
			pair<Point, Point> tr, res;
			Point A = { 4, 4 };
			Point B = { 4,4 };
			res = function(A, B);
			tr = { {5.6569,5.0767},{5.0767,5.6569} };
			Assert::AreEqual(tr, res);
		}
		TEST_METHOD(TestMethod15)
		{
			pair<Point, Point> tr, res;
			Point A = { 1, 0 };
			Point B = { -1,0 };
			res = function(A, B);
			tr = { {-0.7071,0.7071},{-0.7071,-0.7071} };
			Assert::AreEqual(tr, res);
		}
	};
}
