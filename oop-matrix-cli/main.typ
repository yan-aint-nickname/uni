#import "template.typ": *

#import "@preview/codelst:2.0.1": sourcecode

#import "diagrams/main.typ" as main_algo
#import "diagrams/user_input.typ" as input_algo
#import "diagrams/fill_matrix.typ" as fill_algo
#import "diagrams/count_values.typ" as count_algo

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Объектно-ориентированное программирование. КМ-2. Разработка простейших консольных программ с использованием ООП",
  authors: (
    "Кирш Я.А. ИДз-21-21. Вариант 8",
  ),
)

#show figure: set block(breakable: true)

= Задание
Для каждой строки матрицы $A$ ($5 times 8$) "определить число элементов, больших $D$, а для каждой строки матрицы $B$ ($7 times 5$) "определить число элементов, больших $Q$; $D, Q$ — заданные значения.


== Код программы

=== Заголовочный файл
#let code = raw(read("tool.h"))
#sourcecode(
  lang: "cpp",
)[#code]

=== Реализация
#let code = raw(read("tool.cc"))
#sourcecode(
  lang: "cpp",
)[#code]

#pagebreak()
== Модульное тестирование

#let tests = raw(read("tool_test.cc"))
#sourcecode(
  lang: "cpp",
)[#tests]

#pagebreak()
== Блок-схемы

#figure(
  main_algo.chart_main,
  caption: "Схема работы всей программы",
)

#figure(
  input_algo.user_input,
  caption: "Схема работы программы для получения пользовательского ввода",
)

#figure(
  fill_algo.fill_matrix,
  caption: "Схема работы программы для заполнения матрицы",
)

#figure(
  count_algo.count_values,
  caption: "Схема работы программы для подсчета элементов больше задачнных значений",
)
