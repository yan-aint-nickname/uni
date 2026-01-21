#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: diamond, parallelogram, hexagon, circle, rect
#import "../utils.typ" as utils

=== Блок-схема алгоритма

#figure(
  diagram(
    node-stroke: 1pt,
    node-fill: white,
    edge-stroke: 1pt,
    spacing: (15mm, 12mm),
    node-shape: rect,
    {
      node((0, 0), [Начало], shape: circle, name: <t1-start>)
      node((0, 1), [Ввод массива A], shape: parallelogram, name: <t1-input>)
      node((0, 2), [Найти $i_min$, $i_max$], name: <t1-find-indexes>, shape: utils.rect-procedure)
      node((0, 3), [
        $"left" = min(i_min, i_max)$ \
        $"right" = max(i_min, i_max)$
      ], name: <t1-calc-bounds>)
      node((0, 4), [Произведение элементов\ между `left` и `right`], name: <t1-product>, shape: utils.rect-procedure)
      node((0, 5), [Вывод массива, `i_min`, `i_max`,\ произведения элементов], shape: parallelogram, name: <t1-output>)
      node((0, 6), [Преобразование массива], name: <t1-sort>, shape: utils.rect-procedure)
      node((0, 7), [Вывод отсоритрованного\ массива], name: <t1-sort-output>, shape: parallelogram)
      node((0, 8), [Конец], shape: circle, name: <t1-end>)

      edge(<t1-product>, <t1-output>, "-|>")
      edge(<t1-output>, <t1-sort>, "-|>")
      edge(<t1-sort>, <t1-sort-output>, "-|>")
      edge(<t1-sort-output>, <t1-end>, "-|>")
      edge(<t1-find-indexes>, <t1-calc-bounds>, "-|>")
      edge(<t1-input>, <t1-find-indexes>, "-|>")
      edge(<t1-start>, <t1-input>, "-|>")
      edge(<t1-calc-bounds>, <t1-product>, "-|>")
      edge(
        <t1-find-indexes>,
        (1, 2),
        "--[",
        label: [Функция `getIndexesOfMinAndMax`\ в `main.go`],
        label-pos: 2.3,
        label-side: center,
        mark-scale: 3,
      )
      edge(
        <t1-product>,
        (1, 4),
        "--[",
        label: [Функция `Product`\ в `main.go`],
        label-pos: 2.1,
        label-side: center,
        mark-scale: 3,
      )
      edge(
        <t1-sort>,
        (1, 6),
        "--[",
        label: [Функция `RearrangeToZerosFirst`,\ используем функцию стандартной\ библиотеки `slices.SortStableFunc`\ в `main.go`],
        label-pos: 2.8,
        label-side: center,
        mark-scale: 6,
      )
    },
  ),
  caption: [Основное тело программы],
)

#figure(diagram(node-stroke: 1pt, node-fill: white, edge-stroke: 1pt, spacing: (15mm, 12mm), node-shape: rect, {
  node((0, 0), [Начало], shape: circle, name: <t1-indexes-start>)
  node((0, 1), [Ввод: row], shape: parallelogram, name: <t1-indexes-input>)
  node((0, 2), [
    $i_min := 0$ \
    $i_max := 0$
  ], name: <t1-indexes-init>)
  node((0, 3), [$i := 0, N$], shape: hexagon, name: <t1-indexes-loop>)
  node((0, 4), [$"row"_i > "row"_(i_max)$], shape: diamond, name: <t1-indexes-check-max>, height: 35pt)
  node((-1, 5), [$i_max := i$], name: <t1-indexes-set-max>)
  node((1, 5), [$"row"_i < "row"_(i_min)$], shape: diamond, name: <t1-indexes-check-min>, height: 35pt)
  node((0, 6), [$i_min := i$], name: <t1-indexes-set-min>)
  node((0, 10), [Вывод: $i_min, i_max$], shape: parallelogram, name: <t1-indexes-output>)
  node((0, 11), [Конец], shape: circle, name: <t1-indexes-end>)

  edge(<t1-indexes-start>, <t1-indexes-input>, "-|>")
  edge(<t1-indexes-input>, <t1-indexes-init>, "-|>")
  edge(<t1-indexes-init>, <t1-indexes-loop>, "-|>")
  edge(<t1-indexes-loop>, <t1-indexes-check-max>, "-|>")
  edge(<t1-indexes-check-max>, "l", <t1-indexes-set-max>, "-|>", label: [Да])
  edge(<t1-indexes-check-max>, "r", <t1-indexes-check-min>, "-|>", label: [Нет])
  edge(<t1-indexes-check-min>, "l", <t1-indexes-set-min>, "-|>", label: [Да])
  edge(<t1-indexes-set-min>, (0, 8), "-|>")
  edge(<t1-indexes-set-max>, (-1, 8), "-|>")
  edge(<t1-indexes-output>, <t1-indexes-end>, "-|>")
  edge(<t1-indexes-loop>, "r,r,r,d,d,d,d,d,d,l,l,l", <t1-indexes-output>, "-|>")
  edge(
    <t1-indexes-check-min>,
    "r,d,d,d,l,l,l,l,u,u,u,u,u",
    <t1-indexes-loop>,
    "-|>",
    label: [Нет],
    label-side: left,
    label-pos: 0.05,
  )
}), caption: [Процедура "Найти $i_min$, $i_max$"])

#figure(diagram(node-stroke: 1pt, node-fill: white, edge-stroke: 1pt, spacing: (15mm, 12mm), node-shape: rect, {
  node((0, 0), [Начало], shape: circle, name: <t1-product-start>)
  node((0, 1), [
    Вход: left, right, A
  ], shape: parallelogram, name: <t1-product-input>)
  node((0, 2), [
    $i := "left" + 1, "right" - 1$ \
    $"product" := 1$
  ], name: <t1-product-loop-condition>, shape: hexagon)
  node((0, 4), [$"product" := "product" dot X_i$], name: <t1-product-multiply>)
  node((1, 4), [Вывод: product], shape: parallelogram, name: <t1-product-output>)
  node((1, 5), [Конец], shape: circle, name: <t1-product-end>)

  edge(<t1-product-output>, <t1-product-end>, "-|>")
  edge(<t1-product-loop-condition>, <t1-product-multiply>, "-|>")
  edge(<t1-product-input>, <t1-product-loop-condition>, "-|>")
  edge(<t1-product-start>, <t1-product-input>, "-|>")
  edge(<t1-product-loop-condition>, <t1-product-output>, "-|>", corner: right)
  edge(<t1-product-multiply>, "l,u,u", <t1-product-loop-condition>, "-|>")
}), caption: [Процедура "Произведение элементов между `left` и `right`"])
