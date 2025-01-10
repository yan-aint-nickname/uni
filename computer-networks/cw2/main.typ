#import "template.typ": *

#import "@preview/codelst:2.0.2": sourcecode, sourcefile
#import "@preview/muchpdf:0.1.0": muchpdf
#import "@preview/pavemat:0.1.0": pavemat
#import "@preview/fletcher:0.5.4" as fletcher: diagram, node, edge, shapes
#import fletcher.shapes: rect
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Компьютерные сети. КМ-2",
  authors: (
    "Кирш Я.А. ИДз-21-21. Вариант 8.",
  ),
)

#show figure: set block(breakable: true)
#set terms(separator: [: ])

#set heading(
  numbering: (..nums) => {
    if nums.pos().len() >= 4 {
      none
    } else {
      numbering("1.", ..nums)
    }
  }
)

#outline()

= Задание

#muchpdf(read("assets/comp-networks-cw2-task.pdf", encoding: none), scale: 0.95)

#pagebreak()

= Решение

/ $M$ : Матрица взвешенных расстояний
/ $overline(M)$ : Упорядоченная матрица
/ $M^k$ : Матрица номеров
/ $M^c$ : Суммарная матрица

== Находим группы h=1

=== Находим $"Г"_1$
$
M = mat(
    0, 18, 32, 29, 53, 73, 68, 63, 108;
    18, 0, 23, 19, 43, 63, 58, 56, 98;
    32, 23, 0, 33, 58, 78, 83, 68, 108;
    29, 19, 33, 0, 33, 53, 48, 43, 68;
    53, 43, 58, 33, 0, 48, 38, 34, 78;
    73, 63, 78, 53, 48, 0, 20, 38, 48;
    68, 58, 83, 48, 38, 20, 0, 26, 36;
    63, 56, 68, 43, 34, 38, 26, 0, 48;
    108, 98, 108, 68, 78, 48, 36, 48, 0;
)
$
Программный пакет `lib`, используемый в контрольной представлен в @lib

Для работы программы необходимы: интерпретатор python#footnote(link("https://www.python.org/")), jupyterlab#footnote(link("https://jupyter.org/")) и остальные библиотеки перечисленные в @draw-graph после ключевого слова `import`.

#figure(
  caption: "Программа построения графа сети из заданной матрицы взвешенных расстояний (код программы исполняется в среде jupyterlab)",
  sourcecode[
    ```python
# Импортируем необходимые библиотеки
import networkx as nx
import numpy as np
import matplotlib.pyplot as plt

# Рисуем граф сети
M = [
    [0, 18, 32, 29, 53, 73, 68, 63, 108],
    [18, 0, 23, 19, 43, 63, 58, 56, 98],
    [32, 23, 0, 33, 58, 78, 83, 68, 108],
    [29, 19, 33, 0, 33, 53, 48, 43, 68],
    [53, 43, 58, 33, 0, 48, 38, 34, 78],
    [73, 63, 78, 53, 48, 0, 20, 38, 48],
    [68, 58, 83, 48, 38, 20, 0, 26, 36],
    [63, 56, 68, 43, 34, 38, 26, 0, 48],
    [108, 98, 108, 68, 78, 48, 36, 48, 0]
]
distances = np.matrix(M)

def new_graph_from_matrix(distances: np.matrix) -> nx.Graph:
    # Создаем граф из матрицы весов
    return nx.from_numpy_array(distances)


def visualize_distance_matrix(G: nx.Graph):
    # Создаем макет для графа
    pos = nx.circular_layout(G)

    # Рисуем граф
    plt.figure(figsize=(15, 10))
    nx.draw_networkx_nodes(G, pos, node_color='lightblue', node_size=500)

    colors = [
        "darkblue", 
        "darkred", 
        "darkgreen", 
        "black", 
        "navy", 
        "crimson", 
        "purple", 
        "teal", 
        "maroon"
    ]
    # Рисуем ребра и красим их разными цветами
    for c, i in zip(colors, range(0, 9)):
        edgelist = [(u, v) for (u, v) in G.edges() if u == i or v == i]
        nx.draw_networkx_edges(G, pos, edgelist=edgelist, edge_color=c)

    # Добавляем метки вершин
    labels = {idx: idx+1 for idx in G.nodes()}
    nx.draw_networkx_labels(G, pos, labels)

    # Добавляем веса ребер
    edge_labels = nx.get_edge_attributes(G, 'weight')
    nx.draw_networkx_edge_labels(G, pos, edge_labels=edge_labels)

    plt.title('Граф сети с весами')
    plt.axis('off')
    plt.show()

# Визуализируем сеть
G = new_graph_from_matrix(distances=distances)
visualize_distance_matrix(G)
    ```
  ]
) <draw-graph>

