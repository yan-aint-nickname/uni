#include "tool.hh"
#include <cstdlib>
#include <ctime>
#include <iostream>

#ifdef DEBUG_VALUES
void Matrix::printValues() {

    std::cout << std::endl;
    for (const auto &row : values) {
        for (int element : row) {
            std::cout << element << " ";
        }
        std::cout << std::endl;
    }
    std::cout << std::endl;
}
#endif

void Matrix::fillWithRandomValues() {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
            values[i][j] = std::rand() % 10; // Случайные числа между 0 и 9
        }
    }
}

int Matrix::countGreaterThan(int value) {
    int count = 0;
    for (const auto &row : values) {
        for (int element : row) {
            if (element > value) {
                count++;
            }
        }
    }
    return count;
}

int UserInput::Get(int &D, int &Q) {
    std::cout << "Введите число D: ";
    std::cin >> D;
    // Проверка на ошибку чтения ввода
    if (std::cin.fail()) {
        std::cout << "Введено не число " << std::endl;
        return 1;
    }

    std::cout << "Введите число Q: ";
    std::cin >> Q;
    // Проверка на ошибку чтения ввода
    if (std::cin.fail()) {
        std::cout << "Введено не число " << std::endl;
        return 1;
    }
    return 0;
}

int main() {
    // Инициализировать генератор псевдо-случайных чисел
    std::srand(static_cast<unsigned>(time(0)));

    // Объявить матрицы A и B
    Matrix A(5, 8);
    Matrix B(7, 5);

    // Заполнить матрицы случаныйми числами
    A.fillWithRandomValues();
    B.fillWithRandomValues();

    // Получить пользовательский ввод D и Q
    int D, Q;
    int err = UserInput::Get(D, Q);

    // Завершить программу, если пользователь ввел некорректные данные
    if (err != 0) {
        return 1;
    }

    // Посчитать кол-во элементов матрицы A больше D
    int countA = A.countGreaterThan(D);
    // Посчитать кол-во элементов матрицы B больше Q
    int countB = B.countGreaterThan(Q);

    // Флаг препроцессора -DDEBUG_VALUES
#ifdef DEBUG_VALUES
    A.printValues();
    B.printValues();
#endif

    // Вывести кол-во элементов матрицы A больше чем D
    // Вывести кол-во элементов матрицы B больше чем Q
    char buf[256];
    int str_size =
        snprintf(buf, sizeof(buf),
                 "Кол-во элементов матрицы A больше чем D = %d : %d\nКол-во "
                 "элементов матрицы B больше чем Q = %d : %d\n",
                 D, countA, Q, countB);

    std::string str = "Ошибка форматирования вывода";
    if (str_size >= 0 && str_size < sizeof(buf)) {
        str = buf;
    }
    // Делаем системный вызов вывод в консоль 1 раз
    std::cout << str;

    return 0;
}
