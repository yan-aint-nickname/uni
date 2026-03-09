# %% Cell 0
import numpy as np
from scipy.optimize import minimize_scalar

# %% Cell 1
epsilon_1 = 0.1


def f(x):
    return np.sin(2 * np.pi * x) - 2 * np.pi * np.exp(x - 1)


result_1 = minimize_scalar(
    f,
    bounds=(1 / 2, 3 / 2),
    options={
        "xatol": epsilon_1,
    },  # xatol - x absolute tolerance - точность вычисления для x
)

print("Minimum at =", result_1.x)
print("Minimum =", result_1.fun)
print("Iterations =", result_1.nit)
# >> Minimum at = 1.4442719099991588
# >> Minimum = -9.454674225229954
# >> Iterations = 6

# %% Cell 2
epsilon_2 = 0.001

result_2 = minimize_scalar(
    f,
    bounds=(1 / 2, 3 / 2),
    options={"xatol": epsilon_2},
)

print("Minimum at =", result_2.x)
print("Minimum =", result_2.fun)
print("Iterations =", result_2.nit)
# >> Minimum at = 1.499600218135197
# >> Minimum = -10.352568761729087
# >> Iterations = 16


# %%
def f_3(x):
    return np.pow(x, 2) + 2 * x - 4


for e in (epsilon_1, epsilon_2):
    result_3 = minimize_scalar(
        f_3,
        bounds=(-2, 1),
        options={"xatol": e},
    )

    print("Minimum at =", result_3.x)
    print("Minimum =", result_3.fun)
    print("Iterations =", result_3.nit)
    # >> Minimum at = -1.0
    # >> Minimum = -5.0
    # >> Iterations = 6


# %%
def f_4(x):
    return np.pow(x - 2, 2)


def golden_ration_lambda(a, b):
    return a + 0.382 * (b - a)


def golden_ration_mu(a, b):
    return a + 0.618 * (b - a)


# 4:
a = 1.584
b = 2.292
l4 = golden_ration_lambda(a, b)
m4 = golden_ration_mu(a, b)

f_4_l4 = f_4(l4)
f_4_m4 = f_4(m4)

print(l4, m4, f_4_l4, f_4_m4)

# %%

# 5:
a = 1.854
b = 2.292
accuracy = b - a
l4 = golden_ration_lambda(a, b)
m4 = golden_ration_mu(a, b)

f_4_l4 = f_4(l4)
f_4_m4 = f_4(m4)

print(accuracy, l4, m4, f_4_l4, f_4_m4)

# %%
# 6:
a = 1.854
b = 2.124
accuracy = b - a
l4 = golden_ration_lambda(a, b)
m4 = golden_ration_mu(a, b)

f_4_l4 = f_4(l4)
f_4_m4 = f_4(m4)

print(accuracy, l4, m4, f_4_l4, f_4_m4)

# %%
# 7:
a = 1.957
b = 2.124
accuracy = b - a
l4 = golden_ration_lambda(a, b)
m4 = golden_ration_mu(a, b)

f_4_l4 = f_4(l4)
f_4_m4 = f_4(m4)

print(accuracy, l4, m4, f_4_l4, f_4_m4)

# %%
# 8:
a = 1.957
b = 2.06
accuracy = b - a
l4 = golden_ration_lambda(a, b)
m4 = golden_ration_mu(a, b)

f_4_l4 = f_4(l4)
f_4_m4 = f_4(m4)

print(accuracy, l4, m4, f_4_l4, f_4_m4)

# %%
# 9:
a = 1.957
b = 2.02
accuracy = b - a
l4 = golden_ration_lambda(a, b)
m4 = golden_ration_mu(a, b)

f_4_l4 = f_4(l4)
f_4_m4 = f_4(m4)

print(accuracy, l4, m4, f_4_l4, f_4_m4)

# %%
# Fibonacci

def fib(n: int) -> int:
    next = 1
    prev = 0
    for _ in range(n):
        tmp = next
        next = prev + next
        prev = tmp

    return prev

print(fib(9))

# %%
