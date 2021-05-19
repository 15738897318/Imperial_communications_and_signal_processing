function [w,e] = LMS_MA_1(x, eta, type, mu_inital, rho, M)
%LMS (GASS) Algorithm for 1-order MA process
%[w] = LMS_MA_1_GNGD(x, mu, rho, M)
%Input:
%   x: data
%   eta: the input signal to LMS
%   type: type of GASS
%           'B' for Benveniste's method; 'F' for Farhang's method; 
%           'M' for Matthews's method; Others for no GASS
%   mu_inital: initial step size
%   rho: step size for updating mu
%   M: filter order
%Output:
%   w: weights
%Author: Zhaolin Wang
%Data: 14/03/2021

w = zeros(M,length(x));
mu = zeros(1,length(x));
e = zeros(1,length(x));
phi = zeros(M,length(x));
mu(M+2) = mu_inital; % initial step size
for n = M+2:length(x)
    
    x_n = flip(eta(n-M:n-1));
    d_n = x(n);
    w_n = w(:,n);
    mu_n = mu(n);
    e_n = d_n - w_n' * x_n;
    w(:,n+1) = w_n + mu_n * e_n * x_n;
    e(n) = e_n;
    
    x_n_1 = flip(x(n-M-1:n-2));
    if strcmp(type, 'B')
        phi_n_1 = phi(:,n-1);
        phi_n = (eye(M) - mu(n-1) * (x_n_1 * x_n_1')) * phi_n_1 + e(n-1)*x_n_1;
        phi(:,n) = phi_n;
        mu(n+1) = mu_n + rho * e_n * x_n' * phi_n;
    elseif strcmp(type, 'F')
        phi_n_1 = phi(:,n-1);
        phi_n = 0.5 * phi_n_1 + e(n-1)*x_n_1;
        phi(:,n) = phi_n;
        mu(n+1) = mu_n + rho * e_n * x_n' * phi_n;
    elseif strcmp(type, 'M')
        phi_n = e(n-1)*x_n_1;
        phi(:,n) = phi_n;
        mu(n+1) = mu_n + rho * e_n * x_n' * phi_n; 
    else
        mu(n+1) = mu_n;
    end
    
end

end

