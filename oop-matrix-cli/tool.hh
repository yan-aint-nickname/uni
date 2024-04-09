#pragma once
#include <vector>

using matrix = std::vector<std::vector<int>>;

class BaseMatrix {
  public:
    int rows, columns;
    matrix values;

    BaseMatrix() = delete;
    BaseMatrix(int rows, int columns) : rows(rows), columns(columns) {
        values.resize(rows, std::vector<int>(columns));
    }
    // Метод для подсчета кол-ва элементов больших, чем данное
    int countGreaterThan(int value);

    // Метод для вывода значений матрицы для отладки
    void printValues();
};

class RandomMatrix : public BaseMatrix {
    // Используем дефолтный конструктор BaseMatrix
    using BaseMatrix::BaseMatrix;

  public:
    // Метод для заполнения матрицы случаными значениями
    void fillWithValues(int maxValue);
};

class UserInputMatrix : public BaseMatrix {
  public:
    // Метод для заполнения матрицы значениями пользовательским вводом
    void fillWithValues(int maxValue);
};

// Базовый класс описывающий пользовательский воод
class BaseUserInput {
  public:
    // Здесь необходим виртуальный метод, чтобы "защитить"
    // разработчика от использования класса BaseUserInput
    virtual int Get(int &D, int &Q, int &maxValue) = 0;
};

// Класс описывающий пользовательский ввод с консоли
class ConsoleUserInput : public BaseUserInput {
  public:
    // Метод для получения данных от пользователя возвращает 1 если ошибка
    int Get(int &D, int &Q, int &maxValue) override;
};
