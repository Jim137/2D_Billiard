function [ballpx, ballpy, ballvx, ballvy, ballwx, ballwy, ballwz, time] = move2d(x, y, vx, vy, wx, wy, wz)
    dt = 0.001;
    ballwz(1) = wz;
    timez(1) = 0;
    i = 1;
    while 1
        if(ballwz(i) == 0)
            break;
        end
        ballwz(i+1) = ballwz(i) - ballwz(i)/abs(ballwz(i))*10*dt;
        timez(i+1) = timez(i) + dt;
        if(ballwz(i+1) <= 0)
            ballwz(i+1) = 0;
            breakboolean = 1;
            break;
        end
        i = i + 1;
    end
    [ballpx, ballvx, ballwx, timex] = move1d(x, vx, wx);
    [ballpy, ballvy, ballwy, timey] = move1d(y, vy, wy);
    if(length(timex)>=length(timey)&&length(timex)>=length(timez))
        time = timex;
    elseif(length(timey)>=length(timex)&&length(timey)>=length(timez))
        time = timey;
    else
        time = timez;
    end
    ballpx = [ballpx ballpx(length(ballpx))*ones(1,length(time)-length(ballpx))];
    ballpy = [ballpy ballpy(length(ballpy))*ones(1,length(time)-length(ballpy))];
    ballvx = [ballvx zeros(1,length(time)-length(timex))];
    ballvy = [ballvy zeros(1,length(time)-length(timey))];
    ballwx = [ballwx zeros(1,length(time)-length(timex))];
    ballwy = [ballwy zeros(1,length(time)-length(timey))];
    ballwz = [ballwz zeros(1,length(time)-length(timez))];
end