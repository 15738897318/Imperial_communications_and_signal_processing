clc
clear all
close all

addpath('./functions/');
fontsize = 13;
ar_coeff = [0.1 0.8]; % coefficients of AR process
num = 1000; % sample numbers
N = length(ar_coeff);
sigma2 = 0.25; % noise power
mu = 0.05; % step size

%% single realization
x = AR_Gen(ar_coeff,sigma2,num);
[e_all] = LMS_AR_2(x,N,mu,0);

figure;
subplot(2,1,1);
plot(10*log10(e_all.^2), '-b');
grid on;
xlabel('Time','FontSize',fontsize,'interpreter','latex');
ylabel('Squared Prediction Error [dB]','FontSize',fontsize,'interpreter','latex');
title(['Single Realization ($\mu$=', num2str(mu) ')'],'FontSize',fontsize,'interpreter','latex');

%% MSE
e_average_all = zeros(100,num-N);
w_average = zeros(N,1);
for i=1:100
    % Generate AR signal
    x = AR_Gen(ar_coeff,sigma2,1000);

    % LMS
    [e_all, w_all] = LMS_AR_2(x,N,mu,0);
    
    e_average_all(i,:) = e_all;
    w_average = w_average + mean(w_all(:,300:end),2);
end
e_average = mean(10*log10(e_average_all.^2),1);
w_average = w_average / 100;

subplot(2,1,2);
plot(e_average, '-b');
grid on;
xlabel('Time','FontSize',fontsize,'interpreter','latex');
ylabel('MSE [dB]','FontSize',fontsize,'interpreter','latex');
title(['100 Realizations ($\mu$=', num2str(mu) ')'],'FontSize',fontsize,'interpreter','latex');



MSE = mean(mean(e_average_all(:,300:end).^2,2));
M = (MSE - sigma2) / sigma2;

fprintf('The estimated misadjustment for mu=%.2f is %.3f \n',mu, M);
fprintf('The estimated AR coefficients for mu=%.2f is a1 = %.3f and a2 = %.3f \n',mu, w_average(1), w_average(2));
