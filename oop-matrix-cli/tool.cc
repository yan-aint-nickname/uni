#include "tool.hh"
#include <cstdlib>
#include <iostream>

#ifdef DEBUG_VALUES
void BaseMatrix::printValues() {

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

void RandomMatrix::fillWithValues(int maxValue = 10) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
            // Случайные числа между 0 и maxValue
            values[i][j] = std::rand() % maxValue + 1;
        }
    }
}

int BaseMatrix::countGreaterThan(int value) {
    int count = 0;
    for (const auto &row : values) {
		int counted = std::count_if (row.begin(), row.end(), [value](int elem) { return elem > value; });
		count += counted;
    }
    return count;
}

int ConsoleUserInput::Get(int &D, int &Q, int &maxValue) {
    std::cout << "Введите максимальное число матрицы: ";
    std::cin >> maxValue;
    // Проверка на ошибку чтения ввода
    if (std::cin.fail()) {
        std::cout << "Введено не число " << std::endl;
        return 1;
    }

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
