function [w,e] = LMS_MA_1_GNGD(x, eta, mu, rho, M)
%LMS_GNGD Algorithm for 1-order MA process
%[w] = LMS_MA_1_GNGD(x, mu, rho, M)
%Input:
%   x: data
%   eta: the input signal to LMS
%   mu: step size
%   rho: step size for updating mu
%   M: filter order
%Output:
%   w: weights
%Author: Zhaolin Wang
%Data: 14/03/2021

w = zeros(M,length(x));
e = zeros(1,length(x));
epsilon = zeros(1,length(x));
epsilon(M+1) = 0.1;
mu_all = zeros(1,length(x));
for n = M+2:length(x)
    
    x_n = flip(eta(n-M:n-1));
    d_n = x(n);
    w_n = w(:,n);
    e_n = d_n - w_n' * x_n;
    
    % update of the regularisation factor
    x_n_1 = flip(x(n-M-1:n-2));
    epsilon_n_1 = epsilon(n-1);
    epsilon(n) = epsilon_n_1 - rho * mu * (e(n)*e(n-1)*x_n'*x_n_1) / ( epsilon_n_1 + x_n_1' * x_n_1 )^2;
    epsilon_n = epsilon(n);
    
    % update of the weight
    w(:,n+1) = w_n + mu / (epsilon_n + x_n'*x_n) * e_n * x_n;
    e(n) = e_n;  
    mu_all(n) = mu / (epsilon_n + x_n'*x_n);
    
    
end

end

