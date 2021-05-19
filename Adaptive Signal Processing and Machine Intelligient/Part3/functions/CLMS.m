function [e_all,h_all] = CLMS(y,x,M,mu,h)
%ACLMS This function is perform Complex Least Mean Square algorithm
%[e_all,h_all] = CLMS(y,x,M,mu,h)
%Inputs:
%   y: original signal
%   x: input signal vector
%   M: order of the filter
%   mu: step size
%   h: initial coefficients of x
%Outputs:
%   e_all: error at all steps
%   h_all: h coefficients at all steps
%Date: 18/03/2021
%Author: Zhaolin Wang



h_all = zeros(M, length(x));
e_all = zeros(1, length(x));
% h = zeros(M,1);
for n = M+1:length(x)
    x_n = flip(x(n-M:n-1));
    y_n = h' * x_n;
    e_n = y(n) - y_n;
    h = h + mu * conj(e_n) * x_n; 
    
    h_all(:,n) = h;
    e_all(n) = e_n;
end

e_all = e_all(M+1:end);
h_all = h_all(:,M+1:end);
end

