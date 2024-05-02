// https://xkcd.com/1195/
#import "@preview/fletcher:0.4.3" as fletcher: diagram, node, edge

#import fletcher.shapes: diamond, parallelogram
#set text(font: "Comic Neue", weight: 600)

#let chart_main = diagram(
  node-stroke: 1pt,
  edge-stroke: 1pt,
  node((0,0), [Начало], corner-radius: 10pt),
  edge("-|>"),
  node((0,1), [Инициализировать генератор\ псевдо-случайных чисел]),
  edge("-|>"),
  node((0,3), [Объявить матрицы A и B]),
  edge("-|>"),
  node((0,4), [Заполнить матрицы\ случайными числами], extrude: (-2, 0)),
  edge("-|>"),
  node((0,5), [Получить пользовательский ввод], extrude: (-2, 0)),
  edge("-|>"),
  node((0,6), align(center)[
    Ошибка\ ввода
  ], shape: diamond),
  edge("l,d", "-|>", [Да]),
  node((-1,7), [Ошибка], corner-radius: 10pt),
  edge((0, 6), (0, 8), "-|>", [Нет]),
  node((0, 8), [Посчитать кол-во элементов\ матриц A, B больше D, Q], extrude: (-2, 0)),
  edge("-|>"),
  node((0,9), [D, countA, Q, countB], shape: parallelogram.with(angle: 30deg)),
  edge("-|>"),
  node((0,10), [Конец], corner-radius: 10pt),
)