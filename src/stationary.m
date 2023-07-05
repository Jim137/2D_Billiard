function [ballpx, ballpy, ballvx, ballvy, ballwx, ballwy, ballwz] = stationary(x, y, time)
    t = length(time);
    ballpx = x*ones(1,t);
    ballpy = y*ones(1,t);
    ballvx = zeros(1,t);
    ballvy = zeros(1,t);
    ballwx = zeros(1,t);
    ballwy = zeros(1,t);
    ballwz = zeros(1,t);
    return;
end