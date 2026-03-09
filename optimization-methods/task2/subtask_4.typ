#import "utils.typ": fib, func_3
#import "@preview/codly:1.3.0": *

#let calc_lambda_fib(a, b, n, k) = {
  a + (fib(n - k - 1) / fib(n - k + 1)) * (b - a)
}
#let calc_mu_fib(a, b, n, k) = {
  a + (fib(n - k) / fib(n - k + 1)) * (b - a)
}

#let find_n_by_epsilon(a, b, epsilon) = {
  let cond = (b - a) / epsilon
  let n = 0
  while (cond > fib(n)) {
    n += 1
  }
  n
}

#let calc_fibonacci_method(a, b, f, epsilon: 0.1) = {
  let n = find_n_by_epsilon(a, b, epsilon)
  let k = n - 1
  while (k >= 0) {
    let l = calc_lambda_fib(a, b, n, k)
    let m = calc_mu_fib(a, b, n, k)
    if f(l) > f(m) {
      a = l
    } else {
      b = m
    }
    k -= 1
  }

  let x_min = (a + b) / 2
  (x_min, f(x_min), n)
}

= Задание 4. Метод Фибоначчи. $f(x)=x^2 +2x - 4, x in [-2, 1]$

== Решение

#let (x_min_1, y_min_1, n_1) = calc_fibonacci_method(-2, 1, func_3)

#let (x_min_2, y_min_2, n_2) = calc_fibonacci_method(-2, 1, func_3, epsilon: 0.001)

Условие для поиска $n$:
$
  F_n >= (b-a)/epsilon
$

Найдем необходимое кол-во итераций:

$
  "для" epsilon &= 0.1 \
  F_n           &>= (1 + 2)/0.1 = 30 \
  F_8           &= #fib(8) \
  F_9           &= #fib(9) \
                &=> n = 9
$

$
  "для" epsilon &= 0.001 \
  F_n           &>= (1 + 2)/0.001 = 3000 \
  F_18          &= #fib(18) \
  F_19          &= #fib(19) \
                &=> n = #find_n_by_epsilon(-2, 1, 0.001)
$

