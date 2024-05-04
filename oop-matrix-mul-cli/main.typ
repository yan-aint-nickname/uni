#import "template.typ": *

#import "@preview/codelst:2.0.1": sourcecode, sourcefile

#import "diagrams/main.typ" as main_algo
#import "diagrams/user_input.typ" as input_algo
#import "diagrams/fill_matrix.typ" as fill_algo
#import "diagrams/count_values.typ" as count_algo

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Объектно-ориентированное программирование. КМ-4. Более сложные элементы программирования.",
  authors: (
    "Кирш Я.А. ИДз-21-21. Вариант 8",
  ),
)

#show figure: set block(breakable: true)

= Задание
Работа выполняется по заданию из Семинара 3. Написать программу произведения матрицы на вектор.

== Комментарии

- Полный код программы находится в репозитории https://github.com/yan-aint-nickname/uni см.директорию: `oop-matrix-mul-cli`

- Для компиляции я использовал https://ziglang.org/
- Библиотека для тестирования https://github.com/sheredom/utest.h/

- Для дальнейшей работы мне необходимо сделать допущение для векторов, столбцовых и строковых матриц:

/ $n$ : - кол-во строк/столбцов вектора
$ZZ^n tilde.equiv ZZ^(n times 1) tilde.equiv ZZ^(1 times n)$\

Алгоритм перемножения матрицы на вектор:
$
mat(
  a_(0 0), a_(0 1), ..., a_(0 n);
  a_(1 0), a_(1 1), ..., a_(1 n);
  dots.v, dots.v, dots.down, dots.v;
  a_(m 0), a_(m 1), ..., a_(m n);
) times vec(b_0, b_1, dots.v, b_n) = vec(
  c_0 = a_(0 0) dot.op b_0 + a_(0 1) dot.op b_1 + ... + a_(0 n) dot.op b_n,
  c_1 = a_(1 0) dot.op b_0 + a_(1 1) dot.op b_1 + ... + a_(1 n) dot.op b_n,
  dots.v,
  c_n = a_(m 0) dot.op b_0 + a_(m 1) dot.op b_1 + ... + a_(m n) dot.op b_n)\
  c_i = sum^n_(k=0)a_(i k)b_k
$


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
== Ответы на вопросы
