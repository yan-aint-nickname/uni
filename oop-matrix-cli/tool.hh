#include <vector>

#pragma once

using matrix = std::vector<std::vector<int>>;

class Matrix {
  private:
    int rows, columns;

  public:
    matrix values;

    Matrix(int rows, int columns) : rows(rows), columns(columns) {
        values.resize(rows, std::vector<int>(columns));
    }
    // Метод для заполнения матрицы случаными значениями
    void fillWithRandomValues(int maxValue);
    // Метод для подсчет кол-ва элементов больших, чем данное
    int countGreaterThan(int value);
    // Метод для вывода значений матрицы для отладки
#ifdef DEBUG_VALUES
    void printValues();
#endif
};

class UserInput {
  public:
    // Метод для получения данных от пользователя возвращает 1 если ошибка
    static int Get(int &D, int &Q, int &maxValue);
};
