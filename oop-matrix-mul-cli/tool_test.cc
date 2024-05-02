#include "tool.hh"
#include "vendor/utest.h"

UTEST(Matrix, fillWithRandomValuesLessThanMax) {
    int r = 5, c = 4;
    Matrix X(r, c);

    int maxValue = 2;
    X.fillWithValues(maxValue);

    int greaterCounter = 0;

    for (const auto &row : X.values) {
        for (int element : row) {
            if (element > maxValue) {
                greaterCounter++;
                break;
            }
        }
        if (greaterCounter > 0)
            break;
    }
    ASSERT_EQ(greaterCounter, 0);
}

UTEST(Vector, fillWithRandomValuesLessThanMax) {
    int r = 5;
    Vector X(r);

    int maxValue = 2;
    X.fillWithValues(maxValue);

    int greaterCounter = 0;

    for (const auto &value : X) {
        if (value > maxValue) {
            greaterCounter++;
            break;
        }
        if (greaterCounter > 0)
            break;
    }
    ASSERT_EQ(greaterCounter, 0);
}

UTEST(MatrixVectorMul, ResultVectorSizeError) {
    Matrix X(5, 4);
    Vector Y(5);

    int maxValue = 10;
    X.fillWithValues(maxValue);
    Y.fillWithValues(maxValue);

    std::optional<Vector> Z = X * Y;

    ASSERT_FALSE(Z.has_value());
}

UTEST(MatrixVectorMul, MultipicationDefined) {
    int r = 2, c = 2;
    Matrix X(r, c);
    Vector Y(c);

    int valCounter = 0;
    // Заполняем матрицу известными значениями {{1, 2}, {3, 4}}
    for (auto &row : X.values) {
        for (auto &elem : row) {
            elem = valCounter++ + 1;
        }
    }

    valCounter = 0;
    // Заполняем вектор известными значениями {1, 2}
    for (auto &elem : Y) {
        elem = valCounter++ + 1;
    }

    std::optional<Vector> Z = X * Y;

    ASSERT_TRUE(Z.has_value());

    Vector R = Z.value();

    ASSERT_EQ(R[0], 5);
    ASSERT_EQ(R[1], 11);
}

UTEST(MatrixVectorMul, MultipicationRandom) {
    int r = 5, c = 4;
    Matrix X(r, c);
    Vector Y(c);

    int maxValue = 10;
    X.fillWithValues(maxValue);
    Y.fillWithValues(maxValue);

    std::optional<Vector> Z = X * Y;

    ASSERT_TRUE(Z.has_value());
    Vector D(c);

    // Заполняем тестовую матрицу нулями
    for (auto &elem : D) {
        elem = 0;
    }

    // Выполняем алгоритм перемножения матрицы на вектор
    for (int i = 0; i < X.rows; i++) {
        for (int j = 0; j < X.columns; j++) {
            D[i] += X.values[i][j] * Y[j];
        }
    }

    Vector V = Z.value();

    int errCounter = 0;
    for (int i = 0; i < V.size(); i++) {
        int z = V[i];
        int d = D[i];

        if (z != d) {
            errCounter++;
        }
    }

    ASSERT_EQ(errCounter, 0);
}

UTEST_MAIN()
