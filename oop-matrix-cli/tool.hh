#include <vector>

using matrix = std::vector<std::vector<int> >;

#ifndef __MATRIX_h_
#define __MATRIX_h_
class Matrix {
  private:
    matrix values;
    int rows, columns;

  public:
    Matrix(int rows, int columns) : rows(rows), columns(columns) {
        values.resize(rows, std::vector<int>(columns));
    }
    // Метод для заполнения матрицы случаными значениями
    void fillWithRandomValues();
    // Метод для подсчет кол-ва элементов больших, чем данное
    int countGreaterThan(int value); 
	// Метод для вывода значений матрицы для отладки
#ifdef DEBUG_VALUES
	void printValues();
#endif
};
#endif  // __MATRIX_h_

#ifndef USER_INPUT_h_
#define USER_INPUT_h_
class UserInput {
  public:
    // Метод для получения данных от пользователя возвращает 1 если ошибка
    static int Get(int &D, int &Q); 
};
#endif  // USER_INPUT_h_
