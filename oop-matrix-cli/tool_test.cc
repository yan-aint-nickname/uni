#include "vendor/utest.h"
#include "tool.hh"


UTEST(values, less) {
	int r = 5, c = 4;
	Matrix X(r, c);

	int maxValue = 2;
	X.fillWithRandomValues(maxValue);
	
	int biggerCounter = 0;

	for (const auto &row : X.values) {
        for (int element : row) {
            if (element > maxValue) {
                biggerCounter++;
				break;
            }
        }
		if (biggerCounter > 0) break; 
    }
  	ASSERT_EQ(biggerCounter, 0);
}

UTEST_MAIN()
