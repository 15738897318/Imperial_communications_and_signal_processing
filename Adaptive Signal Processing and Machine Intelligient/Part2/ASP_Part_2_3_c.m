clc
clear all
close all

addpath('./functions/');
fontsize = 13;
M = 10;
n = 1:1000;
num = 100;
% pure signal
x = sin(0.01*pi*n');

e_average = zeros(length(n),num);
for k = 1:num
    % MA noise
    eta = zeros(length(n)+2,1);
    wng = randn(length(n)+2,1);

    for i = 3:length(eta)
       eta(i) = wng(i) +  0.5*wng(i-2);
    end
    eta = eta(3:end);

    s = x+eta;

    % secondary noise
    eta_2 = 0.5*eta + 0.2*randn(length(n),1);

    % ANC
    mu = 0.01;
    w = zeros(M,1);
    e = zeros(length(n),1);
    for j = M+1:length(eta_2)
        u_n = flip(eta_2(j-M+1:j));
        d_n = s(j);
        x_n = w'*u_n;
        e_n = d_n - x_n;
        e(j) = e_n;
        w = w + mu * e_n * u_n;
    end
    e_average(:,k) = e;
end

e_average = mean(e_average,2);
MPSE = mean((x - e_average).^2)

figure;
plot(x, '-r','LineWidth', 1.5);
hold on;
plot(e_average, '-b','LineWidth', 1.5);
grid on;
xlabel('Step $n$','FontSize',fontsize,'interpreter','latex');
ylabel('Magnitude','FontSize',fontsize,'interpreter','latex');
title('$M$ = 10','FontSize',fontsize,'interpreter','latex');
legend('Original signal','Estimated signal','FontSize',fontsize,'interpreter','latex');