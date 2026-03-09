#import "utils.typ": bisection_method, calc_median, calc_lambda, calc_mu, golden_ratio
#import "@preview/lilaq:0.5.0" as lq
#import "@preview/codly:1.3.0": *

#let epsilon_1 = 0.1
#let epsilon_2 = 0.001

= Задание 3. Метод золотого сечения. $f(x) = (x-2)^2 -> min, x in [0, 3]$

Найти решение задачи $min f(x), x in [a, b]$ методом золотого сечения с различной точностью $(epsilon_1=0,1; epsilon_2=0,001)$

#let func_4(x) = {
  calc.pow(x - 2, 2)
}

== Решение

#let xs = lq.linspace(0, 3, num: 1000)

#figure(
  caption: [График функции $(x-2)^2, x in [0, 3]$],
  lq.diagram(width: 14cm, height: 7cm, margin: (x: 0%), lq.plot(xs, func_4, mark: none)),
)

#figure(
  caption: [Результаты вычислений для $epsilon = epsilon_1 = 0.1$],
  table(columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto), table.header(
    [Номер\ итерации],
    [a],
    [b],
    [$b-a$],
    [$lambda$],
    [$mu$],
    [$f(lambda)$],
    [$f(mu)$],
    [Сравнение $f(lambda)$ и $f(mu)$],
    [1],
    [0],
    [3],
    [#calc.round(3 - 0, digits: 2)],
    [#calc.round(calc_lambda(0, 3), digits: 3)],
    [#calc.round(calc_mu(0, 3), digits: 3)],
    [#calc.round(func_4(1.146), digits: 3)],
    [#calc.round(func_4(1.854), digits: 3)],
    [$f(lambda) > f(mu)$],
    [2],
    [1.146],
    [3],
    [#calc.round(3 - 1.146, digits: 2)],
    [#calc.round(calc_lambda(1.146, 3), digits: 3)],
    [#calc.round(calc_mu(1.146, 3), digits: 3)],
    [#calc.round(func_4(1.854), digits: 3)],
    [#calc.round(func_4(2.292), digits: 3)],
    [$f(lambda) < f(mu)$],
    [3],
    [1.146],
    [2.292],
    [#calc.round(2.292 - 1.146, digits: 3)],
    [#calc.round(calc_lambda(1.146, 2.292), digits: 3)],
    [#calc.round(calc_mu(1.146, 2.292), digits: 3)],
    [#calc.round(func_4(1.584), digits: 3)],
    [#calc.round(func_4(1.854), digits: 3)],
    [$f(lambda) > f(mu)$],
    [4],
    [1.584],
    [2.292],
    [#calc.round(2.292 - 1.584, digits: 3)],
    [#calc.round(calc_lambda(1.584, 2.292), digits: 3)],
    [#calc.round(calc_mu(1.584, 2.292), digits: 3)],
    [#calc.round(func_4(1.854), digits: 4)],
    [#calc.round(func_4(2.022), digits: 4)],
    [$f(lambda) > f(mu)$],
    [5],
    [1.854],
    [2.292],
    [#calc.round(2.292 - 1.854, digits: 3)],
    [#calc.round(calc_lambda(1.854, 2.292), digits: 3)],
    [#calc.round(calc_mu(1.854, 2.292), digits: 3)],
    [#calc.round(func_4(2.021), digits: 4)],
    [#calc.round(func_4(2.125), digits: 4)],
    [$f(lambda) < f(mu)$],
    [6],
    [1.854],
    [2.125],
    [#calc.round(2.125 - 1.854, digits: 3)],
    [#calc.round(calc_lambda(1.854, 2.125), digits: 3)],
    [#calc.round(calc_mu(1.854, 2.125), digits: 3)],
    [#calc.round(func_4(1.958), digits: 4)],
    [#calc.round(func_4(2.021), digits: 4)],
    [$f(lambda) > f(mu)$],
    [7],
    [1.958],
    [2.125],
    [#calc.round(2.125 - 1.958, digits: 3)],
    [#calc.round(calc_lambda(1.958, 2.125), digits: 3)],
    [#calc.round(calc_mu(1.958, 2.125), digits: 3)],
    [#calc.round(func_4(2.022), digits: 4)],
    [#calc.round(func_4(2.061), digits: 4)],
    [$f(lambda) < f(mu)$],
    [8],
    [1.958],
    [2.061],
    [#calc.round(2.061 - 1.958, digits: 3)],
    [#calc.round(calc_lambda(1.958, 2.061), digits: 3)],
    [#calc.round(calc_mu(1.958, 2.061), digits: 3)],
    [#calc.round(func_4(1.997), digits: 5)],
    [#calc.round(func_4(2.022), digits: 5)],
    [$f(lambda) < f(mu)$],
    [9],
    [1.958],
    [2.022],
    [#calc.round(2.022 - 1.958, digits: 3)],
    table.cell(colspan: 5)[$0.064 <= epsilon = 0.1 "- точность достигнута"$],
  )),
)

#figure(
  caption: [Результаты вычислений для $epsilon = epsilon_2 = 0.001$],
  table(columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto), table.header(
    [Номер\ итерации],
    [a],
    [b],
    [$b-a$],
    [$lambda$],
    [$mu$],
    [$f(lambda)$],
    [$f(mu)$],
    [Сравнение $f(lambda)$ и $f(mu)$],
    [9],
    [1.958],
    [2.022],
    [#calc.round(2.022 - 1.958, digits: 3)],
    [#calc.round(calc_lambda(1.958, 2.022), digits: 3)],
    [#calc.round(calc_mu(1.958, 2.022), digits: 3)],
    [#calc.round(func_4(1.982), digits: 6)],
    [#calc.round(func_4(1.998), digits: 6)],
    [$f(lambda) > f(mu)$],
    [10],
    [1.982],
    [2.022],
    [#calc.round(2.022 - 1.982, digits: 3)],
    [#calc.round(calc_lambda(1.982, 2.022), digits: 3)],
    [#calc.round(calc_mu(1.982, 2.022), digits: 3)],
    [#calc.round(func_4(1.997), digits: 6)],
    [#calc.round(func_4(2.007), digits: 6)],
    [$f(lambda) < f(mu)$],
    [11],
    [1.982],
    [2.007],
    [#calc.round(2.007 - 1.982, digits: 3)],
    [#calc.round(calc_lambda(1.982, 2.007), digits: 3)],
    [#calc.round(calc_mu(1.982, 2.007), digits: 3)],
    [#calc.round(func_4(1.992), digits: 6)],
    [#calc.round(func_4(1.997), digits: 6)],
    [$f(lambda) > f(mu)$],
    [12],
    [1.992],
    [2.007],
    [#calc.round(2.007 - 1.992, digits: 3)],
    [#calc.round(calc_lambda(1.992, 2.007), digits: 3)],
    [#calc.round(calc_mu(1.992, 2.007), digits: 3)],
    [#calc.round(func_4(1.998), digits: 6)],
    [#calc.round(func_4(2.001), digits: 6)],
    [$f(lambda) > f(mu)$],
    [13],
    [1.998],
    [2.007],
    [#calc.round(2.007 - 1.998, digits: 3)],
    [#calc.round(calc_lambda(1.998, 2.007), digits: 3)],
    [#calc.round(calc_mu(1.998, 2.007), digits: 3)],
    [#calc.round(func_4(2.001), digits: 6)],
    [#calc.round(func_4(2.004), digits: 6)],
    [$f(lambda) < f(mu)$],
    [14],
    [1.998],
    [2.004],
    [#calc.round(2.004 - 1.998, digits: 3)],
    [#calc.round(calc_lambda(1.998, 2.004), digits: 4)],
    [#calc.round(calc_mu(1.998, 2.004), digits: 4)],
    [#calc.round(func_4(2.0003), digits: 7)],
    [#calc.round(func_4(2.0017), digits: 7)],
    [$f(lambda) < f(mu)$],
    [15],
    [1.998],
    [2.0017],
    [#calc.round(2.0017 - 1.998, digits: 3)],
    [#calc.round(calc_lambda(1.998, 2.0017), digits: 4)],
    [#calc.round(calc_mu(1.998, 2.0017), digits: 4)],
    [#calc.round(func_4(1.9994), digits: 7)],
    [#calc.round(func_4(2.0003), digits: 7)],
    [$f(lambda) > f(mu)$],
    [16],
    [1.9994],
    [2.0017],
    [#calc.round(2.0017 - 1.9994, digits: 3)],
    [#calc.round(calc_lambda(1.9994, 2.0017), digits: 4)],
    [#calc.round(calc_mu(1.9994, 2.0017), digits: 4)],
    [#calc.round(func_4(2.0003), digits: 7)],
    [#calc.round(func_4(2.0008), digits: 7)],
    [$f(lambda) < f(mu)$],
    [17],
    [1.9994],
    [2.0008],
    [#calc.round(2.0008 - 1.9994, digits: 4)],
    [#calc.round(calc_lambda(1.9994, 2.0008), digits: 5)],
    [#calc.round(calc_mu(1.9994, 2.0008), digits: 5)],
    [#calc.round(func_4(1.9999), digits: 8)],
    [#calc.round(func_4(2.0003), digits: 8)],
    [$f(lambda) < f(mu)$],
    [18],
    [1.9994],
    [2.00027],
    [#calc.round(2.00027 - 1.9994, digits: 4)],
    table.cell(colspan: 5)[$0.0009 <= epsilon = 0.001 "- точность достигнута"$],
  )),
)

#codly-range(35, end: 49)
#let main = read("./utils.typ")

#figure(caption: [Метод золотого сечения на языке `typst`.], raw(main, lang: "typst", block: true)) <golden-ratio-listing>

#let (x_min_1, y_min_1, iterations_1) = golden_ratio(0, 3, func_4, epsilon: epsilon_1)

#let (x_min_2, y_min_2, iterations_2) = golden_ratio(0, 3, func_4, epsilon: epsilon_2)

Решение и результаты представлены в @result-1 и отражены в @table-subtask-3-results-comparison. Реализация алгоритма золотого сечения представлена на @golden-ratio-listing

#figure(caption: [Сравнительная таблица методов нахождения минимума функции], table(
  fill: (_, y) => { if calc.odd(y) { luma(240) } else { white } },
  columns: (auto, auto, auto, auto, auto),
  table.header([Способ расчета], [$x_min$], [$f(x_min)$], [Кол-во итераций], [Точность $epsilon$]),
  ["Вручную"],
  [#calc.round((1.958 + 2.022) / 2, digits: 3)],
  [#calc.round(func_4((1.958 + 2.022) / 2), digits: 4)],
  [9],
  [$0.1$],
  ["Вручную"],
  [#calc.round((1.99994 + 2.000027) / 2, digits: 6)],
  [#calc.round(func_4((1.99994 + 2.000027) / 2), digits: 6)],
  [18],
  [$0.001$],
  [Алгоритм `golden_ratio`],
  [#calc.round(x_min_1, digits: 4)],
  [#calc.round(y_min_1, digits: 4)],
  [#iterations_1],
  [$0.1$],
  [Алгоритм `golden_ratio`],
  [#calc.round(x_min_2, digits: 6)],
  [#calc.round(y_min_2, digits: 6)],
  [#iterations_2],
  [$0.001$],
  [Классический метод],
  [2],
  [0],
  table.cell(stroke: none, fill: none)[],
  table.cell(stroke: none, fill: none)[],
))<table-subtask-3-results-comparison>

== Выводы

В данной задаче минимум функции $f(x) = (x-2)^2$ был найден методом золотого сечения.

Метод золотого сечения позволяет эффективно уменьшать интервал неопределённости за счёт использования постоянного коэффициента деления интервала. Это позволяет избежать повторных вычислений значений функции.

В результате вычислений было получено значение минимума $x approx 2$, что совпадает с аналитическим решением задачи, найденным в @subtask-1

Увеличение точности #math.epsilon приводит к увеличению числа итераций, однако обеспечивает более точное приближение к истинному значению минимума функции.
