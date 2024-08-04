using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Laba_6
{
    public class Library
    {
        public string Author = "";//Фамилия имя отчество автора
        public string Title = "";//Название книги
        public int Year = 0;//Год издания
        public string Count = "";//Количество экземпляров

        //Метод получения данных о книге из строки
        public static Library GetBook(string line)
        {
            string[] words = line.Split(' ');
            Library book = new Library
            {
                Author = $"{words[0]} {words[1]} {words[2]}",
                Title = string.Join(" ", words.Skip(3).Take(words.Length - 5)),
                Year = int.Parse(words[words.Length - 2]),
                Count = words[words.Length - 1]
            };
            return book;
        }

        public override string ToString()
        {
            return Author + " " + Title + " " + Year + " " + Count;
        }

    }
}
