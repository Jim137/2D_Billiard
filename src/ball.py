import numpy as np


class ball:
    def __init__(
        self,
        tag,
        board,
        x=0.0,
        y=0.0,
        vx=0.0,
        vy=0.0,
        wx=0.0,
        wy=0.0,
        wz=0.0,
        m=0.17,
        mu=0.07,
        rho=0.0005,
        r=0.028575,
    ):
        """
        Initialize a ball object.

        ---
        Parameters
        ---
        board: board object
        x: float, position in x-axis (m)
        y: float, position in y-axis (m)
        vx: float, velocity in x-axis (m/s)
        vy: float, velocity in y-axis (m/s)
        wx: float, angular velocity toward x-axis (rad/s)
        wy: float, angular velocity toward y-axis (rad/s)
        wz: float, angular velocity toward z-axis (rad/s)
        m: float, mass (kg), default: 0.17
        mu: float, coefficient of friction, default: 0.07
        rho: float, the radius of the plane that the ball sinks into the board (m), default: 0.0005
        r: float, radius of the ball (m), default: 0.028575
        """
        self._tag = tag
        self.x = x
        self.y = y
        self.vx = vx
        self.vy = vy
        self.wx = wx
        self.wy = wy
        self.wz = wz
        self._m = m
        self._mu = mu
        self._rho = rho
        self._r = r
        board += self
        
    @property
    def tag(self):
        return self._tag

    @property
    def m(self):
        return self._m

    @property
    def mu(self):
        return self._mu

    @property
    def rho(self):
        return self._rho

    @property
    def r(self):
        return self._r

    @property
    def v(self):
        return np.sqrt(self.vx**2 + self.vy**2)

    @property
    def w(self):
        return np.sqrt(self.wx**2 + self.wy**2 + self.wz**2)
