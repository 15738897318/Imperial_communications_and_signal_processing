function [e_all,h_all,g_all] = ACLMS(y,x,M,mu,h,g)
%ACLMS This function is perform Argumented Complex Least Mean Square algorithm
%[e_all,h_all,g_all] = ACLMS(y,x,M,mu,h,g)
%Inputs:
%   y: original signal
%   x: input signal vector
%   M: order of the filter
%   mu: step size
%   h: initial coefficients of x
%   g: initial coefficients of conjugate x
%Outputs:
%   e_all: error at all steps
%   h_all: h coefficients at all steps
%   g_all: g coefficients at all steps
%Date: 18/03/2021
%Author: Zhaolin Wang


h_all = zeros(M, length(x));
g_all = zeros(M, length(x));
e_all = zeros(1, length(x));

for n = M+1:length(x)
    x_n = flip(x(n-M:n-1));
    
    y_n = h' * x_n + g' * conj(x_n);
    e_n = y(n) - y_n;
    h = h + mu * conj(e_n) * x_n; 
    g = g + mu * conj(e_n) * conj(x_n); 
    
    h_all(:,n) = h;
    g_all(:,n) = g;
    e_all(n) = e_n;
end

e_all = e_all(M+1:end);
h_all = h_all(:,M+1:end);
g_all = g_all(:,M+1:end);
end
