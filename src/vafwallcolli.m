function [v1x,v1y,w1x,w1y,w1z] = vafwallcolli(v1x0,v1y0,wx0,wy0,wz0,colliside)
    e = 0.98;
    muw = 0.14;% friction to cushion
    mus = 0.07;% friction to table
    r = 0.05715/2;
    m = 0.17;
    theta = asin(2/5);
    v0 = sqrt(v1x0^2+v1y0^2);
    % Iteration Settings
    if(colliside == 1||colliside == 3)
        alpha = asin(abs(v1y0/v0));
    elseif(colliside == 2||colliside == 4)
        alpha = asin(abs(v1x0/v0));
    end
    N = 5000;
    dP = ((1+e)*m*v0*sin(alpha)/N);
    % Initializing
    v1p = [0 -1;1 0]^(colliside-1)*[v1x0;v1y0];
    w1p = [0 -1;1 0]^(colliside-1)*[wy0;-wx0];
    vx = [v1p(1) zeros(1,N)];
    vy = [v1p(2) zeros(1,N)];
    wx = [w1p(1) zeros(1,N)];
    wy = [w1p(2) zeros(1,N)];
    wz = [wz0 zeros(1,N)];
    for i = 1:N
        phi = atan((-vy(i)*sin(theta)+wx(i)*r)/(vx(i)+wy(i)*r*sin(theta)-wz(i)*r*cos(theta)));
        phiprime = atan((vy(i)+wx(i)*r)/(vx(i)-wy(i)*r));
        vx(i+1) = vx(i) - 1/m*(muw*cos(phi)+mus*cos(phiprime)*(sin(theta)+muw*sin(phi)*cos(theta)))*dP;
        vy(i+1) = vy(i) - 1/m*(cos(theta)-muw*sin(theta)*sin(phi)+mus*sin(phiprime)*(sin(theta)+muw*sin(phi)*cos(theta)))*dP;
        wx(i+1) = wx(i) - 5/2/m/r*(muw*sin(phi)+mus*sin(phiprime)*(sin(theta)+muw*sin(phi)*cos(theta)))*dP;
        wy(i+1) = wy(i) - 5/2/m/r*(muw*cos(phi)*sin(theta)-mus*cos(phiprime)*(sin(theta)+muw*sin(phi)*cos(theta)))*dP;
        wz(i+1) = wz(i) + 5/2/m/r*muw*cos(phi)*cos(theta)*dP;
    end
    v1xpa = vx(N+1);
    v1ypa = vy(N+1);
    w1xpa = wx(N+1);
    w1ypa = wy(N+1);
    w1z = wz(N+1);
    v1a = [0 1;-1 0]^(colliside-1)*[v1xpa;v1ypa];
    w1a = [0 1;-1 0]^(colliside-1)*[w1xpa;w1ypa];
    v1x = v1a(1);
    v1y = v1a(2);
    w1x = -w1a(2);
    w1y = w1a(1);
    return;
end

% Ref: https://www.researchgate.net/publication/245388279_A_theoretical_analysis_of_billiard_ball_dynamics_under_cushion_impacts