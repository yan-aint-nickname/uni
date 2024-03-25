#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>

using matrix = std::vector<std::vector<int>>;

// Функция(Процедура) для заполнения матрицы рандомными значениями
void fillMatrix(matrix &values, int rows, int cols) {
    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            values[i][j] = std::rand() % 100; // Random values between 0 and 99
        }
    }
}

// Фнукция для подсчет кол-ва элементов больших, чем данное
int countGreaterThan(const matrix &values, int value) {
    int count = 0;
    for (const auto& row: values) {
        for (int element: row) {
            if (element > value) {
                ++count;
            }
        }
    }
    return count;
}

// Функция(Процедура) для получения данных от пользователя
void getUserInput(int &D, int &Q) {
    std::cout << "Введите число D: ";
    std::cin >> D;
    std::cout << "Введите число Q: ";
    std::cin >> Q;
}

int main() {
	std::srand(static_cast<unsigned>(time(0))); // Seed random number generator

    // Define matrices A and B
    matrix A(5, std::vector<int>(8));
    matrix B(7, std::vector<int>(5));

    // Fill matrices with random values
    fillMatrix(A, 5, 8);
    fillMatrix(B, 7, 5);

    // Get input values D and Q
    int D, Q;
    getUserInput(D, Q);

    // Count and print elements greater than D in matrix A
    int countA = countGreaterThan(A, D);
    std::cout << "Number of elements in matrix A greater than " << D << ": " << countA << std::endl;

    // Count and print elements greater than Q in matrix B
    int countB = countGreaterThan(B, Q);
    std::cout << "Number of elements in matrix B greater than " << Q << ": " << countB << std::endl;

    return 0;
}
