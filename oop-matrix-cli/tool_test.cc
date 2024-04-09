#include "tool.hh"
#include "vendor/utest.h"

UTEST(Matrix, fillWithRandomValuesLessThanMax) {
    int r = 5, c = 4;
    RandomMatrix X(r, c);

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

UTEST(Matrix, countGreaterThenGiven) {
    int r = 5, c = 4;
    RandomMatrix X(r, c);

    int maxValue = 10;
    X.fillWithValues(maxValue);

    int givenNumber = 5;

    // lte translates Less Than or Equal
    int lteCounter = 0;

    for (const auto &row : X.values) {
        for (int element : row) {
            if (element <= givenNumber) {
                lteCounter++;
            }
        }
    }
    // gt translates Greater Than
    int gtCounter = X.countGreaterThan(givenNumber);

    ASSERT_EQ(gtCounter, (r * c) - lteCounter);
}

UTEST_MAIN()
