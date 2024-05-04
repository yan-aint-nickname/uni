#include "tool.hh"
#include <algorithm>
#include <cstdlib>
#include <iostream>
#include <optional>

void Matrix::fillWithValues(int maxValue = 10) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
            // Случайные числа между 0 и maxValue включительно
            values[i][j] = std::rand() % (maxValue + 1);
        }
    }
}

void Vector::fillWithValues(int maxValue = 10) {
    // Случайные числа между 0 и maxValue включительно
    std::generate(
        (*this).values.begin(), (*this).values.end(),
        [maxValue]() mutable { return std::rand() % (maxValue + 1); });
}

std::optional<Vector> operator*(const Matrix &m, const Vector &v) {
    if (m.columns != v.values.size()) {
        return std::nullopt;
    }

    Vector res(m.rows);
    for (int i = 0; i < m.rows; i++) {
        for (int j = 0; j < m.columns; j++) {
            res.values[i] += m.values[i][j] * v.values[j];
        }
    }
    return res;
};

// Перегрузка оператора
std::optional<Vector> operator*(const Matrix &m,
                                const std::optional<Vector> &optV) {
    if (!optV.has_value()) {
        return std::nullopt;
    }
    return m * optV.value();
};

std::ostream &operator<<(std::ostream &stream, const Vector &v) {
    stream << std::endl;
    for (const auto &elem : v.values) {
        stream << elem << " ";
    }
    return stream << std::endl;
}

std::ostream &operator<<(std::ostream &stream, const Matrix &m) {
    stream << std::endl;
    for (const auto &row : m.values) {
        for (const auto &elem : row) {
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
