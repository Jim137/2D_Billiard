# 2D_Billiard

A lose-to-reality physical modeling of billiard balls. Taking not only friction but also rolling resistance in to account, and considering the ball-ball interaction and ball-cushion impact.

## Introduction

This project is originated from my final project of "Experimental Physics" with Y.-H. Chi in my sophomore year [1]. 

### Plane Table Motion

The first feature of this project is to distinguish the 7 cases of billiard motion on the plane table indicated by [2].
The 7 cases can be described as follows:

* Initial angular velocity is zero.
  
  1. Sliding without rolling before rolling without sliding
   
* Initial angular velocity is aligned with the velocity of the center of mass.
  
  2. Rolling without sliding
  3. Sliding with micro-rolling before rolling without sliding
  4. Sliding with rolling before rolling without sliding
   
* Initial angular velocity is anti-aligned with the velocity of the center of mass.
  
  5. Sliding with counter-rolling
  6. Sliding with counter-rolling to sliding without rolling before rolling without sliding
  7. Sliding with counter-rolling to counter-sliding without rolling before counter-rolling without sliding

Among the 7 cases, the main focus is rolling resistance. The analysis of rolling resistance is shown in following [2].

![Analysis of rolling resistance [2]](doc/rolling_resistance.png)

### Collision Between Two Balls

The second feature of this project is to consider the ball-ball interaction.
Where we assume that there is no friction between the balls, and thence there is no exchange of angular momentum.
The remaining consideration is the restitution coefficient of the collision.
With the coefficient of restitution between balls is $e$, the velocity of the center of mass of the two balls after collision is

$$
v_1 = \frac{u_1+u_2+e(u_2-u_1)}{2},\quad v_2 = \frac{u_1+u_2+e(u_1-u_2)}{2}
$$

### Ball Under Cushion Impacts

The third feature of this project is to consider the ball-cushion impact.
The analysis of ball-cushion impact is shown in followings [3].

![Forces acting on the ball at the moment of collision: a side view along the cushion at table level [3]](doc/ball-cushion_side.png)

![Slip velocities at I and C [3]](doc/ball-cushion_slip_vel.png)

## References

[1] J.-C. Jiang, Y.-H. Chi. Physical Modeling of 2D Billiard. 2022.

[2] 許耀文. 撞球基本杆法的模擬與摩擦力的探討. 2010.

[3] Senthan Mathavan, M Jackson, and Robert Parkin. A theoretical analysis of billiard ball dynamics under cushion impacts. 2010.

[4] Dr. Dave. Pool physics property constants.