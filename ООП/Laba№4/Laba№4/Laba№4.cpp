#include <iostream>
#include <cstdio>
#include <string>
#include <vector>
#include <map>
#include <fstream>
#include <Windows.h>
using namespace std;

class MyException : public std::exception {
public:
    const char* what() const noexcept override {
        return "Такой вариант отсутствует!";
    }
};

class Library
{
public:
    string Author;//Фамилия имя отчество автора
    string Title;//Назваие книги
    int Year = 0;//Год издания
    string Count;//Количество экземпляров
    static Library getBook(string line)
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
};

class Basic
{
public:
    virtual void addLibrary(Library& book) = 0;
    virtual vector<Library> find(string& author, int Year) = 0;
    virtual  void displayLibrary() = 0;
    virtual ~Basic() {};
};

class VectorLibrary : public Basic
{
private:
    vector <Library> Array;
public:
    void addLibrary(Library& book) override
    {
        Array.push_back(book);
    }
    vector<Library> find(string& author, int Year) override
    {
        vector<Library> result;
        for (int i = 0; i < Array.size(); i++)
        {
            if (Array[i].Author == author && Array[i].Year >= Year)
            {
                result.push_back(Array[i]);
            }
        }
        return result;
    }
    void displayLibrary() override
    {
        for (int i = 0; i < Array.size(); i++)
            cout << Array[i].Author << ' ' << Array[i].Title << ' ' << Array[i].Year << ' ' << Array[i].Count << endl;
    }

    ~VectorLibrary() {}
};

class MapLibrary : public Basic
{
private:
    multimap <string, Library> Array;
public:
    void addLibrary(Library& book) override
    {
        Array.emplace(book.Author, book);
    }
    vector<Library> find(string& author, int Year) override
    {
        auto range = Array.equal_range(author);
        vector<Library> result;
        for (auto it = range.first; it != range.second; ++it)
        {
            if (it->second.Year >= Year)
            {
                result.push_back(it->second);
            }
        }
        return result;
    }
    void displayLibrary()
    {
        for (auto i = Array.begin(); i != Array.end(); i++)
            cout << i->second.Author << ' ' << i->second.Title << ' ' << i->second.Year << ' ' << i->second.Count << endl;
    }
    ~MapLibrary() {}
};

class Factory
{
public:
    static Basic* creat(char symbol)
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
            getline(cin, line);
            getline(cin, Book.Title);
            cout << "Год издания - ";
            cin >> Book.Year;
            cout << "Количество экземпляров данной книги в библиотеке - ";
            cin >> Book.Count;
            library->addLibrary(Book);
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