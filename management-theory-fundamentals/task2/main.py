# %% Cell 1
from scipy.optimize import linprog

# %% Cell 2
# common
A = [[1, 1], [-1, -1], [-1, 1]]
b = [60, -18, 0]
x0_bounds = (12, 54)
x1_bounds = (0, None)

# %% Cell 3
# min
c = [0.3, 0.35]
expected_min = 5.4
min = linprog(c, A_ub=A, b_ub=b, bounds=[x0_bounds, x1_bounds])

min_rounded = round(min.fun, 2)
print(min_rounded, "Равно ожидаемому значению", min_rounded == expected_min)
# > Вывод: 5.4 Равно ожидаемому значению True

# %% Cell 4
# max
c = [-0.3, -0.35]
expected_max = 19.5
max = linprog(c, A_ub=A, b_ub=b, bounds=[x0_bounds, x1_bounds])

max_rounded_abs = abs(round(max.fun, 2))
print(max_rounded_abs, "Равно ожидаемому значению", max_rounded_abs == expected_max)
# > Вывод: 19.5 Равно ожидаемому значению True
