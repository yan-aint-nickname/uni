import pytest
from lib import (
    bubble_sort,
    new_matrixies_from_original,
    replace_rows_and_columns_from_matrix_by_indexes,
)


def test_bubble_sort():
    seq = [1, 2, 4, 5, 0]
    s = bubble_sort(seq)
    assert sorted(seq) == s.seq
    assert s.pos == [4, 0, 1, 2, 3]

    seq2 = [1, 0, 3, 2, 4]
    s2 = bubble_sort(seq2)
    assert sorted(seq2) == s2.seq
    assert s2.pos == [1, 0, 3, 2, 4]

    seq3 = [1, 0, 3, 2, 0]
    s3 = bubble_sort(seq3)
    assert sorted(seq3) == s3.seq
    assert s3.pos == [1, 4, 0, 3, 2]


@pytest.fixture()
def matrix_source():
    return [
        [0, 10, 24, 21, 45, 65, 60, 55, 100],
        [10, 0, 15, 11, 35, 55, 50, 48, 90],
        [24, 15, 0, 25, 50, 70, 75, 60, 100],
        [21, 11, 25, 0, 25, 45, 40, 35, 60],
        [45, 35, 50, 25, 0, 40, 30, 26, 70],
        [65, 55, 70, 45, 40, 0, 12, 30, 40],
        [60, 50, 75, 40, 30, 12, 0, 18, 28],
        [55, 48, 60, 35, 26, 30, 18, 0, 40],
        [100, 90, 100, 60, 70, 40, 28, 40, 0],
    ]


@pytest.fixture()
def matrix_ordered():
    return [
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [10, 10, 15, 11, 25, 12, 12, 18, 28],
        [21, 11, 24, 21, 26, 30, 18, 26, 40],
        [24, 15, 25, 25, 30, 40, 28, 30, 40],
        [45, 35, 50, 25, 35, 40, 30, 35, 60],
        [55, 48, 60, 35, 40, 45, 40, 40, 70],
        [60, 50, 70, 40, 45, 55, 50, 48, 90],
        [65, 55, 75, 45, 50, 65, 60, 55, 100],
        [100, 90, 100, 60, 70, 70, 75, 60, 100],
    ]


@pytest.fixture()
def matrix_number():
    return [
        [0, 1, 2, 3, 4, 5, 6, 7, 8],
        [1, 0, 1, 1, 3, 6, 5, 6, 6],
        [3, 3, 0, 0, 7, 7, 7, 4, 5],
        [2, 2, 3, 2, 6, 4, 8, 5, 7],
        [4, 4, 4, 4, 1, 8, 4, 3, 3],
        [7, 7, 7, 7, 5, 3, 3, 8, 4],
        [6, 6, 5, 6, 0, 1, 1, 1, 1],
        [5, 5, 6, 5, 2, 0, 0, 0, 0],
        [8, 8, 8, 8, 8, 2, 2, 2, 2],
    ]


@pytest.fixture()
def matrix_total():
    return [
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [10, 10, 15, 11, 25, 12, 12, 18, 28],
        [31, 21, 39, 32, 51, 42, 30, 44, 68],
        [55, 36, 64, 57, 81, 82, 58, 74, 108],
        [100, 71, 114, 82, 116, 122, 88, 109, 168],
        [155, 119, 174, 117, 156, 167, 128, 149, 238],
        [215, 169, 244, 157, 201, 222, 178, 197, 328],
        [280, 224, 319, 202, 251, 287, 238, 252, 428],
        [380, 314, 419, 262, 321, 357, 313, 312, 528],
    ]


@pytest.fixture()
def matrix_source_without_idxs():
    return [
        [0, 50, 70, 75, 60, 100],
        [50, 0, 40, 30, 26, 70],
        [70, 40, 0, 12, 30, 40],
        [75, 30, 12, 0, 18, 28],
        [60, 26, 30, 18, 0, 40],
        [100, 70, 40, 28, 40, 0],
    ]


def test_new_matrixies_from_original(
    matrix_source, matrix_ordered, matrix_number, matrix_total
):
    _M, Mk, Mc = new_matrixies_from_original(matrix_source)
    assert _M == matrix_ordered
    assert Mk == matrix_number
    assert Mc == matrix_total


@pytest.mark.parametrize("idxs", ([0, 1, 3],))
def test_replace_rows_and_columns_from_matrix_by_indexes(
    matrix_source,
    matrix_source_without_idxs,
    idxs,
):
    assert matrix_source_without_idxs == replace_rows_and_columns_from_matrix_by_indexes(
        matrix_source, idxs
    )
