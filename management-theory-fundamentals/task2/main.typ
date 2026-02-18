#import "template.typ": *
#import "@preview/lilaq:0.5.0" as lq
#import "@preview/tiptoe:0.3.1"

#import "@preview/codly:1.3.0": *
#show: codly-init

#show: project.with(
  title: [Однокритериальная модель для оптимального планирования.],
  discipline: [Основы теории управления],
  work-number: "2",
  authors: ((position: "Студент группы ИДз-21-21", full_name: "Кирш Я.А."),),
  instructors: ((
    position: "Доцент кафедры Менеджмента в энергетике и промышленности НИУ \"МЭИ\"",
    full_name: "Знаменская М. А.",
  ),),
  year: 2025,
)
#set enum(numbering: "1.a.")
// #show figure: set block(breakable: true)

#set page(numbering: "1")
#counter(page).update(1)

#outline()

= Задание
Вариант 13.

Банк имеет финансовые ресурсы в размере 60 млн. руб. и может
инвестировать их в два проекта. При инвестировании в первый проект
прибыль составляет 30% годовых, при инвестировании во второй проект − 35%
годовых. Для обеспечения ликвидности в первый проект нужно инвестировать
не менее средств, чем во второй проект. С учетом налоговой политики, в
первый проект необходимо инвестировать не меньше 20% имеющихся средств
и не более 90% имеющихся средств. В оба проекта необходимо инвестировать
не менее 30% всех имеющихся средств.

Задачи:
1. Определить, какое количество финансовых средств должно быть
инвестировано в каждый из проектов с целью получения _максимальной_
прибыли.
2. Определить, какое количество финансовых средств должно быть
инвестировано в каждый из проектов с целью получения _минимальной_
прибыли.

= Решение

$
  "Целевая функция" f(x_1, x_2) = 0.3 dot x_1 + 0.35 dot x_2 -> max \
  f(x_1, x_2) = 0.3 dot x_1 + 0.35 dot x_2 -> min&
$
$
  "Набор ограничений" S = cases(x_1 + x_2 <= 60, x_1 >= 12, x_1 <= 54, x_1 >= x_2, x_1 + x_2 >= 18, x_2 >= 0)
$

#let xs = lq.linspace(0, 60)
#let l1 = lq.line((0, 18), (18, 0))
#let l2 = lq.line((0, 60), (60, 0))
#let l3 = lq.line((0, 0), (60, 60))
#let l4 = lq.line((54, 0), (54, 60))
#let l5 = lq.line((12, 0), (12, 60))
#let points = ("E", "A", "D", "F", "B", "C")

#let marks_x = (12, 30, 54, 54, 18, 12)
#let marks_y = (12, 30, 6, 0, 0, 6)

#let gradient = lq.line((0, 0), (30, 35), tip: tiptoe.stealth, stroke: green)

#let s_area = lq.plot((..marks_x, marks_x.at(0)), (..marks_y, marks_y.at(0)), stroke: blue + 1.5pt, mark: none)

#figure(lq.diagram(
  gradient,
  l1,
  l2,
  l3,
  l4,
  l5,
  lq.place(30, 35, align: bottom, pad(4pt)[$(0.3, 0.35)$]),
  s_area,
  ..range(points.len()).map(i =>
  lq.place(marks_x.at(i), marks_y.at(i), align: bottom + right, pad(4pt)[#points.at(i)])),
  xlim: (1, 60),
  ylim: (1, 60),
  xlabel: $x_1, c_1$,
  ylabel: $x_2, c_2$,
  width: 80%,
), caption: [Область допустимых решенией (выделена синим)])

== Вычисляем целевую функцию в точках

$
  A = cases(x_1 + x_2 = 60, x_1 = x_2) => x_1 = 30 = x_2 \
  B = cases(x_1 + x_2 = 18, x_2 = 0) => x_1 = 18, x_2 = 0 \
  C = cases(x_1 = 12, x_1 + x_2 = 18) => x_1 = 12, x_2 = 6 \
  D = cases(x_1 = 54, x_1 + x_2 = 60) => x_1 = 54, x_2 = 6 \
  F = cases(x_2 = 0, x_1 + x_2 = 60) => x_1 = 60, x_2 = 0 \
  E = cases(x_1 = x_2, x_1 = 12) => x_1 = 12 = x_2
$

#let f_E = calc.round(0.3 * 12 + 0.35 * 12, digits: 3)
#let f_A = calc.round(0.3 * 30 + 0.35 * 30, digits: 3)
#let f_D = calc.round(0.3 * 54 + 0.35 * 6, digits: 3)
#let f_F = calc.round(0.3 * 60 + 0.35 * 0, digits: 3)
#let f_B = calc.round(0.3 * 18 + 0.35 * 0, digits: 3)
#let f_C = calc.round(0.3 * 12 + 0.35 * 6, digits: 3)

$
  f(E) = 0.3 * 12 + 0.35 * 12=#f_E \
  f(A) = 0.3 * 30 + 0.35 * 30=#f_A \
  f(D) = 0.3 * 54 + 0.35 * 6=#f_D \
  f(F) = 0.3 * 60 + 0.35 * 0=#f_F \
  f(B) = 0.3 * 18 + 0.35 * 0=#f_B \
  f(C) = 0.3 * 12 + 0.35 * 6=#f_C
$

== Находим максимальную прибыль

#let f_max = calc.max(f_E, f_A, f_D, f_F, f_B, f_C)

$
  max(f_E, f_A, f_D, f_F, f_B, f_C) = #f_max
$

== Находим минимальную прибыль

#let f_min = calc.min(f_E, f_A, f_D, f_F, f_B, f_C)

$
  min(f_E, f_A, f_D, f_F, f_B, f_C) = #f_min
$

= Самопроверка

Исходный код проекта можно найти в репозитории https://github.com/yan-aint-nickname/uni в директории management-theory-fundamentals/task2.

Для самопроверка воспользуемся модулем linprog #footnote[https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.linprog.html] библиотеки scipy @scipy-2020.

#let main = read("./main.py")

#figure(caption: [Алгоритм программы в `main.py`], raw(main, lang: "python", block: true))#bibliography("bibliography.yaml")
