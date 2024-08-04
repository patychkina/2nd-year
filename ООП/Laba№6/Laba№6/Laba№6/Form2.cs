using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Laba_6
{
    public partial class Form2 : Form
    {
        public Basic library;
        public ListLibrary result;
        public Form2(Basic library_1)
        {
            InitializeComponent();
            library = library_1;
        }
        //Вывод данных обо всех книгах
        private void button1_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            library.DisplayLibrary(textBox1);
        }
        //Вывести данные по книгам писателя с определенного года
        private void button2_Click(object sender, EventArgs e)
        {
            string author = textBox2.Text;
            string year = textBox3.Text;
            int year_1 = Convert.ToInt32(year);
            textBox1.Clear();
            library.Find(author, year_1, textBox1);
        }
        //Очистить поле
        private void click_textBox2(object sender, EventArgs e)
        {
            textBox2.Clear();
        }
        //Очистить поле
        private void click_textBox3(object sender, EventArgs e)
        {
            textBox3.Clear();
        }
        //Очистить поле
        private void click_textBox4(object sender, EventArgs e)
        {
            textBox4.Clear();
        }
        //Очистить поле
        private void click_textBox5(object sender, EventArgs e)
        {
            textBox5.Clear();
        }
        //Очистить поле
        private void click_textBox6(object sender, EventArgs e)
        {
            textBox6.Clear();
        }
        //Очистить поле
        private void click_textBox7(object sender, EventArgs e)
        {
            textBox7.Clear();
        }
        //Добавить книгу
        private void button3_Click(object sender, EventArgs e)
        {
            Library book = new Library();
            book.Author = textBox4.Text;
            book.Title = textBox5.Text;
            string year = textBox6.Text;
            book.Count = textBox7.Text;
            book.Year = Convert.ToInt32(year);
            library.AddLibrary(book);
        }
        //Вернуть все в исходное положение
        private void button4_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            textBox2.Clear();
            textBox2.Text = "Введите ФИО автора";
            textBox3.Clear();
            textBox3.Text = "Введите год издания";
            textBox4.Clear();
            textBox4.Text = "Введите ФИО автора";
            textBox5.Clear();
            textBox5.Text = "Введите название книги";
            textBox6.Clear();
            textBox6.Text = "Введите год издания";
            textBox7.Clear();
            textBox7.Text = "Введите количество экземпляров";
        }
    }
}
