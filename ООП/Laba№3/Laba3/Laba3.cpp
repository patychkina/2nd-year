#include <iostream>
#include <string>
#include <math.h>
using namespace std;

//Класс точка
class Point
{
public:
    double x = 0;
    double y = 0;
};
class Operation;
//Базовый класс
class Shape
{
protected:
    Point* arc = 0;
    friend Operation;
public:
    string ID = "";
    virtual double square() = 0; //Метод вычисления площади фигуры
    virtual Point centerOfGravity() = 0; //Метод вычисления центра тяжести
    virtual void rotate(double angle) = 0; //Метод вращения фигуры
    virtual void set(Point A, Point B, Point C, Point D) = 0;//Метод ввода координат вершин
    virtual void get() = 0; //Метод вывода координат вершин
    virtual void move(double deltaX, double deltaY) = 0; //Метод перемещения фигуры
    virtual ~Shape() { };//Деструктор
};

//Класс параллелограмм
class Parallelogram : public Shape
{
public:
    Parallelogram()//Конструктор класса Parallelogram
    {
        arc = new Point[4];
        ID = "Parallelogram";
    }
    void get() override //Метод вывода координат вершин
    {
        cout << "x1 = " << this->arc[0].x << " y1 = " << this->arc[0].y << endl;
        cout << "x2 = " << this->arc[1].x << " y2 = " << this->arc[1].y << endl;
        cout << "x3 = " << this->arc[2].x << " y3 = " << this->arc[2].y << endl;
        cout << "x4 = " << this->arc[3].x << " y4 = " << this->arc[3].y << endl;
    }
    void set(Point A, Point B, Point C, Point D) override //Метод ввода координат вершин
    {
        this->arc[0].x = A.x;
        this->arc[0].y = A.y;
        this->arc[1].x = B.x;
        this->arc[1].y = B.y;
        this->arc[2].x = C.x;
        this->arc[2].y = C.y;
        this->arc[3].x = D.x;
        this->arc[3].y = D.y;
    }
    double square() override //Метод вычисления площади фигуры
    {
        return abs((arc[1].x - arc[0].x) * (arc[2].y - arc[0].y) - (arc[2].x - arc[0].x) * (arc[1].y - arc[0].y));
    }
    Point centerOfGravity() override //Метод вычисления центра тяжести
    {
        Point point;
        point.x = (arc[0].x + arc[1].x + arc[2].x + arc[3].x) / 4.0;
        point.y = (arc[0].y + arc[1].y + arc[2].y + arc[3].y) / 4.0;
        return point;
    }
    void rotate(double angle) override //Метод вращения фигуры
    {
        double pi = 3.14159265358979323846;
        Point c = centerOfGravity();
        double angleR = angle * pi / 180.0;
        double cosA = cos(angleR);
        double sinA = sin(angleR);

        for (int i = 0; i < 4; i++) {
            double X = c.x + (arc[i].x - c.x) * cosA - (arc[i].y - c.y) * sinA;
            double Y = c.y + (arc[i].x - c.x) * sinA + (arc[i].y - c.y) * cosA;
            arc[i].x = round(X * 10000) / 10000;
            arc[i].y = round(Y * 10000) / 10000;
        }

    }
    void move(double deltaX, double deltaY) override //Метод перемещения фигуры
    {
        for (int i = 0; i < 4; i++)
        {
            this->arc[i].x += deltaX;
            this->arc[i].y += deltaY;
        }
    }
    ~Parallelogram() { delete[] arc; };//Деструктор класса Parallelogram
};

//Класс прямоугольник
class Rectangle : public Shape
{
public:
    Rectangle()//Конструктор класса Rectangle
    {
        arc = new Point[4];
        ID = "Rectangle";
    }
    void set(Point A, Point B, Point C, Point D) override //Метод ввода координат вершин
    {
        this->arc[0].x = A.x;
        this->arc[0].y = A.y;
        this->arc[1].x = B.x;
        this->arc[1].y = B.y;
        this->arc[2].x = C.x;
        this->arc[2].y = C.y;
        this->arc[3].x = D.x;
        this->arc[3].y = D.y;
    }
    void get() override //Метод вывода координат вершин
    {
        cout << "x1 = " << this->arc[0].x << " y1 = " << this->arc[0].y << endl;
        cout << "x2 = " << this->arc[1].x << " y2 = " << this->arc[1].y << endl;
        cout << "x3 = " << this->arc[2].x << " y3 = " << this->arc[2].y << endl;
        cout << "x4 = " << this->arc[3].x << " y4 = " << this->arc[3].y << endl;
    }
    double square() override //Метод вычисления площади фигуры
    {
        return sqrt(pow(arc[1].x - arc[0].x, 2) + pow(arc[1].y - arc[0].y, 2)) * sqrt(pow(arc[2].x - arc[1].x, 2) + pow(arc[2].y - arc[1].y, 2));
    }
    Point centerOfGravity() override //Метод вычисления центра тяжести
    {
        Point point;
        point.x = (arc[0].x + arc[1].x + arc[2].x + arc[3].x) / 4.0;
        point.y = (arc[0].y + arc[1].y + arc[2].y + arc[3].y) / 4.0;
        return point;
    }
    void rotate(double angle) override //Метод вращения фигуры
    {
        double pi = 3.14159265358979323846;
        Point c = centerOfGravity();
        double angleR = angle * pi / 180.0;
        double cosA = cos(angleR);
        double sinA = sin(angleR);

        for (int i = 0; i < 4; i++) 
        {
            double X = c.x + (arc[i].x - c.x) * cosA - (arc[i].y - c.y) * sinA;
            double Y = c.y + (arc[i].x - c.x) * sinA + (arc[i].y - c.y) * cosA;
            arc[i].x = round(X * 10000) / 10000;
            arc[i].y = round(Y * 10000) / 10000;
        }
    }
    void move(double deltaX, double deltaY) override //Метод перемещения фигуры
    {
        for (int i = 0; i < 4; i++)
        {
            this->arc[i].x += deltaX;
            this->arc[i].y += deltaY;
        }
    }
    ~Rectangle() { delete[] arc; };//Деструктор класса Rectangle
};

