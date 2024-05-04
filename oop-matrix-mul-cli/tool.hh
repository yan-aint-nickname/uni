#pragma once
#include <iostream>
#include <optional>
#include <vector>

using matrix = std::vector<std::vector<int>>;

// Предварительно краткое объявление
class Vector;

class Matrix {
  public:
    int rows, columns;
    matrix values;

    Matrix() = delete;
    Matrix(int rows, int columns) : rows(rows), columns(columns) {
        values.resize(rows, std::vector<int>(columns));
    }
    // Метод для заполнения матрицы значениями
    void fillWithValues(int maxValue);

    // Метод для скалярного произведения матрциы на вектор
    friend std::optional<Vector> operator*(const Matrix &m,
                                           const std::optional<Vector> &optV);
    friend std::optional<Vector> operator*(const Matrix &m, const Vector &v);

    // Метод для вывода матрицы в консоль
    friend std::ostream &operator<<(std::ostream &stream, const Matrix &m);
};

// Наследование от класса std::vector с типом данных int
class Vector {
    // Конструктор вектора
  public:
    std::vector<int> values;

    explicit Vector(int size) : values(size) {}

    // Метод для заполнения вектора значениями
    void fillWithValues(int maxValue);

    // Метод для вывода вектора в консоль
    friend std::ostream &operator<<(std::ostream &stream, const Vector &v);
};

// Класс описывающий пользовательский ввоод
class UserInput {
  public:
    // Метод для получения данных от пользователя возвращает 1 если ошибка
    int Get(int &rowsAmount, int &columnsAmount, int &maxValue);
};
