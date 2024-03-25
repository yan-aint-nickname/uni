#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>

using matrix = std::vector<std::vector<int>>;

// Функция(Процедура) для заполнения матрицы случаными значениями
void fillMatrix(matrix &values, int rows, int cols) {
    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            values[i][j] = std::rand() % 100; // Случайные числа между 0 и 99
        }
    }
}

// Фнукция для подсчет кол-ва элементов больших, чем данное
int countGreaterThan(const matrix &values, int value) {
    int count = 0;
    for (const auto &row: values) {
        for (int element: row) {
            if (element > value) {
                ++count;
            }
        }
    }
    return count;
}

// Функция(Процедура) для получения данных от пользователя
void getUserInput(int &D, int &Q) {
    std::cout << "Введите число D: ";
    std::cin >> D;
    std::cout << "Введите число Q: ";
    std::cin >> Q;
}

int main() {
    std::srand(static_cast<unsigned>(time(0))); // Генератор псевдо-случайных чисел

    // Объявить матрицы A и B
    matrix A(5, std::vector<int>(8));
    matrix B(7, std::vector<int>(5));

    // Заполнить матрицы случаныйми числами
    fillMatrix(A, 5, 8);
    fillMatrix(B, 7, 5);

    // Получить пользовательский ввод D и Q
    int D, Q;
    getUserInput(D, Q);

    // Посчитать и вывести кол-во элементов матрицы A больше D
    int countA = countGreaterThan(A, D);
    std::cout << "Кол-во элементов матрицы A больше чем D = " << D << ": " << countA << std::endl;

    // Посчитать и вывести кол-во элементов матрицы B больше Q
    int countB = countGreaterThan(B, Q);
    std::cout << "Кол-во элементов матрицы B больше чем Q = " << Q << ": " << countB << std::endl;

    return 0;
}