// Класс - фабрика производных от
//Shape объектов
class FactoryShape
{
public:
    static Shape* createShape(char Ch) //Метод создания фигуры
    {
        switch (Ch) {
        case 'P':
            return new Parallelogram();
        case 'R':
            return new Rectangle();
        default:
            return nullptr;
        }
    }
};

//Класс операций над двумя фигурами
class Operation
{
public:
    static int compare(Shape* first, Shape* second) //Метод сравнения площадей фигур
    {
        if (first->square() > second->square())
            return 1;
        else
        {
            if (first->square() < second->square())
                return 2;
            else
                return 3;
        }
    }

    static bool isIntersect(Shape* first, Shape* second) //Метод определения факта пересечения объектов
    {
        for (int i = 0; i < 4; i++) 
        {
            for (int j = 0; j < 4; j++)//Проходим все возможные сочетания векторов
            {
                Point p1 = first->arc[i];
                Point p2 = first->arc[(i + 1) % 4];
                Point p3 = second->arc[j];
                Point p4 = second->arc[(j + 1) % 4];

                double uA = ((p4.x - p3.x) * (p1.y - p3.y) - (p4.y - p3.y) * (p1.x - p3.x)) / ((p4.y - p3.y) * (p2.x - p1.x) - (p4.x - p3.x) * (p2.y - p1.y));
                double uB = ((p2.x - p1.x) * (p1.y - p3.y) - (p2.y - p1.y) * (p1.x - p3.x)) / ((p4.y - p3.y) * (p2.x - p1.x) - (p4.x - p3.x) * (p2.y - p1.y));

                if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1)
                    return 1;
            }
        }
        return 0;
    }
    
    static bool isInside(Point a, Point b, Point c, Point d, Point p) //Метод определения включения точки  в фигуру
    {
        double cp1 = (b.x - a.x) * (p.y - a.y) - (b.y - a.y) * (p.x - a.x);//Векторное произведение 3-х точек
        double cp2 = (c.x - b.x) * (p.y - b.y) - (c.y - b.y) * (p.x - b.x);
        double cp3 = (d.x - c.x) * (p.y - c.y) - (d.y - c.y) * (p.x - c.x);
        double cp4 = (a.x - d.x) * (p.y - d.y) - (a.y - d.y) * (p.x - d.x);

        return (cp1 >= 0 && cp2 >= 0 && cp3 >= 0 && cp4 >= 0) || (cp1 <= 0 && cp2 <= 0 && cp3 <= 0 && cp4 <= 0);
    }
    static bool isInclude(Shape* first, Shape* second) //Метод определения факта включения одного объекта в другой
    {
        return isInside(second->arc[0], second->arc[1], second->arc[2], second->arc[3], first->arc[0])
            && isInside(second->arc[0], second->arc[1], second->arc[2], second->arc[3], first->arc[1])
            && isInside(second->arc[0], second->arc[1], second->arc[2], second->arc[3], first->arc[2])
            && isInside(second->arc[0], second->arc[1], second->arc[2], second->arc[3], first->arc[3]);
    }
};

