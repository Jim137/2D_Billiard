import numpy as np
from numba import set_num_threads
from .ball import ball
from .iterator import *


def iteration(ball:ball, dt: float, n: int = 2, method: str = "euler"):
    '''
    Iterate the ball object.
    
    ---
    Parameters
    ---
    ball: ball object
    dt: float, time step (s)
    n: int, number of threads, default: 2
    method: str, method of iteration, default: "euler", options: "euler", "rk2", "rk4"
    '''
    set_num_threads(n)
    initial_values = np.array(
        [
            ball.x,
            ball.y,
            ball.vx,
            ball.vy,
            ball.wx,
            ball.wy,
            ball.wz,
        ],
        dtype=np.float64,
    )
    ball_char = np.array(
        [
            ball.m,
            ball.mu,
            ball.rho,
            ball.r,
        ],
        dtype=np.float64,
    )
    if method == "euler":
        result = euler(initial_values, ball_char, dt)
    elif method == "rk2":
        result = rk2(initial_values, ball_char, dt)
    elif method == "rk4":
        result = rk4(initial_values, ball_char, dt)
    else:
        raise ValueError("Invalid method.")
    return result