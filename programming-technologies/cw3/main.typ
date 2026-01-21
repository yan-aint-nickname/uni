#import "template.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#import "@preview/codly:1.3.0": *
#show: codly-init

#show: project.with(
  title: [Разработка простой программы с использованием структурного подхода.],
  discipline: [Технология программирования],
  work-number: "3",
  authors: ((position: "Студент группы ИДз-21-21", full_name: "Кирш Я.А."),),
  instructors: ((position: "Доцент кафедры Вычислительных машин, систем и сетей НИУ \"МЭИ\"", full_name: "Раскатова М. В."),),
  year: 2025,
)
#set enum(numbering: "1.a.")
#show figure: set block(breakable: true)

#set page(numbering: "1")
#counter(page).update(1)

#outline()

Исходный код проекта можно найти в репозитории https://github.com/yan-aint-nickname/uni в директории programming-technologies/cw3.

= Задание 1

#include "task_1/main.typ"

= Задание 2

#include "task_2/main.typ"

#bibliography("bibliography.yaml")
