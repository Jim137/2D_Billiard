function [v1x,v1y,v2x,v2y]=vafcolli2(p1x,p1y,p2x,p2y,v1x0,v1y0,v2x0,v2y0)
    e = 0.98;
    theta = atan((p2y-p1y)/(p2x-p1x));
    v1T = -v1x0*sin(theta)+v1y0*cos(theta);
    v2T = -v2x0*sin(theta)+v2y0*cos(theta);
    v1N0 = v1x0*cos(theta)+v1y0*sin(theta);
    v2N0 = v2x0*cos(theta)+v2y0*sin(theta);
    v1N = (1-e)/2*v1N0 + (1+e)/2*v2N0;
    v2N = (1+e)/2*v1N0 + (1-e)/2*v2N0;
    v1x = v1T*(-sin(theta)) + v1N*cos(theta);
    v1y = v1T*cos(theta) + v1N*sin(theta);
    v2x = v2T*(-sin(theta)) + v2N*cos(theta);
    v2y = v2T*cos(theta) + v2N*sin(theta);
end