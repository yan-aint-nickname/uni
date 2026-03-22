#let project(
  title: "",
  discipline: "",
  work-type: "Контрольная работа",
  work-number: "3",
  institute: "Институт Дистанционного и Дополнительного Образования",
  authors: (),
  instructors: (),
  year: datetime.today().year(),
  body,
) = {
  set page(numbering: none)
  set page(paper: "a4", margin: (top: 2cm, bottom: 2cm, left: 3cm, right: 1.5cm), number-align: center)
  set text(font: "Times New Roman", size: 12pt, lang: "ru")
  set par(justify: true)

  v(2cm)
  align(center)[
    ФГБОУ ВО \
    Национальный исследовательский университет «МЭИ»\
    #institute
  ]

  v(3em)
  align(center)[
    #work-type #if work-number != "" { [ №#work-number\ ] } else { [] }
    #title
  ]

  v(2em)
  align(center)[
    по дисциплине «#discipline»
  ]

  v(12em)

  align(right + horizon)[
    Выполнил: \
    #authors.map(author => [#author.position \ #author.full_name]).join([\ \ ])

    \
    Проверил(а): \
    #instructors.map(instructor => [#instructor.position \ #instructor.full_name]).join([\ \ ])
  ]

  v(1fr)
  align(center)[
    Москва #year г.
  ]

  pagebreak()

  body
}
