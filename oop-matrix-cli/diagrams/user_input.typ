// https://xkcd.com/1195/
#import "@preview/fletcher:0.4.3" as fletcher: diagram, node, edge

#import fletcher.shapes: diamond, parallelogram
#set text(font: "Comic Neue", weight: 600)

#let user_input = diagram(
  node-stroke: 1pt,
  edge-stroke: 1pt,
  node((0,0), [Получить пользовательский ввод], extrude: (-2, 0)),
  edge("--"),
  node((0,1), [Начало], corner-radius: 10pt),
  edge("-|>"),
  node((0,2), [Ввод `maxValue`], shape: parallelogram.with(angle: 30deg)),
  edge("-|>"),
  node((0,3), align(center)[
    Ошибка\ ввода
  ], shape: diamond),
  edge("-|>", [Нет]),
  node((0,4), [Ввод `D`], shape: parallelogram.with(angle: 30deg)),
  edge("-|>"),
  node((0,5), align(center)[
    Ошибка\ ввода
  ], shape: diamond),
  edge("-|>", [Нет]),
  node((0,6), [Ввод `Q`], shape: parallelogram.with(angle: 30deg)),
  edge("-|>"),
  node((0,7), align(center)[
    Ошибка\ ввода
  ], shape: diamond),
  edge("-|>", [Нет]),
  node((0,8), [Вернуть `0`], shape: parallelogram.with(angle: 30deg)),
  edge("-|>"),
  node((0,9), [Конец], corner-radius: 10pt),
  edge((0,5), (-1,5), (-1,8), "-|>", [Да], label-pos: 0.1),
  edge((0,3), (-1,3), (-1,8), "-|>", [Да], label-pos: 0.1),
  node((-1,8), [Вернуть `1`], shape: parallelogram.with(angle: 30deg)),
  edge((-1,8), (-1,8.5), (0,8.5), (0,9), "-|>"),
  edge((0,7), (-1,7), (-1,8), "-|>", [Да], label-pos: 0.1),
)