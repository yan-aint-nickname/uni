// https://xkcd.com/1195/
#import "@preview/fletcher:0.4.3" as fletcher: diagram, node, edge

#import fletcher.shapes: diamond, parallelogram
#set text(font: "Comic Neue", weight: 600)

#let count_values = diagram(
  node-stroke: 1pt,
  edge-stroke: 1pt,
  node((0,0), [Посчитать кол-во элементов\ матриц A, B больше D, Q], extrude: (-2, 0)),
  edge("--"),
  node((0,1), [Начало], corner-radius: 10pt),
  edge("-|>"),
  node((0,2), [`count = 0`]),
  edge("-|>"),
  node((0,3), align(center)[
    `i < rows`
  ], shape: diamond),

  edge("-|>", [Да]),
  node((0,4), [`j = 0`]),
  edge("-|>"),
  node((0,5), align(center)[
    `j < columns`
  ], shape: diamond),
  edge("-|>", [Да]),
  node((0,6), align(center)[
    `values[i][j] > X`
  ], shape: diamond),
  edge("-|>", [Да]),
  node((0,7), [`count = count + 1`]),
  edge("-|>"),
  node((0,8), [`j = j + 1`]),
  node((0,9), [`i = i + 1`]),
  edge((0,5), (-2,5), (-2,9), (0,9), "-|>", [Нет], label-pos: 0.1),
  edge((0,8), (1,8), (1,5), (0,5), "-|>"),
  edge((0,3), (-3,3), (-3,10), (0,10), (0,11), "-|>", [Нет], label-pos: 0.1),
  edge((0,6), (-1,6), (-1,8), (0,8), "-|>", [Нет], label-pos: 0.1),
  edge((0,9), (2,9), (2,3), (0,3), "-|>"),
  node((0,11), [Вернуть `count`]),
  edge("-|>"),
  node((0,12), [Конец], corner-radius: 10pt),
)