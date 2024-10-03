#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Компьютерные сети. КМ-1",
  authors: (
    "Кирш Я.А. ИДз-21-21. Вариант 8.",
  ),
)

#show figure: set block(breakable: true)

= Задание
Имеется симметричная матрица взвешенных расстояний $M(6,6)$, элементы
$m_(i j)$ которой заданы так: $m_(i j) = N + 3 times i times j$ при $i eq.not j$, $m_(i j) = infinity$ при $i = j$,
где $N$ – последняя цифра номера зачётной книжки студента. Используя алгоритм Прима, определить древовидную связную сеть, имеющую наименьшую суммарную внешнюю длину (в качестве ответа привести матрицу результатов расчёта структуры).

#let N = 8

#let fill_value(i, j) = (
  if i == j { $infinity$ }
  else { N + 3*i*j }
)

#let data = (1, 2, 3, 4, 5, 6).map(i => ((1, 2, 3, 4, 5, 6).map(j => fill_value(i, j)) ))

#let matrix = math.mat(..data)

== Построение матрицы весов
$ M = #matrix $

== Применение алгоритма Прима
1. Выбираем любую вершину для начала (например, вершину 1). Включаем её в остовное дерево.
2. Из оставшихся вершин выбираем ребро с наименьшим весом, соединяющее одну из уже включенных вершин с одной из оставшихся. Повторяем до тех пор, пока все вершины не будут включены.

=== Решение
1. Начинаем с вершины 1\
  Минимальное ребро — (1,2) с весом 14.
2. Включаем вершину 2\
  Минимальное ребро из оставшихся — (1,3) с весом 17.
3. Включаем вершину 3\
  Минимальное ребро из оставшихся — (2,4) с весом 32.
4. Включаем вершину 4\
  Минимальное ребро из оставшихся — (3,5) с весом 53.
5. Включаем вершину 5\
  Минимальное ребро из оставшихся — (4,6) с весом 80.


#let res = (14, 17, 32, 53, 80)

#let res_data = data.map(row => row.map(val => if val in res { val } else { $infinity$ }) )

#let skeleton_matrix = math.mat(..res_data)

== Результирующая матрица остовного дерева
$ M_("остов") = #skeleton_matrix $

На википедии наглядно показано как работает алгоритм.#footnote("https://ru.wikipedia.org/wiki/Алгоритм_Прима")
Полный код работы содержится в репозитории.#footnote("https://ru.wikipedia.org/wiki/Алгоритм_Прима")
