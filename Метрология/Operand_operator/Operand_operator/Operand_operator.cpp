#include <iostream>
#include <fstream>
#include <unordered_map>
#include <regex>
#include <string>

using namespace std;

int main() {

    setlocale(LC_ALL, "Russian");
    // Создаем словари для операторов и операндов
    unordered_map<string, int> operators = {
        {"+", 0}, {"-", 0}, {"*", 0}, {"/", 0},
        {"=", 0}, {"<", 0}, {">", 0},{"<=", 0},
        {"++", 0}, {":", 0},{".", 0}, {",", 0}, 
        {";", 0}, {"(", 0}, {")", 0},{"{", 0}, 
        {"}", 0},{"<<", 0}, {">>", 0}, {"if", 0}, {"cout", 0}
    };

    unordered_map<string, int> operands = {
        {"factorial", 0}, {"f", 0}, {"count_matrix", 0},
        {"matrix", 0}, {"negative_count", 0}, {"negative_sum", 0},
        {"y_of_element", 0}, {"x", 0}, {"a", 0}, {"n", 0}, {"b", 0},
        {"m", 0}, {"c", 0}, {"k", 0}, {"y", 0}, {"f_table", 0},
        {"x_s", 0}, {"x_t", 0}, {"h", 0}, {"w", 0}, {"v", 0},
        {"S", 0}, {"ck", 0}, {"an", 0}, {"bm", 0},
        {"row", 0}, {"element", 0}, {"exp", 0}, {"pair", 0}
    };

    // Открываем файл с программой
    ifstream file("formula.cpp");
    if (!file.is_open()) {
        cout << "Ошибка открытия файла\n";
        return 1;
    }

    // Регулярные выражения для поиска операторов и операндов
    regex operatorRegex(R"(\b(if|cout)\b|\+\+|<<|>>|<=|[+\-*/=<>&|^?:.,;(){}])");
    regex operandRegex(R"(\b(factorial|f|count_matrix|matrix|negative_count|negative_sum|y_of_element|x|a|n|b|m|c|k|y|f_table|x_s|x_t|h|w|v|S|ck|an|bm|row|element|exp|pair)\b)");

    // Строка для считывания текущей строки из файла
    string line;
    int total_operators = 0;
    int total_operands = 0;
    int n = 0;
    int N = 0;
    // Считываем файл построчно
    while (getline(file, line)) {
        // Поиск операторов в текущей строке
        
        auto iter_operators = sregex_iterator(line.begin(), line.end(), operatorRegex);
        for (; iter_operators != sregex_iterator(); ++iter_operators) {
            string op = iter_operators->str();
            if (operators[op] == 0)
            {
                n++;
            }
            operators[op]++;
            total_operators++;
        }

        // Поиск операндов в текущей строке
        auto iter_operands = sregex_iterator(line.begin(), line.end(), operandRegex);
        for (; iter_operands != sregex_iterator(); ++iter_operands) {
            string operand = iter_operands->str();
            if (operands[operand] == 0)
            {
                n++;
            }
            operands[operand]++;
            total_operands++;
        }
    }

    // Вывод результатов
    cout << "Результаты анализа операторов:" << endl;
    for (const auto& op : operators) {
        cout << op.first << " : " << op.second << endl;
    }
    cout << "Всего операторов: " << total_operators << endl;
    cout << "\nРезультаты анализа операндов:" << endl;
    for (const auto& operand : operands) {
        cout << operand.first << " : " << operand.second << endl;
    }
    cout << "Всего операндов: " << total_operands << endl;
    N = total_operands + total_operators;
    double V = N * log2(n);
    cout << "Объем программы : " << V << endl;
}
