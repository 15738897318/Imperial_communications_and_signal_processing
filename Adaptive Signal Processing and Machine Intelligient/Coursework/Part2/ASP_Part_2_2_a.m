clc
clear all
close all

addpath('./functions/');
fontsize = 13;
M = 1;
num = 2001;
mu = 0.01;
rho = 0.0003;
K = 100;
w_B_ave = zeros(M, num+1);
w_F_ave = zeros(M, num+1);
w_M_ave = zeros(M, num+1);
w_N_ave = zeros(M, num+1);
w_N_ave_2 = zeros(M, num+1);
for k = 1:K

    % MA(1) process
    x = zeros(num,1);
    eta = sqrt(1/2) * randn(num,1);
    for i = 2:num
        x(i) = 0.9*eta(i-1) + eta(i);   
    end
%     x = x(2:end);
    
    % LMS and GASS
    [w_B] = LMS_MA_1(x,eta,'B', mu, rho, M);  
    w_B_ave = w_B_ave + w_B;
    
    [w_F] = LMS_MA_1(x,eta, 'F', mu, rho, M);  
    w_F_ave = w_F_ave + w_F;
    
    [w_M] = LMS_MA_1(x,eta, 'M', mu, rho, M);  
    w_M_ave = w_M_ave + w_M;
    
    [w_N] = LMS_MA_1(x,eta, 'N', mu, rho, M);  
    w_N_ave = w_N_ave + w_N;
    
    [w_N_2] = LMS_MA_1(x,eta, 'N', 0.1, rho, M);  
    w_N_ave_2 = w_N_ave_2 + w_N_2;
end
w_B_ave = w_B_ave ./K;
w_F_ave = w_F_ave ./K;
w_M_ave = w_M_ave ./K;
w_N_ave = w_N_ave ./K;
w_N_ave_2 = w_N_ave_2 ./K;

figure;
plot(0.9 - w_N_ave(1,:), '-m','LineWidth',1.5);
hold on;
plot(0.9 - w_N_ave_2(1,:), '-c','LineWidth',1.5);
plot(0.9 - w_M_ave(1,:), '-g','LineWidth',1.5);
plot(0.9 - w_F_ave(1,:), '-r','LineWidth',1.5);
plot(0.9 - w_B_ave(1,:), '-b','LineWidth',1.5);
grid on;
xlim([0,2000]);
legend(['Standard LMS, $\mu$=', num2str(mu)],'Standard LMS, $\mu$=0.1', ['Matthews, $\mu(0)$=', num2str(mu)], ['Farhang, $\mu(0)$=', num2str(mu)],['Benveniste, $\mu(0)$=', num2str(mu)],'FontSize',fontsize,'interpreter','latex');
xlabel('Step $n$','FontSize',fontsize,'interpreter','latex');
ylabel('Weight Error  $w_o - w(n)$','FontSize',fontsize,'interpreter','latex');
