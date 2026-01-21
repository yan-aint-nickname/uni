#import "@preview/codly:1.3.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import fletcher.shapes: rect

#diagram(
  node-stroke: 1pt,
  node-fill: white,
  spacing: (15mm, 10mm),
  edge-stroke: 1pt,
  node-shape: rect,
  {
    node((1, 0), [main], name: <struct-main>)
    node((0, 2), [readFromFile], name: <struct-read-from-file>)
    node((1, 2), [getIndexesOfMinAndMax], name: <struct-get-indexes-of-min-max>)
    node((1.7, 2), [Product], name: <struct-product>)
    node((2.5, 2), [RearrangeToZerosFirst], name: <struct-slices-sort-stable-func>)

    node((0.25, 3), [os.Open], fill: rgb(240, 240, 240), name: <struct-os-open>)
    node((-0.5, 3), [bufio.Scanner], fill: rgb(240, 240, 240), name: <struct-bufio-scanner>)
    node((1, 3), [strconv.ParseFloat], fill: rgb(240, 240, 240), name: <struct-strconv-parse-float>)

    edge(
      <struct-main>,
      <struct-read-from-file>,
      "->",
      label: [Чтение данных из файла],
      bend: -18deg,
      label-side: center,
      label-pos: 0.8,
    )
    edge(
      <struct-main>,
      <struct-get-indexes-of-min-max>,
      "->",
      label: [Поиск $i_min$ и $i_max$],
      label-side: center,
      label-pos: 0.3,
    )
    edge(<struct-main>, <struct-product>, "->", label: [Вычисление], label-pos: 0.75, bend: 18deg, label-side: center)
    edge(
      <struct-main>,
      <struct-slices-sort-stable-func>,
      "->",
      label: [Преобразование],
      label-pos: 0.6,
      bend: 18deg,
      label-side: center,
    )
    edge(<struct-read-from-file>, <struct-os-open>, "->", stroke: (dash: "dashed"))
    edge(<struct-read-from-file>, <struct-strconv-parse-float>, "->", stroke: (dash: "dashed"))
    edge(<struct-read-from-file>, <struct-bufio-scanner>, "->", stroke: (dash: "dashed"))
  },
)

// #v(1cm)

// #text(size: 10pt)[
//   *Рисунок 1.* Структурная схема программы

//   #v(0.5cm)

//   *Легенда:*
//   - Сплошные линии — вызовы собственных функций
//   - Пунктирные линии — вызовы стандартных библиотек
//   - Серые блоки — функции стандартной библиотеки Go
// ]

=== Структура программы
Таблицы тестов представлены в файле `./main_test.go`

#codly-range(143, end: 167)

#let task_1_main_test = read("./main_test.go")
#figure(
  caption: [Первые 2 примера таблицы тестов для функции `Product`],
  raw(task_1_main_test, lang: "go", block: true),
) <task-1-tests-product>

#figure(
  caption: [Таблица тестов указаных в @task-1-tests-product для функции `Product`],
  table(
    columns: 6,
    align: (left, left, center, center, center, center),
    table.header([*Название теста*], [*Входной массив*], [*left*], [*right*], [*Ожидаемый результат*], [*Ошибка*]),
    [Нормальный случай],
    [`[1, 2, 3, 4, 5]`],
    [1],
    [4],
    [12.0 (3 × 4)],
    [Нет],
    [Один элемент между границами],
    [`[1, 2, 3, 4]`],
    [0],
    [2],
    [2.0],
    [Нет],
  ),
)
