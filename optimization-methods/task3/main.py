# %% Cell 1
from scipy.optimize import linprog

# %% Cell 2
# Задание 1

# _ub - upper bound (верхняя граница)
# _eq - equal (равно)
# L(x) = -45x_1 + 65x_2 + 2x_4 - 3x_5 -> max
c = [
    45,
    -65,
    0,
    -2,
    3,
]  # Инвертируем знак коэффициентов, чтобы найти максимум, а не минимум
A_ub = [
    [
        -2,
        0,
        -7,
        +4,
        -3,
    ],  # 2x_1 + 7x_3 - 4x_4 + 3x_5 >= 91 Инвертируем знаки коэффициентов, чтобы это было верхней границей, а не нижней
    [0.2, 0.8, 1.5, 0.9, 4],  # 0.2x_1 + 0.8x_2 + 1.5x_3 + 0.9x_4 + 4x_5 <= 26
]
A_eq = [
    [15, 18, 0, 34, -22],  # 15x_1 + 18x_2 + 34x_4 - 22x_5 = 56
    [1.8, -42, 6.4, 0, 3],  # 1.8x_1 - 42x_2 + 6.4x_3 + 3x_5 = 15
]
b_ub = [-91, 26]
b_eq = [56, 15]
# x_j >= 0; j = (1,5); lb <= x <= ub, где lb = 0, а ub = None => Inf
bounds = [(0, None) for _ in range(5)]
f_max = linprog(c, A_eq=A_eq, A_ub=A_ub, b_eq=b_eq, b_ub=b_ub, bounds=bounds)
print(f_max.x)  # Массив x_i при которых целевая функция достигает минимума
# >> [ 0.          2.06564816 15.89956608  0.55348038  0.        ]
print(
    -f_max.fun
)  # Максимум целевой функции (Мы должны сменить знак результата, чтобы получить максимум)
# >> 135.3740914843609
print(f_max.success)  # Удачно ли сработал алгоритм
# >> True
# %% Cell 3
# Задание 1 дополнительное условие: переменные должны быть целочисленные
# это решается добавляением аргумента integrality равному 1
max_with_int_vars = linprog(
    c,
    A_eq=A_eq,
    A_ub=A_ub,
    b_eq=b_eq,
    b_ub=b_ub,
    bounds=bounds,
    integrality=1,
)
print(max_with_int_vars.x)  # Массив x_i при которых целевая функция достигает минимума
# >> None
print(
    -max_with_int_vars.fun if max_with_int_vars.fun else None
)  # Максимум целевой функции
# >> None
print(max_with_int_vars.success)  # Удачно ли сработал алгоритм
# >> False
# Это значит, что нет решения
# %% Cell 4
# Задание 2

# L(X) = -2x_1-x_2 -> min, max
c_min = [-2, -1]
c_max = [2, 1]  # Инвертируем знаки


A_ub = [
    [2, 4],  # 2x_1+4x_2<=16
    [-4, 2],  # -4x_1+2x_2<=8
    [-1, -3],  # x_1+3x_2>=9 => -x_1-3x_2<=-9
]

b_ub = [16, 8, -9]

A_eq = [[6, 5]]  # 6x_1+5x_2=30
b_eq = [30]

# x_1, x_2 >=0)
bounds = [(0, None), (0, None)]

min_fun_2 = linprog(c_min, A_ub=A_ub, A_eq=A_eq, b_ub=b_ub, b_eq=b_eq)
print(min_fun_2.x, min_fun_2.fun)  # Точка A
# >> [3.46153846 1.84615385] -8.76923076923077
max_fun_2 = linprog(c_max, A_ub=A_ub, A_eq=A_eq, b_ub=b_ub, b_eq=b_eq)
print(max_fun_2.x, -max_fun_2.fun)  # Точка B
# >> [2.85714286 2.57142857] -8.285714285714285

# %%
