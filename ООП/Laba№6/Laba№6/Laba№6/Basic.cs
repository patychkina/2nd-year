using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Laba_6
{
    //Базовый класс
    public abstract class Basic
    {
        abstract public void AddLibrary( Library book);//Метод добавления книги в коллекцию
        abstract public void Find(string author, int year, TextBox t);//Метод поиска книги в коллекции
        abstract public void DisplayLibrary(TextBox text);//Метод вывода всех книг библиотеки
    }
    //Класс контейнера - список
    public class ListLibrary : Basic
    {
        private List<Library> array = new List<Library>();//Список книг

        public override void AddLibrary( Library book)//Метод добавления книги в коллекцию
        {
            array.Add(book);
        }

        public override void Find(string author, int year, TextBox t)//Метод поиска книги в коллекции
        {
            foreach (Library book in array)
            {
                if (book.Author == author && book.Year >= year)
                {
                    t.Text += book.ToString() + "\r\n";
                }
            }
        }

        public override void DisplayLibrary(TextBox t)//Метод вывода всех книг библиотеки
        {
            for (int i=0; i<array.Count; i++)
            {
                t.Text += array[i].ToString() + "\r\n";
            }
        }
    }
    //Класс контейнера - словарь
    public class DictionaryLibrary : Basic
    {
        private SortedDictionary<string, List<Library>> array = new SortedDictionary<string, List<Library>>();

        public override void AddLibrary( Library book)//Метод добавления книги в коллекцию
        {
            if (!array.ContainsKey(book.Author))
            {
                array[book.Author] = new List<Library>();
            }
            array[book.Author].Add(book);
        }

        public override void Find(string author, int year, TextBox t)//Метод поиска книги в коллекции
        {
            foreach (var pair in array)
            {
                foreach (Library book in pair.Value)
                {
                    if (book.Year >= year && book.Author == author)
                    {
                        t.Text += book.ToString() + "\r\n";
                    }
                }
            }
        }

        public override void DisplayLibrary(TextBox t)//Метод вывода всех книг библиотеки
        {
            foreach (List<Library> books in array.Values)
            {
                foreach (Library book in books)
                {
                    t.Text += book.ToString() + "\r\n";
                }
            }
        }

        
    }
}
