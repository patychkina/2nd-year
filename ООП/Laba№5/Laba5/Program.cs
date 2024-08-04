using System.Text;
using System.Threading.Channels;

namespace Laba5
{
    //Класс ошибки
    class MyException : Exception
    {
        public override string Message => "Такой вариант отсутствует!";
    }

    //Класс Библиотека
    class Library
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
            return Author + " " + Title + " "+  Year + " " + Count;
        }
    }
    //Базовый класс
    abstract class Basic
    {
        abstract public void AddLibrary(ref Library book);//Метод добавления книги в коллекцию
        abstract public List<Library> Find(string author, int year);//Метод поиска книги в коллекции
        abstract public void DisplayLibrary();//Метод вывода всех книг библиотеки
    }
    //Класс контейнера - вектор
    class ListLibrary : Basic
    {
        private List<Library> array = new List<Library>();//Список книг

        public override void AddLibrary(ref Library book)//Метод добавления книги в коллекцию
        {
            array.Add(book);
        }

        public override List<Library> Find(string author, int year)//Метод поиска книги в коллекции
        {
            List<Library> result = new List<Library>();

            foreach (Library book in array)
            {
                if (book.Author == author && book.Year >= year)
                {
                    result.Add(book);
                }
            }

            return result;
        }

        public override void DisplayLibrary()//Метод вывода всех книг библиотеки
        {
            foreach (Library book in array)
            {
                Console.WriteLine(book);
            }
        }
    }
    //Класс контейнера - словарь
    class DictionaryLibrary : Basic
    {
      private SortedDictionary<string, List<Library>> array = new SortedDictionary<string, List<Library>>();

        public override void AddLibrary(ref Library book)//Метод добавления книги в коллекцию
        {
            if (!array.ContainsKey(book.Author))
            {
                array[book.Author] = new List<Library>();
            }
            array[book.Author].Add(book);
        }

        public override List<Library> Find(string author, int year)//Метод поиска книги в коллекции
        {
            List<Library> result = new List<Library>();

            foreach (var pair in array)
            {
                foreach (Library book in pair.Value)
                {
                    if (book.Year >= year)
                    {
                        result.Add(book);
                    }
                }
            }
            return result;
        }


        public override void DisplayLibrary()//Метод вывода всех книг библиотеки
        {
            foreach (List<Library> books in array.Values)
            {
                foreach (Library book in books)
                {
                    Console.WriteLine(book);
                }
            }
        }
    }
    //Класс создания контейнера
    class Factory
    {
        public static Basic Create(char symbol)//Метод создания коллекции
        {
            try
            {
                if (symbol == 'V')
                    return new ListLibrary();
                else
                {
                    if (symbol == 'M')
                        return new DictionaryLibrary();
                    else
                        throw new MyException();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                Environment.Exit(0);
                return null;
            }
        }
    }

    internal class Program
    {
        static void Main()
        {
            Console.OutputEncoding = Encoding.UTF8;
            string ? line;
            char symbol;
            int command, year;
            bool flag = true;

            Console.WriteLine("Выберите контейнер для работы:\n'V' - для работы с vector\n'M' - для работы с map/multimap");
            symbol = Console.ReadKey().KeyChar;
            Console.WriteLine();
            Basic library = Factory.Create(symbol);
            Library book = new Library();
            List<Library> findLibrary;

            
            using (StreamReader reader = new StreamReader("Library.txt", Encoding.UTF8))
            {
                // Читаем и выводим содержимое файла построчно
                while ((line = reader.ReadLine()) != null)
                {
                    Console.WriteLine(line);
                    book = Library.GetBook(line);
                    library.AddLibrary(ref book);
                }
            }
            while (flag)
            {
                Console.WriteLine("Меню программы:\n1)Добавить книгу в библиотеку\n2)Вывести сведения обо всех книгах заданного автора, начиная с заданного года издания\n3)Вывести сведения о всех книгах\n4)Выйти");
                command = Convert.ToInt32(Console.ReadLine());
                switch (command)
                {
                    case 1:
                        Console.Write("Введите данные книги:\nФамилия Имя Отчество автора - ");
                        string ? Author = Console.ReadLine();
                        if (Author != null)
                        {
                            book.Author = Author;
                        }
                        Console.Write("Название книги - ");
                        string? Title = Console.ReadLine();
                        if (Title != null)
                        {
                            book.Title = Title;
                        }
                        Console.Write("Год издания - ");
                        book.Year = Convert.ToInt32(Console.ReadLine());
                        Console.Write("Количество экземпляров данной книги в библиотеке - ");
                        string? Count = Console.ReadLine();
                        if (Count != null)
                        {
                            book.Count = Count;
                        }
                        library.AddLibrary(ref book);
                        break;
                    case 2:
                        Console.Write("Введите Фамилию Имя Отчество автора: ");
                        Author = Console.ReadLine();
                        if (Author != null)
                        {
                            book.Author = Author;
                        }
                        Console.Write("Введите год издания: ");
                        year = Convert.ToInt32(Console.ReadLine());
                        Console.WriteLine();
                        if (Author != null)
                        {
                            findLibrary = library.Find(Author, year);
                            if (findLibrary.Count == 0)
                                Console.WriteLine("Нет книги, которая удовлетворяет вашим критериям.");
                            else
                            {
                                foreach (Library book_to in findLibrary)
                                    Console.WriteLine(book_to);
                            }
                            Console.WriteLine();
                        }
                        break;
                    case 3:
                        Console.WriteLine();
                        library.DisplayLibrary();
                        Console.WriteLine();
                        break;
                    case 4:
                        flag = false;  
                        break;  
                    default:
                        Console.WriteLine("Такой команды нет!");
                        flag = false;
                        break; 

                }
            }
        }
    }
}