#figure(image("assets/network-graph.png"), caption: [ Граф сети с весами - результат выполнения @draw-graph ]) <network-graph>

#figure(
  sourcefile(file: "lib.py", read("lib.py")),
  caption: "Программный пакет lib с необходимыми функциями для работы алгоритма"
) <lib>

Используя программый пакет `lib` в @lib, найдем упорядоченную матрицу $overline(M)$, матрицу номеров $M^k$ и суммарную матрицу $M^c$.

#figure(
  sourcecode(
    ```python
import numpy as np
from lib import new_matrixies_from_original

# Определение группы
## Находим упорядоченную матрицу, матрицу номеров и суммарную матрицу
_M, Mk, Mc = new_matrixies_from_original(M)

# Обновим индексы, чтобы отсчет шел от 1 
for row in Mk:
    for j in range(len(row)):
        row[j] += 1

print(np.array(_M))
print(np.array(Mk))
print(np.array(Mc))
    ```
  )
)

Результат: 

$
overline(M) = mat(
   0,  0,  0,  0, 0,   0,  0,  0,  0;
  18, 18, 23, 19, 33, 20, 20, 26, 36;
  29, 19, 32, 29, 34, 38, 26, 34, 48;
  32, 23, 33, 33, 38, 48, 36, 38, 48;
  53, 43, 58, 33, 43, 48, 38, 43, 68;
  63, 56, 68, 43, 48, 53, 48, 48, 78;
  68, 58, 78, 48, 53, 63, 58, 56, 98;
  73, 63, 83, 53, 58, 73, 68, 63,108;
 108, 98,108, 68, 78, 78, 83, 68,108;
)\
M^k = mat(
 1,2,3,4,5,6,7,8,9;
 2,1,2,2,4,7,6,7,7;
 4,4,1,1,8,8,8,5,6;
 3,3,4,3,7,5,9,6,8;
 5,5,5,5,2,9,5,4,4;
 8,8,8,8,6,4,4,9,5;
 7,7,6,7,1,2,2,2,2;
 6,6,7,6,3,1,1,1,1;
 9,9,9,9,9,3,3,3,3;
)
M^c = mat(
   0,  0,  0,  0,  0,  0,  0,  0,  0;
  18, 18, 23, 19, 33, 20, 20, 26, 36;
  47, 37, 55, 48, 67, 58, 46, 60, 84;
  79, 60, 88, 81,105,106, 82, 98,132;
 132,103,146,114,148,154,120,141,200;
 195,159,214,157,196,207,168,189,278;
 263,217,292,205,249,270,226,245,376;
 336,280,375,258,307,343,294,308,484;
 444,378,483,326,385,421,377,376,592;
)
$

В задании сказано, что нужно найти 3 узла, для этого нужно отсчитать 3 строку в $M^c$ и найти минимальный элемент в ней.

