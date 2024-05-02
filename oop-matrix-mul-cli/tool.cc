#include "tool.hh"
#include <cstdlib>
#include <iostream>
#include <optional>

void Matrix::fillWithValues(int maxValue = 10) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
            // Случайные числа между 0 и maxValue включительно
            values[i][j] = std::rand() % maxValue + 1;
        }
    }
}

void Vector::fillWithValues(int maxValue = 10) {
    for (auto &value : *this) {
        // Случайные числа между 0 и maxValue включительно
        value = std::rand() % maxValue + 1;
    }
}

std::optional<Vector> operator*(const Matrix &m, const Vector &v) {
    if (m.columns != v.size()) {
        return std::nullopt;
    }

    Vector res(m.rows);
    for (int i = 0; i < m.rows; i++) {
        for (int j = 0; j < v.size(); j++) {
            res[i] += m.values[i][j] * v[j];
        }
    }
    return res;
};

std::ostream &operator<<(std::ostream &stream, const Vector &v) {
    stream << std::endl;
    for (auto &elem : v) {
        stream << elem << " ";
    }
    return stream << std::endl;
}

std::ostream &operator<<(std::ostream &stream, const Matrix &m) {
    stream << std::endl;
    for (auto &row : m.values) {
        for (auto &elem : row) {
            stream << elem << " ";
        }
        stream << std::endl;
    }
    return stream << std::endl;
}

int UserInput::Get(int &rowsAmount, int &columnsAmount, int &maxValue) {
    std::cout << "Введите кол-во строк матрицы: ";
    std::cin >> rowsAmount;
    // Проверка на ошибку чтения ввода
    if (std::cin.fail()) {
        std::cout << "Введено не число " << std::endl;
        return 1;
    }
    std::cout << "Введите кол-во стобцов матрицы: ";
    std::cin >> columnsAmount;
    // Проверка на ошибку чтения ввода
    if (std::cin.fail()) {
        std::cout << "Введено не число " << std::endl;
        return 1;
    }

    std::cout << "Введите максимальное число матрицы: ";
    std::cin >> maxValue;
    // Проверка на ошибку чтения ввода
    if (std::cin.fail()) {
        std::cout << "Введено не число " << std::endl;
        return 1;
    }
    return 0;
}
