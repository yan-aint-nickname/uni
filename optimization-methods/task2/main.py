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
