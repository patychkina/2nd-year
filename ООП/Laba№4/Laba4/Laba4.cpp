#include <iostream>
#include <cstdio>
#include <string>
#include <vector>
#include <map>
#include <fstream>
#include <algorithm>
#include <Windows.h>
using namespace std;
//Класс ошибки
class MyException : public std::exception 
{
public:
    const char* what() const noexcept override 
    {
        return "Такой вариант отсутствует!";
    }
};

//Класс Библиотека
class Library
{
public:
	string Author;//Фамилия имя отчество автора
	string Title;//Назваие книги
	int Year = 0;//Год издания
	string Count;//Количество экземпляров
    static Library getBook(string line)//Метод получения данных о книге из строки
    {
        Library Book;
        string author, title, str_year, count, word;
        vector <string> words;
        int year;
        int i = 0;
        int size = line.size();
        count = "";
        year = 0;
        while (i != size)
        {
            if (line[i] != ' ')
                word += line[i];
            else
            {
                words.push_back(word);
                word = "";
            }
            i++;
        }
        words.push_back(word);
        Book.Author = words[0] + ' ' + words[1] + ' ' + words[2];
        for (int i = 3; i < words.size() - 2; i++)
            title += words[i] + " ";
        title.erase(title.size() - 1, 1);
        Book.Title = title;
        str_year = words[words.size() - 2];
        Book.Count = words[words.size() - 1];
        for (i = 0; i < str_year.size(); i++)
        {
            year = year * 10 + (str_year[i] - 48);
        }
        Book.Year = year;
        return Book;
    }
    bool operator<(const Library& other) 
    {
        // Сравниваем по фамилии, имени и отчеству
        if (Author != other.Author)
            return Author < other.Author;

        // Если фамилии, имена и отчества одинаковые, сравниваем по году
        if (Year != other.Year)
            return Year < other.Year;

        // Если года одинаковые, сравниваем по количеству
        return Count < other.Count;
    }
};

//Базовый класс
class Basic
{
public:
	virtual void addLibrary(Library& book) = 0;//Метод добавления книги в контейнер
	virtual vector<Library> find(string& author, int Year) = 0;//Метод поиска книги в контейнере
    virtual void sortLibrary() = 0;//Метод сортировки
    virtual  void displayLibrary() = 0;//Метод вывода всех книг библиотеки
    static void addToLibrary(Library& book)//Метод записи книги в файл
    {
        string empty = " ";
        string n = "\n";
        fstream out("Library.txt", ios::app);
        out << n << book.Author << empty << book.Title << empty << book.Year << empty << book.Count;
        out.close();
    }
	virtual ~Basic() {};//Деструктор
};

//Класс контейнера - вектор
class VectorLibrary : public Basic
{
private:
	vector <Library> Array;//Вектор книг
public:
    void addLibrary(Library& book) override//Метод добавления в вектор
    {
        Array.push_back(book);
    }
    vector<Library> find(string& author, int Year) override//Метод поиска по вектору
    {
        vector<Library> result;
        auto condition = [&author, Year](const Library& book) 
        {
            return book.Author == author && book.Year >= Year;
        };

        for (int i=0; i<Array.size();i++)
        {
            if (condition(Array[i]))
            {
                result.push_back(Array[i]);
            }
        }
        return result;
    }
    void sortLibrary() override // Реализация метода сортировки для вектора
    {
        sort(Array.begin(), Array.end());
    }
    void displayLibrary() override//Метод вывода данных из вектора
    {
        for (int i = 0; i < Array.size(); i++)
            cout << Array[i].Author << ' ' << Array[i].Title << ' ' << Array[i].Year << ' ' << Array[i].Count << endl;
    }

    ~VectorLibrary() {}//Деструктор
};

