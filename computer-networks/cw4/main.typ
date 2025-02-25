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


= Решение

#let N = 8
#let mu1 = 3
#let mu2 = 5
#let mu3 = 9 + N
#let mu4 = 7
#let given_precision = 0.06

#let f1(lambda1, mu1, gamma1, lambda2, mu3, gamma3, mu4, gamma4, round: 4) = {
  calc.round(
    lambda1 / (mu1 - gamma1 * lambda1)
      + (2 * lambda1) / (mu3 - gamma3 * (2 * lambda1 + 2 * lambda2))
      + lambda1 / (mu4 - gamma4 * (lambda1 + lambda2)),
    digits: round,
  )
}

#let f2(lambda1, mu1, gamma2, lambda2, mu3, gamma3, mu4, gamma4, round: 4) = {
  calc.round(
    lambda2 / (mu2 - gamma2 * lambda2)
      + (2 * lambda2) / (mu3 - gamma3 * (2 * lambda1 + 2 * lambda2))
      + lambda2 / (mu4 - gamma4 * (lambda1 + lambda2)),
    digits: round,
  )
}

// Not very much an optimized code :)
#let gamma1 = 0.67
#let gamma2 = 0.75
#let gamma3 = 0.86
#let gamma4 = 0.86

#let lambda1 = 1.5
#let lambda2 = 2.5

#let f11 = f1(lambda1, mu1, gamma1, lambda2, mu3, gamma3, mu4, gamma4, round: 2)
#let f21 = f2(lambda1, mu2, gamma2, lambda2, mu3, gamma3, mu4, gamma4, round: 2)

#let lambda3 = 2.25
#let lambda4 = 3.75

#let f12 = f1(lambda3, mu1, gamma1, lambda4, mu3, gamma3, mu4, gamma4, round: 2)
#let f22 = f2(lambda4, mu2, gamma2, lambda4, mu3, gamma3, mu4, gamma4, round: 2)

#let lambda5 = 2.625
#let lambda6 = 4.375

#let f13 = f1(lambda5, mu1, gamma1, lambda6, mu3, gamma3, mu4, gamma4, round: 2)
#let f23 = f2(lambda5, mu2, gamma2, lambda6, mu3, gamma3, mu4, gamma4, round: 2)

#let lambda7 = 2.8125
#let lambda8 = 4.6875

#let f14 = f1(lambda7, mu1, gamma1, lambda8, mu3, gamma3, mu4, gamma4, round: 2)
#let f24 = f2(lambda7, mu2, gamma2, lambda8, mu3, gamma3, mu4, gamma4, round: 2)

$
  underline(s = 0);&Lambda_B(1,0) = 0; Lambda_E(1,0) = 3; Lambda_B(2,0) = 0; Lambda_E(2,0) = 5;\

underline(s = 1);&lambda_1(1)=1.5; lambda_2(1)=2.5; f(1,1) = #f11 ; f(2,1) = #f21 ;\
&Lambda_B(1,1) = 1.5; Lambda_E(1,1) = 3; Lambda_B(2,1) = 2.5; Lambda_E(2,1) = 5\

underline(s = 2);&lambda_1(2)=2.25; lambda_2(2)=3.75; f(1,2) = #f12 ; f(2,2) = #f22 ;\
&Lambda_B(1,2) = 2.25; Lambda_E(1,2) = 3; Lambda_B(2,2) = 3.75; Lambda_E(2,2) = 5\
$

#let precision(f_1, f_2, round: 2) = {
  calc.round(calc.abs(f_1 - f_2) / f_1, digits: round)
}

