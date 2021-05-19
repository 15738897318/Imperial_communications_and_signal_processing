function p = distanceRSS(x, PTx, lambda,alpha)
PRx = x * x' / size(x,2);
p = (PTx / PRx * (lambda/pi/4)^2) ^ (1/alpha);
end

