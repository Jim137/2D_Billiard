function output=wallcollision(x1,y1,time,bc)
    r = 0.05715/2;
    %球袋大小
    btr = 0.1159; %底袋
    mtr = btr + 0.0127; %中袋
    %球台邊緣
    ypb = 2.54/2;
    ynb = -2.54/2;
    xpb = 1.27/2;
    xnb = -1.27/2;
    for i = 1:length(time)
        dropboolean = ((x1(i)-xpb)^2+y1(i)^2 <= mtr^2 || (x1(i)-xnb)^2+y1(i)^2 <= mtr^2 || (x1(i)-xpb)^2+(y1(i)-ypb)^2 <= btr^2 || (x1(i)-xpb)^2+(y1(i)-ynb)^2 <= btr^2 || (x1(i)-xnb)^2+(y1(i)-ypb)^2 <= btr^2 || (x1(i)-xnb)^2+(y1(i)-ynb)^2 <= btr^2);
        if dropboolean
            output = [i -1];
            return;
        end
        if(abs(x1(i)-xpb)<r&&bc~=2)
            output = [i 2];
            return;
        elseif(abs(x1(i)-xnb)<r&&bc~=4)
            output = [i 4];
            return;
        elseif(abs(y1(i)-ypb)<r&&bc~=1)
            output = [i 1];
            return;
        elseif(abs(y1(i)-ynb)<r&&bc~=3)
            output = [i 3];
            return;
        end
    end
    output = [0 0];
    return;
end

% Ref: http://cuesports.org.tw/wp-content/uploads/%E5%9C%8B%E9%9A%9B%E6%A8%99%E6%BA%96%E8%8A%B1%E5%BC%8F%E6%92%9E%E7%90%83%E6%AA%AF%E8%A6%8F%E6%A0%BC1.pdf