$M^c = #pavemat(
$ mat(
   0, 0,  0,  0,  0,  0,  0,  0,  0;
  18, 18, 23, 19, 33, 20, 20, 26, 36;
  47, 37, 55, 48, 67, 58, 46, 60, 84;
  79, 60, 88, 81,105,106, 82, 98,132;
  132,103,146,114,148,154,120,141,200;
 195,159,214,157,196,207,168,189,278;
 263,217,292,205,249,270,226,245,376;
 336,280,375,258,307,343,294,308,484;
 444,378,483,326,385,421,377,376,592;
) $,
  fills: (
  "[2-1]": green.transparentize(80%),
)) arrow.r min(m_(3j)) = m_(32) = 37$

// #set math.mat(row-gap: 0.25em, column-gap: 0.1em)

Находим 3 строку и 2 стоблец в $M^k$

$M_k = #pavemat(
  $ mat(
 1,2,3,4,5,6,7,8,9;
 2,1,2,2,4,7,6,7,7;
 4,4,1,1,8,8,8,5,6;
 3,3,4,3,7,5,9,6,8;
 5,5,5,5,2,9,5,4,4;
 8,8,8,8,6,4,4,9,5;
 7,7,6,7,1,2,2,2,2;
 6,6,7,6,3,1,1,1,1;
 9,9,9,9,9,3,3,3,3;
) $,
  fills: (
  "[0-1]": green.transparentize(80%),
  "[1-1]": green.transparentize(80%),
  "[2-1]": green.transparentize(80%),
)) arrow.r "Г"_1 = {2, 1, 4}$

=== Находим $"Г"_2$

Вычеркиваем столбцы и строки 2, 1, 4 из матрицы M;

#figure(
  sourcecode(
    ```python
from lib import replace_rows_and_columns_from_matrix_by_indexes
# Обратите внимание индексы матрицы считаются от 0, а не от 1
indx_to_replace = [0, 1, 3]

M_1 = replace_rows_and_columns_from_matrix_by_indexes(M, indx_to_replace)
print(np.array(M_1))

_M_1, Mk_1, Mc_1 = new_matrixies_from_original(M_1)

# Обновим индексы, чтобы отсчет шел от 1 
for row in Mk_1:
    for j in range(len(row)):
        row[j] += 1

print(np.array(_M_1))
print(np.array(Mk_1))
print(np.array(Mc_1))
    ```
  ), caption: [Программа вычеркивания строк и столбцов и построение новых матриц $M^((1))$],
) <replace_and_new_m_1>

Результат работы программы из @replace_and_new_m_1

$ M^((1)) = #pavemat($mat(
   0, 58, 78, 83, 68,108;
  58,  0, 48, 38, 34, 78;
  78, 48,  0, 20, 38, 48;
  83, 38, 20,  0, 26, 36;
  68, 34, 38, 26,  0, 48;
 108, 78, 48, 36, 48,  0;
)$)$

$ overline(M)^((1)) = #pavemat($mat(
   0,  0,  0,  0,  0,  0;
  58, 34, 20, 20, 26, 36;
  68, 38, 38, 26, 34, 48;
  78, 48, 48, 36, 38, 48;
  83, 58, 48, 38, 48, 78;
 108, 78, 78, 83, 68,108;
)$)$

$ M_k^((1)) = #pavemat($mat(
 1,2,3,4,5,6;
 2,5,4,3,4,4;
 5,4,5,5,2,3;
 3,3,2,6,3,5;
 4,1,6,2,6,2;
 6,6,1,1,1,1;
)$) arrow.r.long^"Производим подмену индексов" M_k^((1)) = #pavemat($mat(
 3,5,6,7,8,9;
 5,8,7,6,7,7;
 8,7,8,8,5,6;
 6,6,5,9,6,8;
 7,3,9,5,9,5;
 9,9,3,3,3,3;
)$)$

$ M_c^((1)) = #pavemat($mat(
   0,  0,  0,  0,  0,  0;
  58, 34, 20, 20, 26, 36;
 126, 72, 58, 46, 60, 84;
 204,120,106, 82, 98,132;
 287,178,154,120,146,210;
 395,256,232,203,214,318;
)$)$

