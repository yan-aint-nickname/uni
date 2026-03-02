#let project(
  title: "",
  discipline: "Основы теории управления",
  work-type: "Проектная работа",
  work-number: "",
  institute: "Инженерно-Экономический институт",
  department: "Кафедра «Менеджмента в энергетике и промышленности»",
  topic: "Анализ организационной структуры предприятия
              (на примере ООО «Интернет Решения»)",
  authors: (),
  instructors: (),
  year: datetime.today().year(),
  body,
) = {
  set page(numbering: none)
  set page(paper: "a4", margin: (top: 2cm, bottom: 2cm, left: 3cm, right: 1.5cm), number-align: center)
  set text(font: "Times New Roman", size: 12pt, lang: "ru")
  set par(justify: true)

  align(center)[
    *ФЕДЕРАЛЬНОЕ ГОСУДАРСТВЕННОЕ БЮДЖЕТНОЕ \
    ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ ВЫСШЕГО ОБРАЗОВАНИЯ \
    МОСКОВСКИЙ ЭНЕРГЕТИЧЕСКИЙ ИНСТИТУТ \
    (НАЦИОНАЛЬНЫЙ ИССЛЕДОВАТЕЛЬСКИЙ УНИВЕРСИТЕТ)*
  ]
  line(length: 100%)
  align(center)[
    *#institute* \
    *#department*
  ]

  v(3em)
  align(center, text(size: 14pt, weight: "bold")[
    #upper(work-type) ПО ДИСЦИПЛИНЕ \
    #upper(discipline).
  ])

  v(2em)
  align(center)[
    на тему: «#topic»
  ]

  if work-number != "" {
    align(center)[Вариант №#work-number]
  }

  v(1fr)

  for author in authors {
    let group = if "group" in author { author.group } else { "" }
    grid(
      columns: (auto, 1fr, auto),
      column-gutter: 0.5em,
      [Выполнил студент группы],
      align(right)[#underline[#group #author.full_name]],
    )
    v(1em)
  }

  for instructor in instructors {
    let degree = if "degree" in instructor { instructor.degree } else { "" }
    grid(
      columns: (auto, 1fr, auto),
      column-gutter: 0.5em,
      [Научный руководитель],
      align(right)[#underline[#degree #instructor.full_name]],
    )
    v(1em)
  }

  v(2em)

  grid(columns: (auto, 1fr), column-gutter: 0.5em, [К защите допущен], align(center)[
    #box(width: 1fr, stroke: (bottom: 0.5pt))
    #text(size: 10pt)[(дата, подпись руководителя)]
  ])

  v(2em)

  grid(columns: (auto, 1fr), column-gutter: 0.5em, [Работа защищена с оценкой], align(center)[
    #box(width: 1fr, stroke: (bottom: 0.5pt))
    #text(size: 10pt)[(дата, подпись руководителя)]
  ])

  v(1fr)
  align(center)[
    Москва #year г.
  ]

  pagebreak()

  body
}
