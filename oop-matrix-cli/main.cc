#include <cstdlib>
#include <ctime>
#include <iostream>
#include <vector>

using matrix = std::vector<std::vector<int>>;

class Matrix {
  private:
    matrix values;
    int rows, columns;

  public:
    Matrix(int rows, int columns) : rows(rows), columns(columns) {
        values.resize(rows, std::vector<int>(columns));
    }

    // Метод для заполнения матрицы случаными значениями
    void fillWithRandomValues() {
        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < columns; ++j) {
                values[i][j] =
                    std::rand() % 100; // Случайные числа между 0 и 99
            }
        }
    }

    // Метод для подсчет кол-ва элементов больших, чем данное
    int countGreaterThan(int value) {
        int count = 0;
        for (const auto &row : values) {
            for (int element : row) {
                if (element > value) {
                    ++count;
                }
            }
        }
        return count;
    }
};

class UserInput {
  public:
    // Метод для получения данных от пользователя возвращает 1 если ошибка
    static int getInput(int &D, int &Q) {
        std::cout << "Введите число D: ";
        std::cin >> D;
        if (std::cin.fail()) {
            std::cout << "Not a number " << std::endl;
            return 1;
        }

        std::cout << "Введите число Q: ";
        std::cin >> D;
        if (std::cin.fail()) {
            std::cout << "Not a number " << std::endl;
            return 1;
        }
        return 0;
    }
};

int main() {
    std::srand(
        static_cast<unsigned>(time(0))); // Генератор псевдо-случайных чисел

    // Объявить матрицы A и B
    Matrix A(5, 8);
    Matrix B(7, 5);

    // Заполнить матрицы случаныйми числами
    A.fillWithRandomValues();
    B.fillWithRandomValues();

    // Получить пользовательский ввод D и Q
    int D, Q;
    int err = UserInput::getInput(D, Q);

    if (err != 0) {
        return 1;
    }

    // Посчитать и вывести кол-во элементов матрицы A больше D
    int countA = A.countGreaterThan(D);
    std::cout << "Кол-во элементов матрицы A больше чем D = " << D << ": "
              << countA << std::endl;

    // Посчитать и вывести кол-во элементов матрицы B больше Q
    int countB = B.countGreaterThan(Q);
    std::cout << "Кол-во элементов матрицы B больше чем Q = " << Q << ": "
              << countB << std::endl;

    return 0;
}