#figure(
  caption: [Результаты вычислений для $epsilon = epsilon_1 = 0.1$],
  table(columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto), table.header(
    [Номер итерации],
    [a],
    [b],
    [$b-a$],
    [$lambda$],
    [$mu$],
    [$f(lambda)$],
    [$f(mu)$],
    [Сравнение $f(lambda)$ и $f(mu)$],
    [1],
    [-2],
    [1],
    [#calc.round(1 + 2, digits: 2)],
    [#calc.round(calc_lambda_fib(-2, 1, n_1, n_1 - 1), digits: 3)],
    [#calc.round(calc_mu_fib(-2, 1, n_1, n_1 - 1), digits: 3)],
    [#calc.round(func_3(-2), digits: 3)],
    [#calc.round(func_3(1), digits: 3)],
    [$f(lambda) < f(mu)$],
    [2],
    [-2],
    [1],
    [#calc.round(1 + 2, digits: 2)],
    [#calc.round(calc_lambda_fib(-2, 1, n_1, n_1 - 2), digits: 3)],
    [#calc.round(calc_mu_fib(-2, 1, n_1, n_1 - 2), digits: 3)],
    [#calc.round(func_3(-0.5), digits: 3)],
    [#calc.round(func_3(-0.5), digits: 3)],
    [$f(lambda) = f(mu)$],
    [3],
    [-2],
    [-0.5],
    [#calc.round(-0.5 + 2, digits: 2)],
    [#calc.round(calc_lambda_fib(-2, -0.5, n_1, n_1 - 3), digits: 3)],
    [#calc.round(calc_mu_fib(-2, -0.5, n_1, n_1 - 3), digits: 3)],
    [#calc.round(func_3(-1.5), digits: 3)],
    [#calc.round(func_3(-1), digits: 3)],
    [$f(lambda) > f(mu)$],
    [4],
    [-1.5],
    [-0.5],
    [#calc.round(-0.5 + 1.5, digits: 2)],
    [#calc.round(calc_lambda_fib(-1.5, -0.5, n_1, n_1 - 4), digits: 3)],
    [#calc.round(calc_mu_fib(-1.5, -0.5, n_1, n_1 - 4), digits: 3)],
    [#calc.round(func_3(-1.167), digits: 3)],
    [#calc.round(func_3(-0.833), digits: 3)],
    [$f(lambda) = f(mu)$],
    [5],
    [-1.5],
    [-0.9],
    [#calc.round(-0.9 + 1.5, digits: 2)],
    [#calc.round(calc_lambda_fib(-1.5, -0.9, n_1, n_1 - 5), digits: 3)],
    [#calc.round(calc_mu_fib(-1.5, -0.9, n_1, n_1 - 5), digits: 3)],
    [#calc.round(func_3(-1.275), digits: 3)],
    [#calc.round(func_3(-1.125), digits: 3)],
    [$f(lambda) > f(mu)$],
    [6],
    [-1.275],
    [-0.9],
    [#calc.round(-0.9 + 1.275, digits: 2)],
    [#calc.round(calc_lambda_fib(-1.275, -0.9, n_1, n_1 - 6), digits: 3)],
    [#calc.round(calc_mu_fib(-1.275, -0.9, n_1, n_1 - 6), digits: 3)],
    [#calc.round(func_3(-1.131), digits: 3)],
    [#calc.round(func_3(-1.044), digits: 3)],
    [$f(lambda) > f(mu)$],
    [7],
    [-1.132],
    [-0.9],
    [#calc.round(-0.9 + 1.132, digits: 2)],
    [#calc.round(calc_lambda_fib(-1.132, -0.9, n_1, n_1 - 7), digits: 3)],
    [#calc.round(calc_mu_fib(-1.132, -0.9, n_1, n_1 - 7), digits: 3)],
    [#calc.round(func_3(-1.044), digits: 3)],
    [#calc.round(func_3(-0.988), digits: 3)],
    [$f(lambda) > f(mu)$],
    [8],
    [-1.044],
    [-0.9],
    [#calc.round(-0.9 + 1.044, digits: 2)],
    [#calc.round(calc_lambda_fib(-1.044, -0.9, n_1, n_1 - 7), digits: 3)],
    [#calc.round(calc_mu_fib(-1.044, -0.9, n_1, n_1 - 7), digits: 3)],
    [#calc.round(func_3(-0.989), digits: 3)],
    [#calc.round(func_3(-0.955), digits: 3)],
    [$f(lambda) > f(mu)$],
    [9],
    [-1.044],
    [-0.955],
    [#calc.round(-0.955 + 1.044, digits: 2)],
    table.cell(colspan: 5)[$0.09 <= epsilon_1 = 0.1 "точность достигнута"$],
  )),
)

#figure(
  caption: [Результаты вычислений для $epsilon = epsilon_2 = 0.001$],
  table(columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto), table.header(
    [Номер итерации],
    [a],
    [b],
    [$b-a$],
    [$lambda$],
    [$mu$],
    [$f(lambda)$],
    [$f(mu)$],
    [Сравнение $f(lambda)$ и $f(mu)$],
    [9],
    [-1.044],
    [-0.955],
    [#calc.round(-0.955 + 1.044, digits: 2)],
    [#calc.round(calc_lambda_fib(-1.044, -0.955, n_1, n_1 - 9), digits: 5)],
    [#calc.round(calc_mu_fib(-1.044, -0.955, n_1, n_1 - 9), digits: 5)],
    [#calc.round(func_3(-1.01002), digits: 6)],
    [#calc.round(func_3(-0.98898), digits: 6)],
    [$f(lambda) < f(mu)$],
    [10],
    [-1.044],
    [-0.98898],
    [#calc.round(-0.98898 + 1.044, digits: 2)],
    [#calc.round(calc_lambda_fib(-1.044, -0.98898, n_1, n_1 - 10), digits: 5)],
    [#calc.round(calc_mu_fib(-1.044, -0.98898, n_1, n_1 - 10), digits: 5)],
    [#calc.round(func_3(-1.02298), digits: 6)],
    [#calc.round(func_3(-1.01), digits: 6)],
    [$f(lambda) > f(mu)$],
    [11],
    [-1.02298],
    [-0.98898],
    [#calc.round(-0.98898 + 1.02298, digits: 3)],
    [#calc.round(calc_lambda_fib(-1.02298, -0.98898, n_1, n_1 - 11), digits: 5)],
    [#calc.round(calc_mu_fib(-1.02298, -0.98898, n_1, n_1 - 11), digits: 5)],
    [#calc.round(func_3(-1.00999), digits: 6)],
    [#calc.round(func_3(-1.00197), digits: 6)],
    [$f(lambda) > f(mu)$],
    [12],
    [-1.00999],
    [-0.98898],
    [#calc.round(-0.98898 + 1.00999, digits: 3)],
    [#calc.round(calc_lambda_fib(-1.00999, -0.98898, n_1, n_1 - 12), digits: 5)],
    [#calc.round(calc_mu_fib(-1.00999, -0.98898, n_1, n_1 - 12), digits: 5)],
    [#calc.round(func_3(-1.00196), digits: 6)],
    [#calc.round(func_3(-0.99701), digits: 6)],
    [$f(lambda) < f(mu)$],
    [13],
    [-1.00999],
    [-0.99701],
    [#calc.round(-0.99701 + 1.00999, digits: 3)],
    [#calc.round(calc_lambda_fib(-1.00999, -0.99701, n_1, n_1 - 13), digits: 5)],
    [#calc.round(calc_mu_fib(-1.00999, -0.99701, n_1, n_1 - 13), digits: 5)],
    [#calc.round(func_3(-1.00503), digits: 6)],
    [#calc.round(func_3(-1.00197), digits: 6)],
    [$f(lambda) > f(mu)$],
    [14],
    [-1.00503],
    [-0.99701],
    [#calc.round(-0.99701 + 1.00503, digits: 3)],
    [#calc.round(calc_lambda_fib(-1.00503, -0.99701, n_1, n_1 - 14), digits: 5)],
    [#calc.round(calc_mu_fib(-1.00503, -0.99701, n_1, n_1 - 14), digits: 5)],
    [#calc.round(func_3(-1.00197), digits: 6)],
    [#calc.round(func_3(-1.00007), digits: 6)],
    [$f(lambda) > f(mu)$],
    [15],
    [-1.00197],
    [-0.99701],
    [#calc.round(-0.99701 + 1.00197, digits: 3)],
    [#calc.round(calc_lambda_fib(-1.00197, -0.99701, n_1, n_1 - 15), digits: 5)],
    [#calc.round(calc_mu_fib(-1.00197, -0.99701, n_1, n_1 - 15), digits: 5)],
    [#calc.round(func_3(-1.00008), digits: 6)],
    [#calc.round(func_3(-0.9989), digits: 6)],
    [$f(lambda) < f(mu)$],
    [16],
    [-1.00197],
    [-0.9989],
    [#calc.round(-0.9989 + 1.00197, digits: 3)],
    [#calc.round(calc_lambda_fib(-1.00197, -0.9989, n_1, n_1 - 16), digits: 5)],
    [#calc.round(calc_mu_fib(-1.00197, -0.9989, n_1, n_1 - 16), digits: 5)],
    [#calc.round(func_3(-1.00008), digits: 6)],
    [#calc.round(func_3(-1.00007), digits: 6)],
    [$f(lambda) = f(mu)$],
    [17],
    [-1.0008],
    [-0.9989],
    [#calc.round(-0.9989 + 1.0008, digits: 3)],
    [#calc.round(calc_lambda_fib(-1.0008, -0.9989, n_1, n_1 - 17), digits: 5)],
    [#calc.round(calc_mu_fib(-1.0008, -0.9989, n_1, n_1 - 17), digits: 5)],
    [#calc.round(func_3(-1.00007), digits: 6)],
    [#calc.round(func_3(-0.99963), digits: 6)],
    [$f(lambda) = f(mu)$],
    [18],
    [-1.0008],
    [-0.99963],
    [#calc.round(-0.99963 + 1.0008, digits: 4)],
    [#calc.round(calc_lambda_fib(-1.0008, -0.99963, n_1, n_1 - 18), digits: 5)],
    [#calc.round(calc_mu_fib(-1.0008, -0.99963, n_1, n_1 - 18), digits: 5)],
    [#calc.round(func_3(-1.00035), digits: 6)],
    [#calc.round(func_3(-1.00008), digits: 6)],
    [$f(lambda) = f(mu)$],
    [19],
    [-1.00035],
    [-0.99963],
    [#calc.round(-0.99963 + 1.00035, digits: 4)],
    table.cell(colspan: 5)[$0.0007 <= epsilon = 0.001 "точность достигнута"$],
  )),
)

#codly-range(4, end: 36)
#let main = read("./subtask_4.typ")

#figure(caption: [Метод Фибоначчи на языке `typst`.], raw(main, lang: "typst", block: true)) <fibonacci-listing>

Данные для сравнения метода Фибоначчи отражены в @table-subtask-4-results-comparison, для сравнения с другими методами см. @table-subtask-2-results-comparison. Алгоритм программы представлен на @fibonacci-listing.

#figure(caption: [Сравнительная таблица методов нахождения минимума функции], table(
  fill: (_, y) => { if calc.odd(y) { luma(240) } else { white } },
  columns: (auto, auto, auto, auto, auto, auto),
  table.header([Метод], [$x_min$], [$f(x_min)$], [Кол-во итераций], [Точность $epsilon$], [Способ]),
  [Фибоначчи],
  [#calc.round((-0.955 - 1.044) / 2, digits: 4)],
  [#calc.round(func_3(-0.9995), digits: 5)],
  [9],
  [$0.1$],
  ["Вручную"],
  [Фибоначчи],
  [#calc.round((-0.99963 - 1.00035) / 2, digits: 6)],
  [#calc.round(func_3(-0.99999), digits: 6)],
  [19],
  [$0.001$],
  ["Вручную"],
  [Фибоначчи],
  [#calc.round(x_min_1, digits: 4)],
  [#calc.round(y_min_1, digits: 4)],
  [#n_1],
  [$0.1$],
  [Программа],
  [Фибоначчи],
  [#calc.round(x_min_2, digits: 6)],
  [#calc.round(y_min_2, digits: 6)],
  [#n_2],
  [$0.001$],
  [Программа],
  [Деление отрезка пополам],
  [#calc.round(-0.969, digits: 4)],
  [#calc.round(-4.999, digits: 4)],
  [5],
  [$0.1$],
  ["Вручную"],
  [Деление отрезка пополам],
  [#calc.round(-0.997, digits: 6)],
  [#calc.round(-4.99999, digits: 6)],
  [12],
  [$0.001$],
  ["Вручную"],
))<table-subtask-4-results-comparison>

== Выводы


В данной задаче был применён метод Фибоначчи для поиска минимума функции $f(x) = x^2 + 2x -4$ на заданном интервале.

Особенностью метода Фибоначчи является то, что количество итераций заранее определяется с использованием чисел Фибоначчи и зависит от требуемой точности.

Полученные результаты показывают, что метод позволяет эффективно сужать интервал поиска и находить значение минимума функции с заданной точностью. Найденное значение $x approx -1$ совпадает с аналитическим решением и результатами, полученными методом деления отрезка пополам.

Таким образом, метод Фибоначчи является эффективным численным методом одномерной оптимизации, особенно в задачах, где заранее известно требуемое количество итераций.

Хочется также отмеить, что вычисление чисел Фибоначии можно оптимизировать через матричную форму $mat(F_n+1, F_n;F_n, F_n-1)^n = mat(1, 1;1, 0)^n$ или через мемоизацию, что позволит сократить скорость вычисления с $O(n) "до" O(log(n))$, где $n$ - номер числа Фибоначчи @dijkstra-ewd654.
