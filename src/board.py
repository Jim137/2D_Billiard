import matplotlib.pyplot as plt
from matplotlib import patches
import numpy as np
from ball import ball


class board:
    def __init__(self, time=0, board_rect=[-1.27 / 2, -2.54 / 2, 1.27, 2.54]):
        """
        Initialize a board object.

        ---
        Parameters
        ---
        time: float, time (s), default: 0
        board_rect: list, [x, y, width, height] which has to satisfy matplotlib.patches.Rectangle input arguments, default: [-1.27/2, -2.54/2, 1.27, 2.54]
        """
        self.time = 0
        self.board_rect = board_rect
        self.balls = []

    def __iadd__(self, ball: ball):
        self.balls.append(ball)
        return self

    def drop(self, ball: ball):
        self.balls.remove(ball)

    def plot_current_frame(self, ax=None):
        """
        Plot the board and the balls at the current time.

        ---
        Parameters
        ---
        ax: matplotlib.axes.Axes, default: None
        """
        if ax is None:
            fig, ax = plt.subplots()
        ax.set_xlim(self.board_rect[0], self.board_rect[0] + self.board_rect[2])
        ax.set_ylim(self.board_rect[1], self.board_rect[1] + self.board_rect[3])
        ax.add_patch(
            patches.Rectangle(
                (self.board_rect[0], self.board_rect[1]),
                self.board_rect[2],
                self.board_rect[3],
                fill=False,
            )
        )
        for ball in self.balls:
            ball.plot(ax=ax)
        return ax

    def log_current_frame(self, fn):
        """
        Log positions of the balls at the current time.

        ---
        Parameters
        ---
        fn: str, file name
        """
        with open(fn, "a") as f:
            header = """
                ----------------------------------------------------
                Data from a 2D Billiard Simulation. 

                rows are ith ball; 
                coumns are :tag, x ,y, vx, vy, wx, wy, wz

                ----------------------------------------------------
                """
        header += "Time = {}".format(self.time)
        tag = []
        x = []
        y = []
        vx = []
        vy = []
        wx = []
        wy = []
        wz = []
        for ball in self.balls:
            tag.append(ball.tag)
            x.append(ball.x)
            y.append(ball.y)
            vx.append(ball.vx)
            vy.append(ball.vy)
            wx.append(ball.wx)
            wy.append(ball.wy)
            wz.append(ball.wz)
        np.savetxt(
            fn, (tag[:], x[:], y[:], vx[:], vy[:], wx[:], wy[:], wz[:]), header=header
        )
