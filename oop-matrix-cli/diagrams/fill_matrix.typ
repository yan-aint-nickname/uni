// https://xkcd.com/1195/
#import "@preview/fletcher:0.4.3" as fletcher: diagram, node, edge

#import fletcher.shapes: diamond, parallelogram
#set text(font: "Comic Neue", weight: 600)

#let fill_matrix = diagram(
  node-stroke: 1pt,
  edge-stroke: 1pt,
  node((0,0), [Заполнить матрицы\ случайными числами], extrude: (-2, 0)),
  edge("--"),
  node((0,1), [Начало], corner-radius: 10pt),
  edge("-|>"),
  node((0,2), [`i = 0`]),
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
  node((0,6), [`values[i][j] = rand%100`]),
  edge("-|>"),
  node((0,7), [`j = j + 1`]),
  node((0,8), [`i = i + 1`]),
  edge((0,5), (-1,5), (-1,8), (0,8), "-|>", [Нет], label-pos: 0.1),
  edge((0,7), (1,7), (1,5), (0,5), "-|>"),
  edge((0,3), (-2,3), (-2, 9), (0,9), (0,10), "-|>", [Нет], label-pos: 0.1),
  edge((0,8), (2,8), (2,3), (0,3), "-|>"),
  node((0,10), [Конец], corner-radius: 10pt),
)