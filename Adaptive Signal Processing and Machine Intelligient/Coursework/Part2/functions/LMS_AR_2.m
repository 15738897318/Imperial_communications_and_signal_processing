function [e_all, w_all] = LMS_AR_2(x,N,mu,gamma)
%LMS (Least Mean Square) Algorithm for 2-order AR process
%[e_all, w_all] = LMS_AR_2(x,N,mu,gamma)
%Input:
%   x: data
%   N: order of the AR process
%   mu: step size
%   gamma: used in leaky LMS
%Output:
%   e_all: all the errors
%   w_all: all the AR coefficients
%Author: Zhaolin Wang
%Data: 14/03/2021

w = zeros(N,1); % inital weight
step_max = length(x);
e_all = [];
w_all = [];
for n = 3:step_max
   x_n = [x(n-1); x(n-2)];
   e_n = x(n) - w' * x_n;
   w = (1 - mu * gamma)*w + mu * e_n * x_n;
   e_all = [e_all, e_n];
   w_all = [w_all, w];
end

end

