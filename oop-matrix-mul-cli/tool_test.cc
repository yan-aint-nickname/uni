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

    for (const auto &value : X.values) {
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
    for (auto &elem : Y.values) {
        elem = valCounter++ + 1;
    }

    std::optional<Vector> Z = X * Y;

    ASSERT_TRUE(Z.has_value());

    Vector R = Z.value();

    ASSERT_EQ(R.values[0], 5);
    ASSERT_EQ(R.values[1], 11);
}

UTEST(MatrixVectorVectorMul, MultipicationDefined) {
    int r = 2, c = 2;
    Matrix X(r, r);
    Matrix Y(r, c);
    Vector Z(c);

    int valCounter = 0;
    // Заполняем матрицу известными значениями {{1, 2}, {3, 4}}
    for (auto &row : X.values) {
        for (auto &elem : row) {
            elem = valCounter++ + 1;
        }
    }

    valCounter = 0;
    // Заполняем матрицу известными значениями {{1, 2}, {3, 4}}
    for (auto &row : Y.values) {
        for (auto &elem : row) {
            elem = valCounter++ + 1;
        }
    }

    valCounter = 0;
    // Заполняем вектор известными значениями {1, 2}
    for (auto &elem : Z.values) {
        elem = valCounter++ + 1;
    }

    std::optional<Vector> YZ = Y * Z;

    ASSERT_TRUE(YZ.has_value());
    ASSERT_EQ(YZ.value().values[0], 5);
    ASSERT_EQ(YZ.value().values[1], 11);

    std::optional<Vector> XYZ = X * YZ;

    ASSERT_TRUE(XYZ.has_value());

    ASSERT_EQ(XYZ.value().values[0], 27);
    ASSERT_EQ(XYZ.value().values[1], 59);
}

UTEST(MatrixVectorVectorMul, MultipicationDefinedSizeError) {
    int r = 2, c = 3;
    Matrix X(r, c);
    Matrix Y(r, c);
    Vector Z(c);

    int valCounter = 0;
    // Заполняем матрицу известными значениями {{1, 2, 3}, {4, 5, 6}}
    for (auto &row : X.values) {
        for (auto &elem : row) {
            elem = valCounter++ + 1;
        }
    }

    valCounter = 0;
    // Заполняем матрицу известными значениями {{1, 2, 3}, {4, 5, 6}}
    for (auto &row : Y.values) {
        for (auto &elem : row) {
            elem = valCounter++ + 1;
        }
    }

    valCounter = 0;
    // Заполняем вектор известными значениями {1, 2, 3}
    for (auto &elem : Z.values) {
        elem = valCounter++ + 1;
    }

    std::optional<Vector> YZ = Y * Z;

    ASSERT_TRUE(YZ.has_value());
    ASSERT_EQ(YZ.value().values[0], 14);
    ASSERT_EQ(YZ.value().values[1], 32);

    std::optional<Vector> XYZ = X * YZ;

    // Здесь я ожидаю, что выполнить умножение матрицы на вектор невозможно,
    // потому что кол-во столбцов матрицы не равно длине вектора
    ASSERT_FALSE(XYZ.has_value());
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
    for (auto &elem : D.values) {
        elem = 0;
    }

    // Выполняем алгоритм перемножения матрицы на вектор
    for (int i = 0; i < X.rows; i++) {
        for (int j = 0; j < X.columns; j++) {
            D.values[i] += X.values[i][j] * Y.values[j];
        }
    }

    Vector V = Z.value();

    int errCounter = 0;
    for (int i = 0; i < V.values.size(); i++) {
        int z = V.values[i];
        int d = D.values[i];

        if (z != d) {
            errCounter++;
        }
    }

    ASSERT_EQ(errCounter, 0);
}

UTEST_MAIN()
