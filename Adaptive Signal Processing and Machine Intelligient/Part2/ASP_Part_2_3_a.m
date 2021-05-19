clc
clear all
close all

addpath('./functions/');
fontsize = 13;
M = 5;
delta = 0;
mu = 0.01;
num = 100;
n = 1:1000;

e_ave = zeros(length(n),1);
x_hat_ave = zeros(length(n),1);
for k = 1:num
    
    % pure signal
    x = sin(0.01*pi*n');
    
    % MA noise
    eta = zeros(length(n)+2,1);
    wng = randn(length(n)+2,1);
    for i = 3:length(eta)

       eta(i) = wng(i) +  0.5*wng(i-2);
    end
    eta = eta(3:end);

    % noisy signal
    s = x + eta;

    % Adaptive Line Enhancer
    w = zeros(M,1);
    x_hat_all = zeros(length(n),1);
    e_all = zeros(length(n),1);
    for i = (M+delta):length(n)

        u = flip(s(i-delta-M+1:i-delta));
        x_hat = w' * u;
        e = s(i) - x_hat;
        w = w + mu * e * u;

        e_all(i) = e;
        x_hat_all(i) = x_hat;
    end
    
    e_ave = e_ave + e_all;
    x_hat_ave = x_hat_ave + x_hat_all;
end

e_ave = e_ave ./num;
x_hat_ave = x_hat_ave./num;

x_hat_ave = x_hat_ave(delta+M:end);
x = x(M:end-delta);
MPSE = mean((x - x_hat_ave).^2)

figure;
plot(s,'-b','LineWidth',1.5);
grid on;
title('Noised signal','FontSize',fontsize,'interpreter','latex');
ylabel('Magenitude','FontSize',fontsize,'interpreter','latex');
xlabel('Step $n$','FontSize',fontsize,'interpreter','latex');

figure;
plot(x,'-r','LineWidth',1.5)
hold on;
plot(x_hat_ave,'-b','LineWidth',1.5);
% plot(x - x_hat_ave,'-','LineWidth',1,'color',[0,0.7,0])
ylim([-1.5,1.5]);
grid on;
legend('Noiseless signal $x(n)$', 'Estimated signal $\hat{x}(n)$','FontSize',fontsize,'interpreter','latex');
% legend('Noiseless signal $x(n)$', 'Estimated signal $\hat{x}(n)$','Disntance $x(n) - \hat{x}(n)$');
title(['$M$ = ' num2str(M) ', $\Delta$ = ' num2str(delta)],'FontSize',fontsize,'interpreter','latex');
ylabel('Magenitude','FontSize',fontsize,'interpreter','latex');
xlabel('Step $n$','FontSize',fontsize,'interpreter','latex');
