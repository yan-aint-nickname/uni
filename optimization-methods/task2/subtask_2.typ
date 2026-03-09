#import "utils.typ": bisection_method, calc_median, func_3
#import "@preview/lilaq:0.5.0" as lq

#let epsilon_1 = 0.1
#let epsilon_2 = 0.001

= Задание 2. Метод деления отрезка пополам. $f(x) = x^2 + 2x - 4 -> min, x in [-2, 1]$

Найти решение задачи $min f(x), x in [a, b]$ методом деления отрезка пополам с различной точностью $(epsilon_1=0,1; epsilon_2=0,001)$

== Решение

#let xs = lq.linspace(-2, 1, num: 1000)

#figure(
  caption: [График функции $x^2 + 2x - 4, x in [-2, 1]$],
  lq.diagram(width: 14cm, height: 7cm, margin: (x: 0%), lq.plot(xs, func_3, mark: none)),
)

#figure(
  caption: [Результаты вычислений для $epsilon = epsilon_1 = 0.1$],
  table(columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto), table.header(
    [Номер итерации],
    [a],
    [b],
    [$(b-a)/2$],
    [$x_1$],
    [$x_2$],
    [$f(x_1)$],
    [$f(x_2)$],
    [Сравнение $f(x_1)$ и $f(x_2)$],
    [1],
    [-2],
    [1],
    [#calc.round((1 + 2) / 2, digits: 2)],
    [#calc.round(calc_median(-2, 1) - epsilon_1, digits: 3)],
    [#calc.round(calc_median(-2, 1) + epsilon_1, digits: 3)],
    [#calc.round(func_3(-0.6), digits: 3)],
    [#calc.round(func_3(-0.4), digits: 3)],
    [$f(x_1) < f(x_2)$],
    [2],
    [-2],
    [-0.5],
    [#calc.round((-0.5 + 2) / 2, digits: 2)],
    [#calc.round(calc_median(-2, -0.5) - epsilon_1, digits: 3)],
    [#calc.round(calc_median(-2, -0.5) + epsilon_1, digits: 3)],
    [#calc.round(func_3(-1.35), digits: 3)],
    [#calc.round(func_3(-1.15), digits: 3)],
    [$f(x_1) > f(x_2)$],
    [3],
    [#calc.round((-0.5 - 2) / 2, digits: 3)],
    [-0.5],
    [#calc.round((-0.5 + 1.25) / 2, digits: 3)],
    [#calc.round(calc_median(-1.25, -0.5) - epsilon_1, digits: 3)],
    [#calc.round(calc_median(-1.25, -0.5) + epsilon_1, digits: 3)],
    [#calc.round(func_3(-0.975), digits: 3)],
    [#calc.round(func_3(-0.775), digits: 3)],
    [$f(x_1) < f(x_2)$],
    [4],
    [-1.25],
    [-0.875],
    [#calc.round((-0.875 + 1.25) / 2, digits: 3)],
    [#calc.round(calc_median(-1.25, -0.875) - epsilon_1, digits: 3)],
    [#calc.round(calc_median(-1.25, -0.875) + epsilon_1, digits: 3)],
    [#calc.round(func_3(-1.163), digits: 3)],
    [#calc.round(func_3(-0.963), digits: 3)],
    [$f(x_1) < f(x_2)$],
    [5],
    [#calc.round((-0.875 - 1.25) / 2, digits: 3)],
    [-0.875],
    [#calc.round((-0.875 + 1.063) / 2, digits: 3)],
    table.cell(colspan: 5)[$0.094 <= 0.1 "- точность достигнута"$],
  )),
) <table-subtask-2-epsilon-0.1>

// $
//   "При" epsilon &= epsilon_1 = 0.1\
//   x^*           &= (a+b)/2 = (-1.063-0.875)/2 = #calc.round((-1.063 - 0.875) / 2, digits: 3)\
//   f(x^*)        &= #calc.round(func_3(-0.963), digits: 4)
// $

Рассчитаем для точности $epsilon = epsilon_2 = 0.001$, продолжим @table-subtask-2-epsilon-0.1[Таблицу]

#figure(
  caption: [Результаты вычислений для $epsilon = epsilon_2 = 0.001$],
  table(columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto), table.header(
    [Номер итерации],
    [a],
    [b],
    [$(b-a)/2$],
    [$x_1$],
    [$x_2$],
    [$f(x_1)$],
    [$f(x_2)$],
    [Сравнение $f(x_1)$ и $f(x_2)$],
    [5],
    [-1.063],
    [-0.875],
    [#calc.round((-0.875 + 1.063) / 2, digits: 3)],
    [#calc.round(calc_median(-1.063, -0.875) - epsilon_2, digits: 3)],
    [#calc.round(calc_median(-1.063, -0.875) + epsilon_2, digits: 3)],
    [#calc.round(func_3(-1.069), digits: 3)],
    [#calc.round(func_3(-0.869), digits: 3)],
    [$f(x_1) < f(x_2)$],
    [6],
    [-1.063],
    [#calc_median(-1.063, -0.875)],
    [#calc.round((-0.969 + 1.063) / 2, digits: 3)],
    [#calc.round(calc_median(-1.063, -0.969) - epsilon_2, digits: 3)],
    [#calc.round(calc_median(-1.063, -0.969) + epsilon_2, digits: 3)],
    [#calc.round(func_3(-1.116), digits: 3)],
    [#calc.round(func_3(-0.916), digits: 3)],
    [$f(x_1) > f(x_2)$],
    [7],
    [#calc_median(-1.063, -0.969)],
    [-0.969],
    [#calc.round((-0.969 + 1.016) / 2, digits: 3)],
    [#calc.round(calc_median(-1.016, -0.969) - epsilon_2, digits: 3)],
    [#calc.round(calc_median(-1.016, -0.969) + epsilon_2, digits: 3)],
    [#calc.round(func_3(-1.093), digits: 3)],
    [#calc.round(func_3(-0.893), digits: 3)],
    [$f(x_1) < f(x_2)$],
    [8],
    [-1.016],
    [#calc.round(calc_median(-1.016, -0.969), digits: 3)],
    [#calc.round((-0.992 + 1.016) / 2, digits: 3)],
    [#calc.round(calc_median(-1.016, -0.992) - epsilon_2, digits: 3)],
    [#calc.round(calc_median(-1.016, -0.992) + epsilon_2, digits: 3)],
    [#calc.round(func_3(-1.005), digits: 5)],
    [#calc.round(func_3(-1.003), digits: 5)],
    [$f(x_1) > f(x_2)$],
    [9],
    [#calc.round(calc_median(-1.016, -0.992), digits: 3)],
    [-0.992],
    [#calc.round((-0.992 + 1.004) / 2, digits: 3)],
    [#calc.round(calc_median(-1.004, -0.992) - epsilon_2, digits: 3)],
    [#calc.round(calc_median(-1.004, -0.992) + epsilon_2, digits: 3)],
    [#calc.round(func_3(-1.005), digits: 6)],
    [#calc.round(func_3(-1.003), digits: 6)],
    [$f(x_1) > f(x_2)$],
    [10],
    [#calc.round(calc_median(-1.004, -0.992), digits: 4)],
    [-0.992],
    [#calc.round((-0.992 + 0.998) / 2, digits: 4)],
    [#calc.round(calc_median(-0.998, -0.992) - epsilon_2, digits: 3)],
    [#calc.round(calc_median(-0.998, -0.992) + epsilon_2, digits: 3)],
    [#calc.round(func_3(-0.996), digits: 6)],
    [#calc.round(func_3(-0.994), digits: 6)],
    [$f(x_1) < f(x_2)$],
    [11],
    [-0.998],
    [#calc.round(calc_median(-0.998, -0.992), digits: 4)],
    [#calc.round((-0.995 + 0.998) / 2, digits: 4)],
    [#calc.round(calc_median(-0.998, -0.995) - epsilon_2, digits: 3)],
    [#calc.round(calc_median(-0.998, -0.995) + epsilon_2, digits: 3)],
    [#calc.round(func_3(-0.997), digits: 6)],
    [#calc.round(func_3(-0.995), digits: 6)],
    [$f(x_1) < f(x_2)$],
    [12],
    [-0.998],
    [#calc.round(calc_median(-0.998, -0.995), digits: 4)],
    [#calc.round((-0.9965 + 0.998) / 2, digits: 4)],
    table.cell(colspan: 5)[$0.0007 <= 0.001 "- точность достигнута"$],
  )),
) <table-subtask-2-epsilon-0.001>

#let subtask_2_res_1 = bisection_method(-2, 1, func_3)
#let (x_min_1, y_min_1, iterations_1) = subtask_2_res_1

#let subtask_2_res_2 = bisection_method(-2, 1, func_3, epsilon: 0.001)
#let (x_min_2, y_min_2, iterations_2) = subtask_2_res_2

1. Находим корни $f prime (x) = 2x + 2 = 0$
$
  2x+2 &= 0 |:2\
  x+1  &= 0\
  x    &= -1 in [-2, 1] \
  =>   & x_0 = -2, x_1 = -1, x_2 = 1
$

2. Вычисляем значение в точках $x_i, i = 0,...,2$
$
  f(x_0) &= #func_3(-2)\
  f(x_1) &= #func_3(-1)\
  f(x_2) &= #func_3(1)
$

3. Находим $f^ast = min(f(x_0), f(x_1), f(x_2))$

$
  f^ast &= min(-4, -5, -1) = -5\
        &=> x^ast = x_1 = -1, f^ast = -5
$
Ответ: $x^ast = -1, f^ast = -5$

#figure(caption: [Сравнительная таблица методов нахождения минимума функции], table(
  fill: (_, y) => { if calc.odd(y) { luma(240) } else { white } },
  columns: (auto, auto, auto, auto, auto),
  table.header([Способ расчета], [$x_min$], [$f(x_min)$], [Кол-во итераций], [Точность $epsilon$]),
  ["Вручную"],
  [#calc.round((-0.875 - 1.063) / 2, digits: 3)],
  [#calc.round(func_3((-0.875 - 1.063) / 2), digits: 4)],
  [5],
  [$0.1$],
  ["Вручную"],
  [#calc.round((-0.998 - 0.9965) / 2, digits: 3)],
  [#calc.round(func_3((-0.998 - 0.9965) / 2), digits: 5)],
  [12],
  [$0.001$],
  [Алгоритм `bisection_method`],
  [#x_min_1],
  [#calc.round(y_min_1, digits: 3)],
  [#iterations_1],
  [$0.1$],
  [Алгоритм `bisection_method`],
  [#calc.round(x_min_2, digits: 5)],
  [#calc.round(y_min_2, digits: 7)],
  [#iterations_2],
  [$0.001$],
  [Классический метод],
  [-1],
  [-5],
  table.cell(stroke: none, fill: none)[],
  table.cell(stroke: none, fill: none)[],
))<table-subtask-2-results-comparison>

== Выводы

В данной задаче минимум функции $f(x) = x^2 + 2x -4$ был найден методом деления отрезка пополам.

Метод последовательно уменьшает интервал поиска, сравнивая значения функции в двух точках, симметрично расположенных относительно середины интервала.

При точности $epsilon = 0.1$ решение было получено за 5 итераций, а при точности
$epsilon = 0.001$ - за 12 итераций. Полученные значения минимума $x approx -1 "и" f(x) approx -5$ совпадают с точным аналитическим решением.

Это подтверждает эффективность метода дихотомии для поиска минимума унимодальной функции на заданном интервале.
