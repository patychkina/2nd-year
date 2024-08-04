using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;

namespace Laba_6
{
    public partial class Form1 : Form
    {
        public string line;
        public Library book = new Library();
        public List<Library> findLibrary;
        public Basic library;
        public Form1()
        {
            InitializeComponent();
        }
        //Работа с коллекцией - список
        private void button1_Click(object sender, EventArgs e)
        {
            library = new ListLibrary();//Список книг
            using (StreamReader reader = new StreamReader("Library.txt", Encoding.UTF8))
            {
                // Читаем и выводим содержимое файла построчно
                while ((line = reader.ReadLine()) != null)
                {
                    book = Library.GetBook(line);
                    library.AddLibrary( book);
                }
            }
            Form2 f = new Form2(library);
            f.ShowDialog();
        }
        //Работа с коллекцией - словарь
        private void button2_Click(object sender, EventArgs e)
        {
            library = new DictionaryLibrary();//Словарь книг
            using (StreamReader reader = new StreamReader("Library.txt", Encoding.UTF8))
            {
                // Читаем и выводим содержимое файла построчно
                while ((line = reader.ReadLine()) != null)
                {
                    Console.WriteLine(line);
                    book = Library.GetBook(line);
                    library.AddLibrary(book);
                }
            }
            Form2 f = new Form2(library);
            f.ShowDialog();
        }
    }
}
