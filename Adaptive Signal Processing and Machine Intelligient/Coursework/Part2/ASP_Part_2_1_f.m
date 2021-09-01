clc
clear all
close all

addpath('./functions/');

ar_coeff = [0.1 0.8]; % coefficients of AR process
num = 1000; % sample numbers
N = length(ar_coeff);
sigma2 = 0.25; % noise power
mu = 0.01; % step size
gamma = 10;


e_average_all = zeros(100,num-N);
w_average = zeros(N,1);
for i=1:100
    % Generate AR signal
    x = AR_Gen(ar_coeff,sigma2,1000);

    % LMS
    [e_all, w_all] = LMS_AR_2(x,N,mu,gamma);
    
    e_average_all(i,:) = e_all;
    w_average = w_average + mean(w_all(:,300:end),2);
end
e_average = mean(10*log10(e_average_all.^2),1);
w_average = w_average / 100;

fprintf('The estimated AR coefficients for (mu=%.2f gamma=%.2f) is a1 = %.3f and a2 = %.3f \n',mu, gamma, w_average(1), w_average(2));
