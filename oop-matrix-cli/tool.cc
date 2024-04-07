#include "tool.hh"
#include <cstdlib>
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

void Matrix::fillWithRandomValues(int maxValue = 10) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
            // Случайные числа между 0 и maxValue
            values[i][j] = std::rand() % maxValue + 1;
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

int UserInput::Get(int &D, int &Q, int &maxValue) {
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
