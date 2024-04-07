#include "tool.hh"
#include <cstdlib>
#include <ctime>
#include <iostream>

int main() {
    // Инициализировать генератор псевдо-случайных чисел
    std::srand(static_cast<unsigned>(time(0)));

    // Объявить матрицы A и B
    Matrix A(5, 8);
    Matrix B(7, 5);

    // Получить пользовательский ввод D и Q
    int D, Q, maxValue;
    int err = UserInput::Get(D, Q, maxValue);

    // Заполнить матрицы случаныйми числами
    A.fillWithRandomValues(maxValue);
    B.fillWithRandomValues(maxValue);

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