int main()
{
    setlocale(LC_ALL, "Russian");
    Shape* s1 = nullptr;
    Shape* s2 = nullptr;
    Point A, B, C, D;
    bool flag1 = true;
    bool flag2 = true;
    bool flag3 = true;
    int answer = 0;
    int choose;
    while (flag1)
    {
        while (flag2)//Вводим значения вершин первой фигуры
        {
            cout << "Выберите тип первой фигуры:\nP - Parallelogram\nR - Rectangle" << endl;
            char type;
            cin >> type;
            s1 = FactoryShape::createShape(type);
            if (s1) {
                cout << s1->ID << endl;            cout << "Введите координаты:" << endl;
                cout << "x1 = ";            cin >> A.x;
                cout << "y1 = ";            cin >> A.y;
                cout << "x2 = ";            cin >> B.x;
                cout << "y2 = ";            cin >> B.y;
                cout << "x3 = ";            cin >> C.x;
                cout << "y3 = ";            cin >> C.y;
                cout << "x4 = ";            cin >> D.x;
                cout << "y4 = ";            cin >> D.y;
                s1->set(A, B, C, D);
                flag2 = false;
            }
            else
            {
                cout << "Такой фигуры нет" << endl;
                cout << "Если необходимо продолжить введите 1, иначе 0." << endl;
                cin >> answer;
                if (!answer)
                {
                    flag1 = false;
                    flag2 = false;
                    flag3 = false;
                }
            }
        }
        while (flag3)//Вводим значения вершин второй фигуры
        {
            cout << "Выберите тип второй фигуры:\nP - Parallelogram\nR - Rectangle" << endl;
            char type;
            cin >> type;
            s2 = FactoryShape::createShape(type);
            if (s2) {
                cout << s2->ID << endl;            cout << "Введите координаты:" << endl;
                cout << "x1 = ";            cin >> A.x;
                cout << "y1 = ";            cin >> A.y;
                cout << "x2 = ";            cin >> B.x;
                cout << "y2 = ";            cin >> B.y;
                cout << "x3 = ";            cin >> C.x;
                cout << "y3 = ";            cin >> C.y;
                cout << "x4 = ";            cin >> D.x;
                cout << "y4 = ";            cin >> D.y;
                s2->set(A, B, C, D);
                flag3 = false;
            }
            else
            {
                cout << "Такой фигуры нет" << endl;
                cout << "Если необходимо продолжить введите 1, иначе 0." << endl;
                cin >> answer;
                if (!answer)
                {
                    flag1 = false;
                    flag2 = false;
                    flag3 = false;
                }
            }
        }
        if (flag1)
        {//Меню программы
            cout << "Выберите команду:\n";
            cout << "1) Вычислить площадь первой фигуры\n";
            cout << "2) Вычислить центр тяжести первой фигуры\n";
            cout << "3) Вращение первой фигуры\n";
            cout << "4) Перемещение первой фигуры\n";
            cout << "5) Вычислить площадь второй фигуры\n";
            cout << "6) Вычислить центр тяжести второй фигуры\n";
            cout << "7) Вращение второй фигуры\n";
            cout << "8) Перемещение второй фигуры\n";
            cout << "9) Cравнить два объекта по площади\n";
            cout << "10) Определить факт пересечения объектов\n";
            cout << "11) Определить факт включения одного объекта в другой\n";
            cout << "12) Выйти\n";
            cin >> choose;
            cout << endl;
            switch (choose)
            {
            case 1:
            {
                cout << "S первой фигуры = " << s1->square() << endl;
                break;
            }
            case 2:
            {
                cout << "x = " << s1->centerOfGravity().x << "\ny = " << s1->centerOfGravity().y << endl;
                break;
            }
            case 3:
            {
                double angle;
                cin >> angle;
                s1->rotate(angle);
                s1->get();
                break;
            }
            case 4:
            {
                double deltaX, deltaY;
                cout << "" << endl;
                cout << "delta X = ";
                cin >> deltaX;
                cout << "delta Y = ";
                cin >> deltaY;
                s1->move(deltaX, deltaY);
                cout << "Новые координаты:\n";
                s1->get();
                break;
            }
            case 5:
            {
                cout << "S второй фигуры = " << s2->square() << endl;
                break;
            }
            case 6:
            {
                cout << "x = " << s2->centerOfGravity().x << "\ny = " << s2->centerOfGravity().y << endl;
                break;
            }
            case 7:
            {
                double angle;
                cin >> angle;
                s2->rotate(angle);
                s2->get();
                break;
            }
            case 8:
            {
                double deltaX, deltaY;
                cout << "" << endl;
                cout << "delta X = ";
                cin >> deltaX;
                cout << "delta Y = ";
                cin >> deltaY;
                s2->move(deltaX, deltaY);
                cout << "Новые координаты:\n";
                s2->get();
                break;
            }
            case 9:
            {
                int result = Operation::compare(s1, s2);
                if (result == 1)
                    cout << "S " << s1->ID << " > S " << s2->ID << endl;
                else
                {
                    if (result == 2)
                        cout << "S " << s1->ID << " < S " << s2->ID << endl;
                    else
                        cout << "S " << s1->ID << " = S " << s2->ID << endl;
                }
                break;
            }
            case 10:
            {
                if (Operation::isIntersect(s1, s2))
                    cout << "Фигуры пересекаются" << endl;
                else
                    cout << "Фигуры не пересекаются" << endl;
                break;
            }
            case 11:
            {
                if (Operation::isInclude(s1, s2))
                    cout << s1->ID << " включается в " << s2->ID << endl;
                else
                {
                    if (Operation::isInclude(s2,s1))
                        cout << s2->ID << " включается в " << s1->ID << endl;
                    else
                        cout << "Фигуры не включаются." << endl;
                }
                break;
            }
            case 12:
            {
                flag1 = false;
                break;
            }
            default:
                break;
            }
        }
    }
    if (s1) delete s1;//Освободить память 
    if (s2) delete s2;//Освободить память 
}