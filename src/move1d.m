function [ballp, ballv, ballangv, time] = move1d(pos, vel, angvel)
% Obtain position, time, velocity, angular velocity array of a billiard ball on billiard table.

    %% Billiard Constants
    m = 0.17;
    mu = 0.07;
    rho = 0.0005;
    r = 0.05715/2;
    g = 9.81;
    Ic = 2*m*r^2/5;
    fk = m*g*mu;
    %% Initial Condition
    ballp(1) = pos;
    ballv(1) = vel;
    ballangv(1) = angvel;
    time(1) = 0;
    %% Iteration Settings
    dt = 0.001;
    endl = 1;
    %% Case Selector
    if vel > 0
        if angvel == 0 % Case 1
            sliptoroll1;
            roll1;
        elseif angvel > 0
            if ballv(endl) == ballangv(endl) * r % Case 2
                roll1;
            elseif ballv(endl) > ballangv(endl) * r % Case 3
                sliptoroll1;
                roll1;
            else % Case 4
                sliptoroll2;
                roll1;
            end
        elseif angvel < 0 % Case 5,6,7
            %% The process from vel > 0 and r*angvel < 0 to one of them become 0
            while 1
                ballangv(endl+1) = ballangv(endl) + (fk*r/Ic - 5*rho*g/7/r^2)*dt;
                ballv(endl+1) = ballv(endl) + (-fk/m + 5*rho*g/7/r)*dt;
                ballp(endl+1) = ballp(endl) + ballv(endl)*dt;
                time(endl+1) = time(endl) + dt;
                if(ballangv(endl+1)*r>= 0||ballv(endl+1)<=0)
                    break
                end
                endl = endl + 1;
            end
            %% Case 5,6,7 Selector
            if(ballangv(endl+1)*r >= 0&&ballv(endl+1) <= 0) % Case 5
                return
            elseif(ballangv(endl+1)*r >= 0) % Case 6
                sliptoroll1;
                roll1;
            else % Case 7
                sliptoroll3;
                roll2;
            end
        end
    elseif vel < 0
        if angvel == 0 % Case 1
            sliptoroll1r;
            roll1r;
        elseif angvel < 0
            if ballv(endl) == ballangv(endl) * r % Case 2
                roll1r;
            elseif ballv(endl) > ballangv(endl) * r % Case 3
                sliptoroll1r;
                roll1r;
            else % Case 4
                sliptoroll2r;
                roll1r;
            end
        elseif angvel > 0 % Case 5,6,7
            %% The process from vel < 0 and r*angvel > 0 to one of them become 0
            while 1
                ballangv(endl+1) = ballangv(endl) - (fk*r/Ic - 5*rho*g/7/r^2)*dt;
                ballv(endl+1) = ballv(endl) - (-fk/m + 5*rho*g/7/r)*dt;
                ballp(endl+1) = ballp(endl) + ballv(endl)*dt;
                time(endl+1) = time(endl) + dt;
                if(ballangv(endl+1)*r<= 0||ballv(endl+1)>=0)
                    break
                end
                endl = endl + 1;
            end
            %% Case 5,6,7 Selector
            if(ballangv(endl+1)*r <= 0&&ballv(endl+1) >= 0) % Case 5
                return
            elseif(ballangv(endl+1)*r <= 0) % Case 6
                sliptoroll1r;
                roll1r;
            else % Case 7
                sliptoroll3r;
                roll2r;
            end
        end
    end
    ballp = ballp(1:endl);
    ballv = ballv(1:endl);
    ballangv = ballangv(1:endl);
    time = time(1:endl);

    %% Nestedfunctions
    function sliptoroll1 % The process from vel > r*angvel > 0 to vel = angvel
        while 1
            ballangv(endl+1) = ballangv(endl) + (fk*r/Ic - 5*rho*g/7/r^2)*dt;
            ballv(endl+1) = ballv(endl) + (-fk/m - 5*rho*g/7/r)*dt;
            ballp(endl+1) = ballp(endl) + ballv(endl)*dt;
            time(endl+1) = time(endl) + dt;
            if(ballangv(endl+1)*r>=ballv(endl+1))
                break
            end
            endl = endl + 1;
        end
    end
    
    function sliptoroll2 % The process from r*angvel > vel to vel = angvel
        while 1
            ballangv(endl+1) = ballangv(endl) + (-fk*r/Ic - 5*rho*g/7/r^2)*dt;
            ballv(endl+1) = ballv(endl) + (fk/m - 5*rho*g/7/r)*dt;
            ballp(endl+1) = ballp(endl) + ballv(endl)*dt;
            time(endl+1) = time(endl) + dt;
            if(ballangv(endl+1)*r<=ballv(endl+1))
                break
            end
            endl = endl + 1;
        end
    end

    function sliptoroll3 % The process from r*angvel < vel < 0 to vel = angvel
        while 1
            ballangv(endl+1) = ballangv(endl) + (fk*r/Ic + 5*rho*g/7/r^2)*dt;
            ballv(endl+1) = ballv(endl) + (-fk/m + 5*rho*g/7/r)*dt;
            ballp(endl+1) = ballp(endl) + ballv(endl)*dt;
            time(endl+1) = time(endl) + dt;
            if(abs(ballangv(endl+1)*r)<=abs(ballv(endl+1)))
                break
            end
            endl = endl + 1;
        end
    end

    function roll1 % The process from r*angvel = vel > 0 to vel = angvel = 0
        while 1
            ballangv(endl+1) = ballangv(endl) - 5*rho*g/7/r^2*dt;
            ballv(endl+1) = ballv(endl) - 5*rho*g/7/r*dt;
            ballp(endl+1) = ballp(endl) + ballv(endl)*dt;
            time(endl+1) = time(endl) + dt;
            if(ballv(endl+1)<=0)
                break
            end
            endl = endl + 1;
        end
    end

    function roll2 % The process from r*angvel = vel < 0 to vel = angvel = 0
        while 1
            ballangv(endl+1) = ballangv(endl) + 5*rho*g/7/r^2*dt;
            ballv(endl+1) = ballv(endl) + 5*rho*g/7/r*dt;
            ballp(endl+1) = ballp(endl) + ballv(endl)*dt;
            time(endl+1) = time(endl) + dt;
            if(ballv(endl+1)>=0)
                break
            end
            endl = endl + 1;
        end
    end

    function sliptoroll1r % The process from vel < r*angvel < 0 to vel = angvel
        while 1
            ballangv(endl+1) = ballangv(endl) - (fk*r/Ic - 5*rho*g/7/r^2)*dt;
            ballv(endl+1) = ballv(endl) - (-fk/m - 5*rho*g/7/r)*dt;
            ballp(endl+1) = ballp(endl) + ballv(endl)*dt;
            time(endl+1) = time(endl) + dt;
            if(ballangv(endl+1)*r<=ballv(endl+1))
                break
            end
            endl = endl + 1;
        end
    end
    
    function sliptoroll2r % The process from r*angvel < vel < 0 to vel = angvel
        while 1
            ballangv(endl+1) = ballangv(endl) - (-fk*r/Ic - 5*rho*g/7/r^2)*dt;
            ballv(endl+1) = ballv(endl) - (fk/m - 5*rho*g/7/r)*dt;
            ballp(endl+1) = ballp(endl) + ballv(endl)*dt;
            time(endl+1) = time(endl) + dt;
            if(ballangv(endl+1)*r>=ballv(endl+1))
                break
            end
            endl = endl + 1;
        end
    end

    function sliptoroll3r % The process from r*angvel > vel > 0 to vel = angvel
        while 1
            ballangv(endl+1) = ballangv(endl) - (fk*r/Ic + 5*rho*g/7/r^2)*dt;
            ballv(endl+1) = ballv(endl) - (-fk/m + 5*rho*g/7/r)*dt;
            ballp(endl+1) = ballp(endl) + ballv(endl)*dt;
            time(endl+1) = time(endl) + dt;
            if(abs(ballangv(endl+1)*r)<=abs(ballv(endl+1)))
                break
            end
            endl = endl + 1;
        end
    end

    function roll1r % The process from r*angvel = vel < 0 to vel = angvel = 0
        while 1
            ballangv(endl+1) = ballangv(endl) + 5*rho*g/7/r^2*dt;
            ballv(endl+1) = ballv(endl) + 5*rho*g/7/r*dt;
            ballp(endl+1) = ballp(endl) + ballv(endl)*dt;
            time(endl+1) = time(endl) + dt;
            if(ballv(endl+1)>=0)
                break
            end
            endl = endl + 1;
        end
    end

    function roll2r % The process from r*angvel = vel > 0 to vel = angvel = 0
        while 1
            ballangv(endl+1) = ballangv(endl) - 5*rho*g/7/r^2*dt;
            ballv(endl+1) = ballv(endl) - 5*rho*g/7/r*dt;
            ballp(endl+1) = ballp(endl) + ballv(endl)*dt;
            time(endl+1) = time(endl) + dt;
            if(ballv(endl+1)<=0)
                break
            end
            endl = endl + 1;
        end
    end
end

%Ref: 撞球基本杆法的模擬與摩擦力的探討。2010。許耀文。