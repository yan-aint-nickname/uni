#import "template.typ": *

#import "@preview/codelst:2.0.1": sourcecode, sourcefile

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

== Комментарии

- Полный код программы находится в репозитории https://github.com/yan-aint-nickname/uni

- Для компиляции я использовал https://ziglang.org/ 
- Библиотека для тестирования https://github.com/sheredom/utest.h/

== Код программы

=== Заголовочный файл

#figure(
  caption: "Заголовочный файл tool.hh",
  sourcefile(
    file: "tool.hh",
    read("tool.hh"),
  )
)

=== Реализация

#figure(
  caption: "Релазиация методов, алгоритма tool.cc",
  sourcefile(
    file: "tool.cc",
    read("tool.cc"),
  )
)

#figure(
  caption: "Точка входа программы main.cc",
  sourcefile(
    file: "main.cc",
    read("main.cc"),
  )
)

#pagebreak()
== Модульное тестирование

#figure(
  caption: "Модульное тестирования с использованием библиотеки utest.h",
  sourcefile(
    file: "tool_test.cc",
    read("tool_test.cc"),
  )
)

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
  caption: "Схема работы программы для подсчета элементов больше заданных значений",
)
