#include "tool.hh"
#include <cstdlib>
#include <ctime>

int main() {
    // Инициализировать генератор псевдо-случайных чисел
    std::srand(static_cast<unsigned>(time(nullptr)));

    // Получить пользовательский ввод кол-во строк, столбцов, максимального
    // значения матрицы
    // Я не запрашиваю отдельно кол-во элементов вектора, чтобы
    // у вымышленного оператора не было возможности сделать умножение с ошибкой
    // Но обработку ошибки я сохранил см. строку №42
    int rowsAmount, columnsAmount, maxValue;
    int err = UserInput::Get(rowsAmount, columnsAmount, maxValue);

    // Завершить программу, если пользователь ввел некорректные данные
    if (err != 0) {
        return 1;
    }

    // Объявить матрицы A и B
    Matrix A(rowsAmount, columnsAmount);
    Vector B(columnsAmount);

    // Заполнить матрицу/вектор случайными числами
    A.fillWithValues(maxValue);
    B.fillWithValues(maxValue);

    // Вывод матриц для отладки
    std::cout << "Матрица:" << std::endl;
    std::cout << A << std::endl;
    std::cout << "Вектор:" << std::endl;
    std::cout << B << std::endl;

    std::optional<Vector> C = A * B;

    if (C.has_value()) {
        std::cout << "Результат перемножения:" << std::endl;
        std::cout << C.value() << std::endl;
    } else {
        std::cout << "Кол-во столбцов матрицы должны совпадать с кол-вом "
                     "элементов вектора"
                  << std::endl;
        return 1;
    }

    return 0;
}