Посчитаем точность вычислений:\
$Delta_(q_1)  = abs(f(1,1) - f(1,2)) / f(1,1) = abs(#f11 - #f12) / #f11 = #precision(f11, f12, round: 4); "При этом заданная точность" epsilon = 0.06$\
$Delta_(q_2)  = abs(f(2,1) - f(2,2)) / f(2,1) = abs(#f21 - #f22) / #f21 = #precision(f21, f22, round: 4); "При этом заданная точность" epsilon = 0.06$\
Следовательно продолжаем вычисления

$
  underline(s = 3);&lambda_1(3)=2.625; lambda_2(3)=4.375; f(1,3) = #f13 ; f(2,3) = #f23 ;\
&Lambda_B(1,3) = 2.625; Lambda_E(1,3) = 3; Lambda_B(2,3) = 4.375; Lambda_E(2,3) = 5\

underline(s = 4);&lambda_1(4)=2.8125; lambda_2(4)=4.6875; f(1,4) = #f14 ; f(2,4) = #f24 ;\
&Lambda_B(1,4) = 2.8125; Lambda_E(1,4) = 3; Lambda_B(2,4) = 4.6875; Lambda_E(2,4) = 5\
$

Посчитаем точность вычислений:\
$Delta_(q_1)  = abs(f(1,3) - f(1,4)) / f(1,3) = abs(#f13 - #f14) / #f13 = #precision(f13, f14, round: 4); "При этом заданная точность" epsilon = 0.06$\
$Delta_(q_2)  = abs(f(2,3) - f(2,4)) / f(2,3) = abs(#f23 - #f24) / #f23 = #precision(f23, f24, round: 4); "При этом заданная точность" epsilon = 0.06$\
Следовательно продолжаем вычисления

// the algorithm
#let l1 = 2.90625
#let l2 = 4.84375
#let LB_1 = l1
#let LE_1 = 3
#let LB_2 = l2
#let LE_2 = 5

#let f_1 = f1(l1, mu1, gamma1, l2, mu3, gamma3, mu4, gamma4, round: 2)
#let f_2 = f2(l1, mu2, gamma2, l2, mu3, gamma3, mu4, gamma4, round: 2)

#let iteration = 5
#let max_iterations = 20

#let precision_ = calc.max(
  precision(f13, f14, round: 4),
  precision(f23, f24, round: 4),
)

#while precision_ > given_precision and iteration < max_iterations {
  $
    underline(s = #iteration) ; &lambda_1(#iteration)=#l1 ; lambda_2(#iteration)=#l2 ; f(1,#iteration) = #f_1 ; f(2,#iteration) = #f_2 ;\
  &Lambda_B(1,#iteration) = #LB_1 ; Lambda_E(1,#iteration) = #LE_1 ; Lambda_B(2,#iteration) = #LB_2 ; Lambda_E(2,#iteration) = #LE_2\
  $

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

  let old_l1 = l1
  let old_l2 = l2
  let old_f1 = f_1
  let old_f2 = f_2

  l1 = calc.round((LB_1 + LE_1) / 2, digits: 5)
  l2 = calc.round((LB_2 + LE_2) / 2, digits: 5)

  f_1 = f1(l1, mu1, gamma1, l2, mu3, gamma3, mu4, gamma4, round: 2)
  f_2 = f2(l1, mu2, gamma2, l2, mu3, gamma3, mu4, gamma4, round: 2)

  precision_ = calc.max(
    precision(old_f1, f_1, round: 4),
    precision(old_f2, f_2, round: 4),
  )
  let old_iteration = iteration
  iteration = iteration + 1

  [Посчитаем точность вычислений:\ ]
  $Delta_(q_1)  = abs(f(1,#old_iteration) - f(1,#iteration)) / f(1,#old_iteration) = abs(#f13 - #f14) / #f13 = #precision(old_f1, f_1, round: 4); "При этом заданная точность" epsilon = 0.06$
  [\ ]
  $Delta_(q_2)  = abs(f(2,#old_iteration) - f(2,#iteration)) / f(2,#old_iteration) = abs(#f23 - #f24) / #f23 = #precision(old_f2, f_2, round: 4); "При этом заданная точность" epsilon = 0.06$
  [\ ]

  if precision_ < given_precision {
    [Необходимая точность достигнута]
  } else {
    [Продолжаем считать]
  }
}

Полный код работы содержится в репозитории.#footnote(link("https://github.com/yan-aint-nickname/uni/tree/main/computer-networks/cw4"))
