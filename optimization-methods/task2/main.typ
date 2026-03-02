#import "template.typ": *
#import "@preview/lilaq:0.5.0" as lq
#import "@preview/tiptoe:0.3.1"

#import "@preview/codly:1.3.0": *
#show: codly-init.with()

#show: project.with(
  title: [Методы одномерного поиска. Методы одномерной оптимизации без использования информации о производной функции.],
  discipline: [Методы оптимизации],
  work-number: "2",
  authors: ((position: "Студент группы ИДз-21-21", full_name: "Кирш Я.А."),),
  instructors: ((
    position: "Кандидат технических наук.\n Доцент кафедры Вычислительных машин, систем и сетей НИУ \"МЭИ\"",
    full_name: "Раскатова М.В.",
  ),),
  year: 2025,
)
#set enum(numbering: "1.a.")

#set page(numbering: "1")
#counter(page).update(1)

#outline()

= Задание 1. Классическая минимизация функции одной переменной.

Найти аналитическое решение задачи $min f(x), x in [a, b]$ с различной точностью $(epsilon_1=0,1; epsilon_2=0,001)$

== 1.1 Функция $f(x) = (x-2)^2 -> min, x in [0, 3]$

== Решение
1. Находим корни $f prime (x) = 2(x-2) = 2x - 4 = 0$
$
  2x-4 &= 0 |:2\
  x-2  &= 0\
  x    &= 2 in [0, 3] \
  =>   & x_0 = 0, x_1 = 2, x_2 = 3
$

2. Вычисляем значение в точках $x_i, i = 0,...,2$
$
  f(x_0) = (0-2)^2 &= 4\
  f(x_1) = (2-2)^2 &=0\
  f(x_2) = (3-2)^2 &=1
$

3. Находим $f^ast = min(f(x_0), f(x_1), f(x_2))$

$
  f^ast &= min(4, 0, 1) = 0\
        &=> x^ast = x_1 = 2, f^ast = 0
$
Ответ: $x^ast = 2, f^ast = 0$

== 1.2 Функция $f(x) = sin 2pi x - 2pi e^(x-1) -> min, x in [0.5, 1.5]$
Эта функция трансцендентная и её производная тоже, поэтому аналитического решения нет. Я буду решать через метод деления отрезка пополам.

== Решение

#let func_2(x) = {
  calc.sin(2 * calc.pi * x) - 2 * calc.pi * calc.exp(x - 1)
}

#let bisection_method(l, r, f, epsilon: 0.1) = {
  let iteration = 1
  while (r - l) / 2 >= epsilon {
    let x = (l + r) / 2
    let x_1 = x - epsilon
    let x_2 = x + epsilon

    if f(x_1) < f(x_2) {
      r = x
    } else {
      l = x
    }
    iteration += 1
  }
  ((l + r) / 2, f((l + r) / 2), iteration)
}

#let xs = lq.linspace(0.5, 1.5, num: 1000)

#figure(
  caption: [График функции $sin 2pi x - 2pi e^(x - 1), x in [0.5, 1.5]$],
  lq.diagram(width: 14cm, height: 7cm, margin: (x: 0%), lq.plot(xs, func_2, mark: none)),
)

Решение для $epsilon = epsilon_1 = 0.1$

Формулы для вычисления точек:
$
  x_1 &= (a + b)/2 - epsilon\
  x_2 &= (a + b)/2 + epsilon
$

#let epsilon_1 = 0.1
#let epsilon_2 = 0.001