Находим минимальный элемент в 3 строке $M_c^((1))$

$ M_c^((1)) = #pavemat($mat(
   0,  0,  0,  0,  0,  0;
  58, 34, 20, 20, 26, 36;
 126, 72, 58, 46, 60, 84;
 204,120,106, 82, 98,132;
 287,178,154,120,146,210;
 395,256,232,203,214,318;
)$, fills: ("[2-3]": blue.transparentize(80%))); arrow.r min(m_(6j)) = m_67 = 46$

Находим 7 стоблец и 6 строку в $M_k^((1))$

$M_k^((1)) = #pavemat($mat(
 3,5,6,7,8,9;
 5,8,7,6,7,7;
 8,7,8,8,5,6;
 6,6,5,9,6,8;
 7,3,9,5,9,5;
 9,9,3,3,3,3;
)$, fills: (
  "[0-3]": blue.transparentize(80%),
  "[1-3]": blue.transparentize(80%),
  "[2-3]": blue.transparentize(80%),
)) -> "Г"_2 = {7, 6, 8}$


=== Находим $"Г"_3$

Вычеркиваем строки и стобцы 7, 6, 8 из $M^((1))$, повторяем операцию из @replace_and_new_m_1 

#figure(
  sourcecode(
    ```python
from lib import replace_rows_and_columns_from_matrix_by_indexes
# Обратите внимание индексы матрицы считаются от 0, а не от 1
indx_to_replace = [2, 3, 4]

M_2 = replace_rows_and_columns_from_matrix_by_indexes(M_1, indx_to_replace)
print(np.array(M_1))

_M_2, Mk_2, Mc_2 = new_matrixies_from_original(M_2)

# Обновим индексы, чтобы отсчет шел от 1 
for row in Mk_2:
    for j in range(len(row)):
        row[j] += 1

print(np.array(_M_2))
print(np.array(Mk_2))
print(np.array(Mc_2))
    ```
  ), caption: [Программа вычеркивания строк и столбцов и построение новых матриц $M^((2))$],
) <replace_and_new_m_2>

Результат работы программы из @replace_and_new_m_2

$ M^((2)) = #pavemat($mat(
   0, 58,108;
  58,  0, 78;
 108, 78,  0;
)$)$

$ overline(M)^((2)) = #pavemat($mat(
   0,  0,  0;
  58, 58, 78;
 108, 78,108;
)$)$

$ M_k^((2)) = #pavemat($mat(
 1,2,3;
 2,1,2;
 3,3,1;
)$) arrow.r.long^"Производим подмену индексов" M_k^((2)) = #pavemat($mat(
 3,5,9;
 5,3,5;
 9,9,3;
)$)$

$ M_c^((2)) = #pavemat($mat(
   0,  0,  0;
  58, 58, 78;
 166,136,186;
)$,
  fills: (
  "[2-1]": red.transparentize(80%),
)), min(m_(9j)) = m_(95) = 136$

Находим 5 столбец и 9 строку

$M_k^((2)) = #pavemat($mat(
 3,5,9;
 5,3,5;
 9,9,3;
)$, fills: (
  "[2-1]": red.transparentize(80%),
  "[1-1]": red.transparentize(80%),
  "[0-1]": red.transparentize(80%)
)) -> "Г"_3 = {5, 3, 9}$

==== Улучшение $"Г"_3$

Центр улучшаемой группы $"Г"_"у" = "Г"_3$, расположен при узле 5. Узлы 3, 9 могут корректироваться, если расстояние
$m_(35)>m_(32) "либо" m_(95)>m_(97)$. По матрице $M_k^*$ анализируем соответственно столбцы 3 и 9.

$M_k = #pavemat($mat(
 ,3,9;
