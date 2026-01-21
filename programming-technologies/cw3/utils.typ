#import "@preview/cetz:0.3.4"


// Кастомная форма "предопределенный процесс" (подпрограмма) по ГОСТ
#let rect-procedure(node, extrude) = {
  import cetz.draw: *

  let (w, h) = node.size

  // HACK: для красивого отражения блока процедуры
  let line-offset = 5 * 1pt
  w += line-offset

  {
    rect((-w / 2, -h / 2), (w / 2, h / 2))
    line((-w / 2 + line-offset, -h / 2), (-w / 2 + line-offset, h / 2))
    line((w / 2 - line-offset, -h / 2), (w / 2 - line-offset, h / 2))
  }
}