#let calc_x(a, b) = {
  (a + b) / 2
}

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
    [0.5],
    [1.5],
    [#calc.round((1.5 - 0.5) / 2, digits: 2)],
    [#calc.round(calc_x(0.5, 1.5) - epsilon_1, digits: 3)],
    [#calc.round(calc_x(0.5, 1.5) + epsilon_1, digits: 3)],
    [#calc.round(func_2(0.9), digits: 3)],
    [#calc.round(func_2(1.1), digits: 3)],
    [$f(x_1) > f(x_2)$],
    [2],
    [1],
    [1.5],
    [#calc.round((1.5 - 1) / 2, digits: 2)],
    [#calc.round(calc_x(1, 1.5) - epsilon_1, digits: 3)],
    [#calc.round(calc_x(1, 1.5) + epsilon_1, digits: 3)],
    [#calc.round(func_2(1.15), digits: 3)],
    [#calc.round(func_2(1.35), digits: 3)],
    [$f(x_1) > f(x_2)$],
    [3],
    [#calc.round((1 + 1.5) / 2, digits: 3)],
    [1.5],
    [#calc.round((1.5 - 1.25) / 2, digits: 3)],
    [#calc.round(calc_x(1.375, 1.5) - epsilon_1, digits: 3)],
    [#calc.round(calc_x(1.375, 1.5) + epsilon_1, digits: 3)],
    [#calc.round(func_2(1.338), digits: 3)],
    [#calc.round(func_2(1.538), digits: 3)],
    [$f(x_1) > f(x_2)$],
    [4],
    [#calc.round((1.375 + 1.5) / 2, digits: 3)],
    [1.5],
    [#calc.round((1.5 - 1.375) / 2, digits: 3)],
    table.cell(colspan: 5)[$0.063 <= 0.1 "- точность достигнута"$],
  )),
) <table-epsilon-01>

Для расчета $x_min "при" epsilon = epsilon_2 = 0.001$ продолжим @table-epsilon-01[Таблицу] дальше с итерации 4.

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
    [4],
    [#calc.round((1.375 + 1.5) / 2, digits: 3)],
    [1.5],
    [#calc.round((1.5 - 1.375) / 2, digits: 3)],
    [#calc.round(calc_x(1.375, 1.5) - epsilon_2, digits: 3)],
    [#calc.round(calc_x(1.375, 1.5) + epsilon_2, digits: 3)],
    [#calc.round(func_2(1.437), digits: 3)],
    [#calc.round(func_2(1.439), digits: 3)],
    [$f(x_1) > f(x_2)$],
    [5],
    [#calc.round((1.438 + 1.5) / 2, digits: 3)],
    [1.5],
    [#calc.round((1.5 - 1.438) / 2, digits: 3)],
    [#calc.round(calc_x(1.438, 1.5) - epsilon_2, digits: 3)],
    [#calc.round(calc_x(1.438, 1.5) + epsilon_2, digits: 3)],
    [#calc.round(func_2(1.468), digits: 3)],
    [#calc.round(func_2(1.47), digits: 3)],
    [$f(x_1) > f(x_2)$],
    [6],
    [#calc.round((1.469 + 1.5) / 2, digits: 3)],
    [1.5],
    [#calc.round((1.5 - 1.469) / 2, digits: 3)],
    [#calc.round(calc_x(1.469, 1.5) - epsilon_2, digits: 3)],
    [#calc.round(calc_x(1.469, 1.5) + epsilon_2, digits: 3)],
    [#calc.round(func_2(1.484), digits: 3)],
    [#calc.round(func_2(1.486), digits: 3)],
    [$f(x_1) > f(x_2)$],
    [7],
    [#calc.round((1.485 + 1.5) / 2, digits: 3)],
    [1.5],
    [#calc.round((1.5 - 1.485) / 2, digits: 3)],
    [#calc.round(calc_x(1.485, 1.5) - epsilon_2, digits: 3)],
    [#calc.round(calc_x(1.485, 1.5) + epsilon_2, digits: 3)],
    [#calc.round(func_2(1.492), digits: 3)],
    [#calc.round(func_2(1.494), digits: 3)],
    [$f(x_1) > f(x_2)$],
    [8],
    [#calc.round((1.493 + 1.5) / 2, digits: 3)],
    [1.5],
    [#calc.round((1.5 - 1.493) / 2, digits: 3)],
    [#calc.round(calc_x(1.493, 1.5) - epsilon_2, digits: 3)],
    [#calc.round(calc_x(1.493, 1.5) + epsilon_2, digits: 3)],
    [#calc.round(func_2(1.496), digits: 3)],
    [#calc.round(func_2(1.498), digits: 3)],
    [$f(x_1) > f(x_2)$],
    [9],
    [#calc.round((1.497 + 1.5) / 2, digits: 4)],
    [1.5],
    [#calc.round((1.5 - 1.497) / 2, digits: 4)],
    [#calc.round(calc_x(1.497, 1.5) - epsilon_2, digits: 3)],
    [#calc.round(calc_x(1.497, 1.5) + epsilon_2, digits: 3)],
    [#calc.round(func_2(1.498), digits: 3)],
    [#calc.round(func_2(1.499), digits: 3)],
    [$f(x_1) > f(x_2)$],
    [10],
    [#calc.round((1.4985 + 1.5) / 2, digits: 4)],
    [1.5],
    [#calc.round((1.5 - 1.4985) / 2, digits: 4)],
    table.cell(colspan: 5)[$0.0008 <= 0.001 "- точность достигнута"$],
  )),
) <table-epsilon-001>

== Самопроверка

#figure(caption: [Метод деления отрезка пополам на языке `typst`], ```typ
// Определение функции
#let func_2(x) = {
  calc.sin(2 * calc.pi * x) - 2 * calc.pi * calc.exp(x - 1)
}

// Метод деления отрезка пополам
#let bisection_method(l, r, f, epsilon: 0.1) = {
  let iteration = 1
  while (r - l) / 2 >= epsilon {
    let x = (l + r) / 2
    let x_1 = x - epsilon
    let x_2 = x + epsilon

    if f(x_1) < f(x_2) {
      r = x
    } else {
      l = x
    }
    iteration += 1
  }
  ((l + r) / 2, f((l + r) / 2), iteration) // возвращаем x_min, f(x_min), кол-во итераций
}

// Вызов метода для функции func_2
#let res_1 = bisection_method(0.5, 1.5, func_2)
#let (x_min_1, y_min_1, iterations_1) = res_1

#let res_2 = bisection_method(0.5, 1.5, func_2, epsilon: 0.001)
#let (x_min_2, y_min_2, iterations_2) = res_2
```)

#let res_1 = bisection_method(0.5, 1.5, func_2)
#let (x_min_1, y_min_1, iterations_1) = res_1

#let res_2 = bisection_method(0.5, 1.5, func_2, epsilon: 0.001)
#let (x_min_2, y_min_2, iterations_2) = res_2

Для самопроверки алгоритма и результатов вычисления вручную воспользуемся модулем optimize#footnote[https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.html] библиотеки scipy@scipy-2020. Работа с модулем и решения представлены в @scipy-brents-algorithm[Листинге]. Алгоритм решения - алгоритм Брента Р.@wikipedia-brent

#codly-range(1, end: 42)
#let main = read("./main.py")

#figure(caption: [Алгоритм минимизации из библиотеки `scipy`.], raw(main, lang: "python", block: true)) <scipy-brents-algorithm>

#figure(caption: [Результаты работы метода деления отрезка пополам], table(
  fill: (_, y) => { if calc.odd(y) { luma(240) } else { white } },
  columns: (auto, auto, auto, auto, auto),
  table.header([Способ расчета], [$x_min$], [$f(x_min)$], [Кол-во итераций], [Точность $epsilon$]),
  ["Вручную"],
  [1.438],
  [#calc.round(func_2(1.438), digits: 4)],
  [4],
  [$0.1$],
  ["Вручную"],
  [1.4993],
  [#calc.round(func_2(1.4993), digits: 3)],
  [10],
  [$0.001$],
  [Алгоритм `bisection_method`],
  [#x_min_1],
  [#calc.round(y_min_1, digits: 3)],
  [#iterations_1],
  [$0.1$],
  [Алгоритм `bisection_method`],
  [#calc.round(x_min_2, digits: 3)],
  [#calc.round(y_min_2, digits: 3)],
  [#iterations_2],
  [$0.001$],
  [Алгоритм Брента из `scipy`],
  [#calc.round(1.4442719099991588, digits: 4)],
  [#calc.round(-9.454674225229954, digits: 3)],
  [6],
  [$0.1$],
  [Алгоритм Брента из `scipy`],
  [#calc.round(1.499600218135197, digits: 4)],
  [#calc.round(-10.352568761729087, digits: 3)],
  [16],
  [$0.001$],
))<table-results-comparison>

Исходный код проекта можнонайти в репозитории https://github.com/yan-aint-nickname/uni в директории optimization-methods/task2.
#bibliography("bibliography.yaml")
