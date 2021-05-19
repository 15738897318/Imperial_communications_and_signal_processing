clc
clear all
close all


addpath('./functions/');
fontsize = 13;
n = 1001; % length of signal
M =1; % order of filter
mu = 0.01; % step size

% coefficients of WLMA(1) model
b1 = 1.5 + 1i; 
b2 = 2.5 - 0.5 * 1i;

e_LMS_ave = zeros(1, n-1);
e_ALMS_ave = zeros(1, n-1);
num = 100;
for k = 1:num
    % WLMA(1) model
    x = sqrt(1/2) * (randn(n,1) + 1i * randn(n,1));
    y = zeros(n,1);
    for i = 2:n
        y(i) = x(i) + b1 * x(i-1) + b2 * conj(x(i-1));
    end
    
    % CLMS algorithm
    h = zeros(M,1);
    [e_LMS,h_LMS] = CLMS(y,x,M,mu,h);
    e_LMS_ave = e_LMS_ave + 10*log10(abs(e_LMS).^2);
    
    % ACLMS algorithm
    h = zeros(M,1);
    g = zeros(M,1);
    [e_ALMS,h_ALMS,g_ALMS] = ACLMS(y,x,M,mu,h,g);
    e_ALMS_ave = e_ALMS_ave + 10*log10(abs(e_ALMS).^2);
end

% average error
e_LMS_ave = e_LMS_ave ./ num;
e_ALMS_ave = e_ALMS_ave ./ num;

% plotting
plot(e_LMS_ave,'-b','LineWidth',1.5);
hold on
plot(e_ALMS_ave,'-r','LineWidth',1.5);
grid on;
xlabel('Step $n$','FontSize',fontsize,'interpreter','latex');
ylabel('$10\log|e(n)|^2$','FontSize',fontsize,'interpreter','latex');
legend('CLMS','ACLMS','FontSize',fontsize,'interpreter','latex');
title('Learning Curve','FontSize',fontsize,'interpreter','latex');

