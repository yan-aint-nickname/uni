#import "template.typ": *
#import "@preview/lilaq:0.5.0" as lq
#import "@preview/tiptoe:0.3.1"

#import "@preview/codly:1.3.0": *
#show: codly-init

#show: project.with(
  title: [Однокритериальная модель для оптимального планирования.],
  discipline: [Методы оптимизации],
  work-number: "3",
  authors: ((position: "Студент группы ИДз-21-21", full_name: "Кирш Я.А."),),
  instructors: ((
    position: "Кандидат технических наук.\n Доцент кафедры Вычислительных машин, систем и сетей НИУ \"МЭИ\"",
    full_name: "Раскатова М. В.",
  ),),
  year: 2025,
)
#set enum(numbering: "1.a.")
#show figure: set block(breakable: true)

#set page(numbering: "1")
#counter(page).update(1)

#outline()

= Задание 1. Решение одноиндексной задачи линейного программирования.

== Найти решение для математической модели линейного программирования.
$
  L(X) = -45x_1 + 65x_2 +2x_4 -3x_5 -> max\

  cases(
    15x_1 + 18x_2+34x_4-22x_5 = 56,
    2x_1+7x_3-4x_4+3x_5>=91,
    0.2x_1+0.8x_2+1.5x_3+0.9x_4+4x_5 <=26,
    1.8x_1-42x_2+6.4x_3+3x_5 = 15,
    x_j >= 0(j in [1,5]),

  )
$

Решение задачи представлено в @listing_1 код выполнен на языке Python, с использование библиотеки scipy@scipy-2020. Дальше я приведу ответы.

$
  x_1 = 0, x_2 = 2.06564816, x_3 = 15.89956608, x_4 = 0.55348038, x_5 = 0\
  max(L(X)) = 135.3740914843609
$

== Решить задачу, если к условию задачи добавилось требование целочисленности значений всех переменных.

В данном случае нет решения, при условии целочисленности переменных не существует ни одной точки, которая удовлетворяла бы всем ограничениям одновременно.

= Задание 2. Решение задачи графическим методом.

$
  L(X) = -2x_1-x_2 -> min, max\

  cases(2x_1+4x_2<=16, -4x_1+2x_2<=8, x_1+3x_2>=9, 6x_1+5x_2=30, x_1\, x_2 >=0)
$

#let l1 = lq.line((-2, 42 / 5), (5, 0))
#let l2 = lq.line((-2, 0), (3, 10))
#let l3 = lq.line((-2, 11 / 3), (9, 0))
#let l4 = lq.line((-2, 5), (8, 0))
#let points = ("A", "B")

#figure(lq.diagram(
  l1,
  l2,
  l3,
  l4,
  lq.place(45 / 13, 24 / 13, align: bottom, pad(-12pt)[A]),
  lq.place(20 / 7, 18 / 7, align: bottom, pad(8pt)[B]),
  xlim: (-2, 10),
  ylim: (0, 10),
  xlabel: $x_1$,
  ylabel: $x_2$,
  width: 80%,
), caption: [Область допустимых решенией лежит на отрезке между точками A и B.])

== Вычисляем целевую функцию в точках

$
  A = cases(x_1 + 3x_2 = 9, 6x_1 + 5x_2 = 30) => x_1 = 45/13 approx 3.46, x_2 = 24/13 approx 1.84 \
  B = cases(2x_1+4x_2=16, 6x_1+5x_2=30) => x_1 = 20/7 approx 2.86, x_2 = 18/7 approx 2.57 \
$

#let f_A = calc.round(-2 * (45 / 13) - 24 / 13, digits: 3)
#let f_B = calc.round(-2 * (20 / 7) - 18 / 7, digits: 3)

$
  L(A) = -2*45/13-24/13approx#f_A \
  L(B) = -2*20/7-18/7approx=#f_B \
$

#let f_max = calc.max(f_A, f_B)
#let f_min = calc.min(f_A, f_B)

$
  max(f_A, f_B) &= #f_max\
  min(f_A, f_B) &= #f_min
$

Так же код для самопроверки находится в @listing_1 с комментарием "Задание 2".

= Приложение 1. Код программы.

#let main = read("./main.py")

#figure(
  caption: [Решение одноидексной задачи линейного программирования на языке Python с использованием пакета `scipy.optimize.linprog`],
  raw(main, lang: "python", block: true),
) <listing_1>

Исходный код проекта можно найти в репозитории https://github.com/yan-aint-nickname/uni в директории management-theory-fundamentals/task3.

#bibliography("bibliography.yaml")