1,3,9;
2,2,7;
3,1,6;
4,4,8;
5,5,4;
6,8,5;
7,6,2;
8,7,1;
9,9,3;
)$,
  pave: ("sDDDDDDD", "dSSSSSSSSSS"),
  fills: (
  "[2-1]": green.transparentize(80%),
  "[5-1]": red.transparentize(80%),
  "[6-2]": red.transparentize(80%),
  "[2-2]": blue.transparentize(80%),
)) => "узел 3 переходит в " "Г"_1, "а узел 9 переходит в " "Г"_2$

В столбце 3, узел 2 находится выше, чем узел 5. Это означает, что центр $"Г"_1$ при узле 2 расположен к улучшаемому узлу 
3 ближе, чем центр $"Г"_3$ при узле 5. Поэтому производим корректировку узла 3.
В 9 столбце узел 5 находится ниже, чем узел 7. Поэтому корректировку необходимо произвести.
В процессе корректировки узел 3 следует передать из $"Г"_3$ в $"Г"_1$, а из $"Г"_1$ передать ближайший узел к $"Г"_3$, а
узел 9 передать в $"Г"_2$ с центром в узле 7 и ближайший узел из $"Г"_2$ передать в $"Г"_3$.

$M_k = #pavemat($mat(
 ,5;
1,5;
2,4;
3,8;
4,7;
5,2;
6,6;
7,1;
8,3;
9,9;
)$,
  pave: ("sDDD", "dSSSSSSSSSS"),
  fills: (
  "[0-1]": red.transparentize(80%),
  "[2-1]": gray.transparentize(50%),
  "[5-1]": gray.transparentize(80%),
)) => "узел 4 переходит в " "Г"_3$

Выбираем ближайший узер из $"Г"_2$ к $"Г"_3$

$M_k = #pavemat($mat(
 ,5;
1,5;
2,4;
3,8;
4,7;
5,2;
6,6;
7,1;
8,3;
9,9;
)$,
  pave: ("sDDD", "dSSSSSSSSSS"),
  fills: (
  "[0-1]": red.transparentize(80%),
  "[3-1]": gray.transparentize(50%),
  "[6-1]": gray.transparentize(80%),
)) => "узел 8 переходит в " "Г"_3$

=== Итог перестановок
$"Г"_1 = {2, 1, 3}; "Г"_2 = {7, 6, 9}; "Г"_3 = {5, 4, 8}$

== Находим группы h=2

Корректируем исходную матрицу $M$, так что в ней остаются только центры групп.

$M^((3)) = #pavemat($mat(
   , 2, 5, 7;
  2, 0, 43, 58;
  5, 43, 0, 38;
  7, 58, 38, 0;
)$, pave: ("sDDDD", "dSSSS"))$

#figure(
  sourcecode(
    ```python
# Находим группу h=2
M_3 = [
    [0, 43, 58],
    [43, 0, 38],
    [58, 38, 0],
]

_M_3, Mk_3, Mc_3 = new_matrixies_from_original(M_3)

# Обновим индексы, чтобы отсчет шел от 1
for row in Mk_3:
    for j in range(len(row)):
        row[j] += 1

print(np.array(_M_3))
print(np.array(Mk_3))
print(np.array(Mc_3))
    ```
  ),
  caption: [ Вычисление $overline(M), M_k, M_c$ для скорректированной матрицы $M$ ],
) <m_corrected_h2>

$overline(M)^((4)) = #pavemat(
  $mat(
  0, 0, 0;
 43,38,38;
 58,43,58;
  )$
)$

$M_k^((4)) = #pavemat(
  $mat(
 1,2,3;
 2,3,2;
 3,1,1;
  )$
) arrow.r.long M_k^((4)) = #pavemat(
$mat(
 2,5,7;
 5,7,5;
 7,2,2;
  )$
)$

