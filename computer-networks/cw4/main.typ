#import "template.typ": *

#import "@preview/muchpdf:0.1.0": muchpdf
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Компьютерные сети. КМ-4",
  authors: (
    "Кирш Я.А. ИДз-21-21. Вариант 8.",
  ),
)

#show figure: set block(breakable: true)
#set terms(separator: [: ])

#set heading(
  numbering: (..nums) => {
    if nums.pos().len() >= 4 {
      none
    } else {
      numbering("1.", ..nums)
    }
  },
)

#outline()

= Задание

#muchpdf(read("assets/task.pdf", encoding: none), scale: 0.95)

#pagebreak()

= Решение

#let N = 8
#let mu1 = 3
#let mu2 = 5
#let mu3 = 9 + N
#let mu4 = 7
#let given_precision = 0.06

#let n1 = 7
#let n2 = 13

#let f1(lambda1, mu1, gamma1, lambda2, mu3, gamma3, mu4, gamma4, round: 4) = {
  calc.round(
    lambda1 / (mu1 - gamma1 * lambda1)
      + (2 * lambda1) / (mu3 - gamma3 * (2 * lambda1 + 2 * lambda2))
      + lambda1 / (mu4 - gamma4 * (lambda1 + lambda2)),
    digits: round,
  ) -n1
}

#let f2(lambda1, mu1, gamma2, lambda2, mu3, gamma3, mu4, gamma4, round: 4) = {
  calc.round(
    lambda2 / (mu2 - gamma2 * lambda2)
      + (2 * lambda2) / (mu3 - gamma3 * (2 * lambda1 + 2 * lambda2))
      + lambda2 / (mu4 - gamma4 * (lambda1 + lambda2)),
    digits: round,
  ) - n2
}

// Not very much an optimized code :)
#let gamma1 = 0.67
#let gamma2 = 0.75
#let gamma3 = 0.86
#let gamma4 = 0.86

#let precision(f_1, f_2, round: 2) = {
  calc.round(calc.abs(f_1 - f_2) / calc.abs(f_1), digits: round)
}

// the dichotomic search
#let LB_1 = 0
#let LE_1 = 3
#let LB_2 = 0
#let LE_2 = 5

$
  underline(s = 0);&Lambda_B(1,0) = #LB_1 ; Lambda_E(1,0) = #LE_1 ; Lambda_B(2,0) = #LB_2 ; Lambda_E(2,0) = #LE_2 ;\
$

#let l1 = calc.round((LB_1 + LE_1) / 2, digits: 4)
#let l2 = calc.round((LB_2 + LE_2) / 2, digits: 4)

#let iteration = 1
#let max_iterations = 15

#let l1_prev = l1
#let l2_prev = l2
#let f_1_prev = f1(l1, mu1, gamma1, l2, mu3, gamma3, mu4, gamma4, round: 2)
#let f_2_prev = f2(l1, mu2, gamma2, l2, mu3, gamma3, mu4, gamma4, round: 2)

#while iteration < max_iterations {
  let l1 = calc.round((LB_1 + LE_1) / 2, digits: 4)
  let l2 = calc.round((LB_2 + LE_2) / 2, digits: 4)
  let f_1 = f1(l1, mu1, gamma1, l2, mu3, gamma3, mu4, gamma4, round: 2)
  let f_2 = f2(l1, mu2, gamma2, l2, mu3, gamma3, mu4, gamma4, round: 2)

  if f_1 > 0 {
    LB_1 = l1
  } else {
    LE_1 = l1
  }

  if f_2 > 0 {
    LB_2 = l2
  } else {
    LE_2 = l2
  }

  $
    underline(s = #iteration) ; &lambda_1(#iteration)=#l1 ; lambda_2(#iteration)=#l2 ; f(1,#iteration) = #f_1 ; f(2,#iteration) = #f_2 ;\
  &Lambda_B(1,#iteration) = #LB_1 ; Lambda_E(1,#iteration) = #LE_1 ; Lambda_B(2,#iteration) = #LB_2 ; Lambda_E(2,#iteration) = #LE_2\
  $

  let old_iteration = iteration
  iteration = iteration + 1

  let p_f_1 = precision(f_1_prev, f_1, round: 4)
  let p_f_2 = precision(f_2_prev, f_2, round: 4)

  let precision_ = calc.max(p_f_1, p_f_2)

  if iteration > 2 {
    [Посчитаем точность вычислений:\ ]
    if precision_ < given_precision {
      $Delta_(q_1)  = abs(f(1,#old_iteration) - f(1,#iteration)) / f(1,#old_iteration) = abs(#f_1_prev - #f_1) / #f_1_prev = #p_f_1 < epsilon = #given_precision;$
      [\ ]
      $Delta_(q_2)  = abs(f(2,#old_iteration) - f(2,#iteration)) / f(2,#old_iteration) = abs(#f_2_prev - #f_2) / #f_2_prev = #p_f_2 < epsilon = #given_precision;$
      [\ ]
      [Необходимая точность достигнута]
      [\ ]
      [С заданной точностью $epsilon = 6% $ получаем, $lambda_1 = #l1 1/s, lambda_2 = #l2 1/s$]
      break
    }

    $Delta_(q_1)  = abs(f(1,#old_iteration) - f(1,#iteration)) / f(1,#old_iteration) = abs(#f_1_prev - #f_1) / #f_1_prev = #p_f_1 > epsilon = #given_precision;$
    [\ ]
    $Delta_(q_2)  = abs(f(2,#old_iteration) - f(2,#iteration)) / f(2,#old_iteration) = abs(#f_2_prev - #f_2) / #f_2_prev = #p_f_2 > epsilon = #given_precision;$
    [\ ]
    [Продолжаем считать]
  }

  f_1_prev = float(f_1)
  f_2_prev = float(f_2)
}


Полный код работы содержится в репозитории.#footnote(link("https://github.com/yan-aint-nickname/uni/tree/main/computer-networks/cw4"))
