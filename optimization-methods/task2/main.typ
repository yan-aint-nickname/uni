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
#set math.equation(numbering: "(1)")
#set heading(numbering: "1.")

#set page(numbering: "1")
#counter(page).update(1)

#outline()

= Цель работы

Изучение и практическое применение методов одномерной оптимизации без использования производных: метода деления отрезка пополам, метода золотого сечения и метода Фибоначчи, а также сравнение их эффективности при нахождении минимума функции.

#include "subtask_1.typ"
#include "subtask_2.typ"
#include "subtask_3.typ"
#include "subtask_4.typ"

Исходный код проекта можно найти в репозитории https://github.com/yan-aint-nickname/uni в директории optimization-methods/task2.
#bibliography("bibliography.yaml", style: "gost-r-705-2008-numeric")
