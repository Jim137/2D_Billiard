function output=collision2(x1,y1,x2,y2,time1,time2)
    r = 0.05715/2;
    if(length(time1)==length(time2))
        for i = 1:length(x1)
            if((x1(i)-x2(i))^2+(y1(i)-y2(i))^2<=4*r^2)
                output = [i i];
                return;
            end
        end
    else
        for i = 1:length(time1)
            for j = 1:length(time2)
                if(time1(i)==time2(j))
                    t01 = i;
                    t02 = j;
                    breakboolean = 1;
                    break;
                end
            end
            if breakboolean
                break;
            end
        end
        t = 0;
        while 1
            if((x1(t01+t)-x2(t02+t))^2+(y1(t01+t)-y2(t02+t))^2<=4*r^2)
                output = [t01+t t02+t];
                return;
            end
            t = t+1;
            if(t01+t>length(time1)||t02+t>length(time2))
                break;
            end
        end
    end
    output = [0 0];
    return;
end