//Класс контейнера - словарь
class MapLibrary : public Basic
{
private:
	multimap <string, Library> Array;//Словарь книг
public:
    void addLibrary(Library& book) override//Метод добавления в словарь
    {
        Array.emplace(book.Author, book);
    }
    vector<Library> find(string& author, int Year) override//Метод поиска по словарю
    {
        auto range = Array.equal_range(author);
        vector<Library> result;
        auto condition = [Year](const pair<string, Library>& item) 
        {
            return item.second.Year >= Year;
        };
        for (auto it = range.first; it != range.second; ++it)
        {
            if (condition(*it))
            {
                result.push_back(it->second);
            }
        }
        return result;
    }
    void sortLibrary() override//Метод сортировки
    {
        vector<Library> tempVector;
        for (const auto& pair : Array)
        {
            tempVector.push_back(pair.second);
        }

        sort(tempVector.begin(), tempVector.end());

        Array.clear();
        for (const Library& book : tempVector)
        {
            Array.emplace(book.Author, book);
        }
    }
    void displayLibrary()//Метод вывода данных из словаря
    {
        for (auto i = Array.begin(); i != Array.end(); i++)
            cout << i->second.Author << ' ' << i->second.Title << ' ' << i->second.Year << ' ' << i->second.Count << endl;
    }
    ~MapLibrary() {}//Деструктор
};

//Класс создания контейнера
class Factory
{
public:
    static Basic* creat(char symbol)//Метод создания контейнера
    {
        try
        {
            if (symbol == 'V')
                return new VectorLibrary;
            else
            {
                if (symbol == 'M')
                    return new MapLibrary;
                else
                    throw MyException();
            }
        }
        catch (const std::exception& e)
        {
            cout << e.what();
            exit(0);
        }
    }
};

int main()
{
	setlocale(LC_ALL, "Russian");
    SetConsoleCP(1251);
    SetConsoleOutputCP(1251);
    string line, author, name, surname, secondname;
    char symbol;
    int command, year;
    bool flag = true;
    cout << "Выберите контейнер для работы:\n'V' - для работы с vector\n'M' - для работы с map/multimap" << endl;
    cin >> symbol;
    Basic* library = Factory::creat(symbol);
    Library Book;
    vector <Library> FindLibrary;
    fstream inFile("Library.txt");
    while (getline(inFile, line))
    {
        Book = Library::getBook(line);
        library->addLibrary(Book);
    }
    inFile.close();
    while (flag)
    {
        cout << "Меню программы:\n1)Добавить книгу в библиотеку\n2)Вывести сведения обо всех книгах заданного автора, начиная с заданного года издания\n3)Вывести сведения о всех книгах\n4)Выйти" << endl;
        cin >> command;
        switch (command)
        {
        case 1:
            cout << "Введите данные книги:\nФамилия Имя Отчество автора - ";
            getline(cin, line);
            getline(cin, Book.Author);
            cout << "Название книги - ";
            getline(cin, Book.Title);
            cout << "Год издания - ";
            cin >> Book.Year;
            cout << "Количество экземпляров данной книги в библиотеке - ";
            cin >> Book.Count;
            library->addLibrary(Book);
            Basic::addToLibrary(Book);
            break;
        case 2:
            cout << "Введите Фамилию Имя Отчество автора:" << endl;
            getline(cin, line);
            getline(cin, author);
            cout << "Введите год издания:" << endl;
            cin >> year;
            FindLibrary = library->find(author, year);
            cout << endl;
            if (FindLibrary.size() == 0)
                cout << "Нет книги, которая удовлетворяет вашим критериям." << endl;
            else
            {
                for (int i = 0; i < FindLibrary.size(); i++)
                    cout << FindLibrary[i].Author << ' ' << FindLibrary[i].Title << ' ' << FindLibrary[i].Year << ' ' << FindLibrary[i].Count << endl;
            }
            cout << endl;
            break;
        case 3:
            library->sortLibrary();
            library->displayLibrary();
            cout << endl;
            break;
        case 4:
            flag = false;
            break;
        default:
            cout << "Такой команды нет!" << endl;
            break;
        }
    }
}