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
  }
)

#outline()

= Задание

#muchpdf(read("assets/task.pdf", encoding: none), scale: 0.95)

#pagebreak()

= Решение

/ $lambda$ : Интенсивность поступления сообщений
/ $t^0$ : Время обслуживания сообщений узлом
/ $mu$ : Интенсивность обслуживания сообщений в узле
/ $t_i$ : Время задержки сообщений в системе ($i$ - в узле и очереди на ослуживание)
/ $rho_i$: Коэффициент загркузки узла $i$

== Задание 1

$
t^0 = 1/mu; t_i = 1/(mu_i - lambda_i); rho_i = lambda_i/mu_i; t^0_i = 1/(mu_i - lambda_i)
$

$
N = 8\
lambda_A = 50+8 = 58"с"^(-1)\
t^0_A = 0.014 + 8*0.001 = 0.022"с"
mu_A = 1/(t^0_A) = 1/0.022 = 45.45"с"^(-1)\

rho_A = lambda_A/mu_A = 58/45.45 = 1.27 > 1 "система неустойчива, сообщения будут накапливаться в очереди"\

underline(t_A = "система неустойчива")
$

$
t^0_B = t^0_A / 2 = 0.022/2 = 0.011"с"\
lambda_B = 58"с"^(-1)\
mu_B = 1/t^0_B = 1/0.011 = 90.9"с"^(-1)\
rho_B = lambda_B/mu_B = 58/90.9 = 0.63 lt.eq.slant 1 arrow.r.double "Система устойчива"\

underline(t_B = 1/(mu_B-lambda_B) = 1/(90.9-58) = 0.03"с")\

t^0_C = t^0_A / 2 = 0.022/2 = 0.011"с"\
lambda_C = 58"с"^(-1)\
mu_C = 1/t^0_C = 1/0.011 = 90.9"с"^(-1)\
rho_C = lambda_C/mu_C = 58/90.9 = 0.63 lt.eq.slant 1 arrow.r.double "Система устойчива"\

underline(t_C = 1/(mu_C-lambda_C) = 1/(90.9-58) = 0.03"с")
$

#pagebreak()

== Задание 2
Значение $t^0_A$ из первого задания

$
lambda = 58 1/"с"\
p_1 = p_2 = p = 0.5\
t^0_C = t^0_A = 0.022"с"\

lambda_1 = p dot lambda = 0.5 * 58 = 29 1/"с"\
mu_1 = 1/(t_0_C) = 1/0.022 = 45.45 1/"с"\

rho_1 = lambda_1/mu_1 = 29/45.45 = 0.638 arrow.r.double "Система стабильна"\

t_1 = 1/(mu_1 - lambda_1) = 1/(45.45 - 29) = 1/16.45 = 0.06 "с",
"так как поток распределен равномерно" t_2 = t_1 = 0.06 "с"\

underline(t_"общ" = p_1 * t_1 + p_2 + t_2 = 0.5*0.06 + 0.5*0.06 = 0.06 "с")
$

== Задание 3

$
N = 8\
lambda_1 = 50+N = 58 1/"с"; lambda_2 = 51+N = 59 1/"с"; lambda_3 = 52+N = 60 1/"с"\
mu_1 = 180+N = 188 1/"с"; mu_2 = 200+N = 208 1/"с"\

lambda_"общ" = lambda_1 + lambda_2 + lambda_3 = 58+59+60 = 177 1/"с"

underline(rho_1 = lambda_"общ"/mu_1 = 177/188 = 0.94) <= 1 => "узел стабильный"\
underline(rho_2 = lambda_"общ"/mu_2 = 177/208 = 0.85) <= 1 => "узел стабильный"\

t_1 = 1/(mu_1 - lambda_"общ") = 1/(188-177) approx 0.09"с"\
t_2 = 1/(mu_2 - lambda_"общ") = 1/(208-177) approx 0.03"с"\

underline(t_"общ" = t_1 + t_2 = 0.09+0.03 = 0.12"с")
$

Полный код работы содержится в репозитории.#footnote(link("https://github.com/yan-aint-nickname/uni/tree/main/computer-networks/cw3"))
