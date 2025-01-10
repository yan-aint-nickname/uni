from typing import TypeAlias
from dataclasses import dataclass
import itertools

MType: TypeAlias = list[list[float]] 
_MType: TypeAlias = MType  # упорядоченная матрица
MkType: TypeAlias = MType  # матрица номеров
McType: TypeAlias = MType  # суммарная матрица


@dataclass
class BubbleSorted:
    seq: list
    pos: list


# Модифицированая сортировка пузырьком с созданием новой последовательности и сохранением позиции перестановки
# Выбираем его, потому что он простой и стабильный - сохраняет последовательность смены элементов
# https://en.wikipedia.org/wiki/Sorting_algorithm#Stability
def bubble_sort(arr) -> BubbleSorted:
    arr = list(arr)
    n = len(arr)
    positions = list(range(n))
    # Копируем входящую последовательность
    arr_new = arr.copy()
    for i in range(len(arr)):
        for j in range(len(arr) - i - 1):
            if arr_new[j] > arr_new[j + 1]:
                # Swap
                arr_new[j], arr_new[j + 1] = arr_new[j + 1], arr_new[j]
                positions[j], positions[j + 1] = positions[j + 1], positions[j]

    final_positions = [0] * n
    for i in range(n):
        final_positions[positions[i]] = i

    return BubbleSorted(seq=arr_new, pos=positions)


def transpose(m):
    return [list(i) for i in zip(*m)]


def new_matrixies_from_original(m: MType) -> tuple[_MType, MkType, McType]:
    _M = []
    Mk = []
    Mc = []
    for column in transpose(m):
        bsm = bubble_sort(column)
        _M.append(bsm.seq)
        Mk.append(bsm.pos)
        Mc.append(list(itertools.accumulate(bsm.seq)))
    return (transpose(_M), transpose(Mk), transpose(Mc))


def replace_rows_and_columns_from_matrix_by_indexes(m: MType, idxs: list[int]) -> MType:
    # Глубокое копирование
    m_copy = [row[:] for row in m]

    # Удаление строк
    m_copy = [row for i, row in enumerate(m_copy) if i not in idxs]

    # Удаление столбцов
    for i in range(len(m_copy)):
        m_copy[i] = [val for j, val in enumerate(m_copy[i]) if j not in idxs]
    return m_copy