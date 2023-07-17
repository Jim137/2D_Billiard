import numpy as np
from numba import njit, prange


@njit(parallel=True)
def rk4(initial_values, ball_char, dt: float):
    x, y, vx, vy, wx, wy, wz = initial_values
    m, mu, rho, r = ball_char
    pass