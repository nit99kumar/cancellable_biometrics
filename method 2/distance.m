function [d] = distance(x1,y1,x2,y2)
    a = (x2-x1)^2;
    b = (y2-y1)^2;
    d = sqrt(a + b);
end