#include "vendor/cester.h"
#include "tool.h"


CESTER_BEFORE_ALL(test_instance,
		printf("Test started");
)

CESTER_MOCK_FUNCTION(fillWithRandomValues, matrix,
    Matrix A(5, 8);

	for (int i = 0; i < A.rows; i++) {
		for (int j = 0; j < A.columns; j++) {
			A[i][j] = 1
		}
	}
	return A
)

CESTER_TEST(check_mocked_function, test_instance,
        cester_assert_cmp_msg(10, >, 2, "is 10 greater than 2");
)
