clc
clear all
close all

addpath('./functions/');

fontsize = 13;
M = 1;
num = 2001;
rho = 0.0005;
K = 100;
mu = 0.1;
w_GNGD_ave = zeros(M, num+1);
w_B_ave = zeros(M, num+1);
e_GNGD_ave = zeros(M, num);
e_B_ave = zeros(M, num);

for k = 1:K
    % MA(1) process
    x = zeros(num,1);
    eta = sqrt(1/2) * randn(num,1);
    for i = 2:num
        x(i) = 0.9*eta(i-1) + eta(i);   
    end

    [w_GNGD,e_GNGD] = LMS_MA_1_GNGD(x, eta, mu, rho, M);
    w_GNGD_ave = w_GNGD_ave + w_GNGD;
    e_GNGD_ave = e_GNGD_ave + 10*log10(e_GNGD.^2);
    
    [w_B,e_B] = LMS_MA_1(x, eta, 'B', mu, rho, M);
    w_B_ave = w_B_ave + w_B;   
    e_B_ave = e_B_ave + 10*log10(e_B.^2);
end

w_B_ave = w_B_ave ./K;
w_GNGD_ave = w_GNGD_ave ./K;

e_B_ave = w_B_ave ./K;
e_GNGD_ave = w_GNGD_ave ./K;

figure;
plot(w_GNGD_ave(1,:), '-b','LineWidth',1.5);
hold on;
plot(w_B_ave(1,:), '-r','LineWidth',1.5);

grid on;
xlim([0,2000]);
% ylim([0,5]);
legend(['GNGD $\mu$ = ' num2str(mu)],['Benveniste $\mu$(0) = ' num2str(mu)],'FontSize',fontsize,'interpreter','latex');
xlabel('Step $n$','FontSize',fontsize,'interpreter','latex');
ylabel('Weight Estimates $w(n)$','FontSize',fontsize,'interpreter','latex');


% figure;
% plot(e_GNGD_ave, '-b','LineWidth',1.5);
% hold on;
% plot(e_B_ave, '-r','LineWidth',1.5);
% ylim([-90,90]);
% xlim([0,2000]);