$M_c^((4)) = #pavemat(
$mat(
   0,  0,  0;
  43, 38, 38;
 101, 81, 96;
)$, fills: (
  "[2-1]": yellow.transparentize(80%),
)), min(m_(7j)) = m_(75) = 81$

Центр групы расположен в 5 узле, $"Г"_1 = {5, 7, 2}$

$M_k^((4)) = #pavemat(
$mat(
 2,5,7;
 5,7,5;
 7,2,2;
)$, fills: (
  "[0-1]": yellow.transparentize(80%),
  "[1-1]": yellow.transparentize(80%),
  "[2-1]": yellow.transparentize(80%),
))$

Сформирована только одна группа - процедура расчета заканчивается.

Итого:

$h=1: "Г"_1 = {2, 1, 3}; "Г"_2 = {7, 6, 9}; "Г"_3 = {5, 4, 8}$

$h=2: "Г"_1 = {5, 7, 2}$

Результат расчета стркуктуры представлен на рисунке @res-graph

#figure(
  image("assets/result-graph.png"),
  caption: [Схема расчитанной структуры],
) <res-graph>

= Приложение 1

#figure(
  sourcefile(file: "tests.py", read("tests.py")),
  caption: [Файл с функциями и данными для тестирования пакета `lib.py`, использует пакет `pytest`, данные взяты из лекции 5-6]
)

// == Приложение 2
//
// Для самопроверки я нашел алгоритм MDS#footnote(link("https://ru.wikipedia.org/wiki/Многомерное_шкалирование")), в библиотеке scikit-learn#footnote(link("https://scikit-learn.org/stable/modules/manifold.html")).
//
// #figure(
//   sourcecode(
//     ```python
//     ```
//   ),
//   caption: [Алгоритм самопроверки]
// )

// Слишком много времени занимает отрисовка графа руками, поэтому возьму из задания :(
// #figure(
//   diagram(debug: true, {
//     
//     node((5,1), [cnt], name: <center>, fill: black.transparentize(50%), )
//
//     node((0,2), [213], name: <213>, fill: black.transparentize(50%), )
//     node((5,3), [769], name: <769>, fill: black.transparentize(50%), )
//     node((8,2), [548], name: <548>, fill: black.transparentize(50%), )
//     edge(<center>, <213>, "-", bend: -10deg)
//     edge(<center>, <769>, "-")
//     edge(<center>, <548>, "-")
//
//     node((0.8,2), [ 2 ], name: <2>, fill: black.transparentize(50%), radius: 0.7em)
//     node((-1,1), [ 1 ], name: <1>, fill: black.transparentize(50%), radius: 0.7em)
//     node((-1,3), [ 3 ], name: <3>, fill: black.transparentize(50%), radius: 0.7em)
//     edge(<213>, <2>, "-")
//     edge(<213>, <1>, "-")
//     edge(<213>, <3>, "-")
//
//     node((4,4), [ 7 ], name: <7>, fill: black.transparentize(50%), radius: 0.7em)
//     node((5,4), [ 6 ], name: <6>, fill: black.transparentize(50%), radius: 0.7em)
//     node((6,4), [ 9 ], name: <9>, fill: black.transparentize(50%), radius: 0.7em)
//     edge(<769>, <7>, "-")
//     edge(<769>, <6>, "-")
//     edge(<769>, <9>, "-")
//
//     node((0,0), [ 5 ], name: <5>, fill: black.transparentize(50%), radius: 0.7em)
//     node((0,0), [ 4 ], name: <4>, fill: black.transparentize(50%), radius: 0.7em)
//     node((0,0), [ 8 ], name: <8>, fill: black.transparentize(50%), radius: 0.7em)
//     edge(<548>, <5>, "-")
//     edge(<548>, <4>, "-")
//     edge(<548>, <8>, "-")
//   })
// ) <network-graph-result>

Полный код работы содержится в репозитории.#footnote(link("https://github.com/yan-aint-nickname/uni/tree/main/computer-networks/cw2"))

