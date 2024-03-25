#import "template.typ": *
#import "@preview/cetz:0.2.0" as cetz

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Объектно-ориентированное программирование. КМ-2. Разработка простейших консольных программ с использованием ООП",
  authors: (
    "Кирш Я.А. ИДз-21-21. Вариант 8",
  ),
)

= Задание
Для каждой строки матрицы $A$ ($5 times 8$) "определить число элементов, больших $D$, а для каждой строки матрицы $B$ ($7 times 5$) "определить число элементов, больших $Q$; $D, Q$ — заданные значения.

#let text = read("main.cc")
#let code = raw(text, lang: "cpp")

#code
// #figure(code, caption: "Код программы")