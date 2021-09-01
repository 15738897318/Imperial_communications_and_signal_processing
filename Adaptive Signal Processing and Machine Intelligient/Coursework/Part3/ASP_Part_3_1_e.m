clc
clear all
close all

addpath('./functions/');
fontsize = 13;
fs = 1000; % sampling frequency
fo = 50; % system frequency
phi = 0; % phase

% Clarke Matrix
C = sqrt(2/3) * [sqrt(1/2) sqrt(1/2)  sqrt(1/2) ;
                 1 -1/2 -1/2;
                 0 sqrt(3)/2 -sqrt(3)/2];

%% Balanced signal
n = 0:100;
V = 1;
v(1,:) = V * cos(2*pi*fo/fs * n + phi);
v(2,:) = V * cos(2*pi*fo/fs * n + phi - 2*pi/3);
v(3,:) = V * cos(2*pi*fo/fs * n + phi + 2*pi/3);

v_trans = C * v;
v_alpha = v_trans(2,:);
v_beta = v_trans(3,:);
v_complex = v_alpha + 1i * v_beta;

% CLMS
M = 1;
h = zeros(M,1);
mu = 0.01;
[~,h_all] = CLMS(v_complex,v_complex,M,mu,h);

% estimated system frequency
fo_estimated = fs / (2*pi) * atan(abs(imag(h_all) ./ real(h_all)));
figure;
plot(real(fo_estimated), '-r','LineWidth',1.5);
hold on;

% ACLMS
M = 1;
h = zeros(M,1);
g = zeros(M,1);
mu = 0.1;
[~,h_all,g_all] = ACLMS(v_complex,v_complex,M,mu,h,g);

% estimated system frequency
fo_estimated = fs / (2*pi) * atan(sqrt(imag(h_all).^2 - abs(g_all).^2) ./ real(h_all));
plot(real(fo_estimated), '-b','LineWidth',1.5);
grid on;
legend('CLMS','ACLMS','FontSize',fontsize,'interpreter','latex');
xlabel('Step $n$','FontSize',fontsize,'interpreter','latex');
ylabel('Estimated Frequency $f_o$ (Hz)','FontSize',fontsize,'interpreter','latex');
title('Balanced','FontSize',fontsize,'interpreter','latex');

%% Unbalanced signal
n = 0:1000;
Va = 1;
Vb = 1;
Vc = 2;
phi_b = 0;
phi_c = 1/3;
v2(1,:) = Va * cos(2*pi*fo/fs * n + phi);
v2(2,:) = Vb * cos(2*pi*fo/fs * n + phi + phi_b * pi - 2*pi/3);
v2(3,:) = Vc * cos(2*pi*fo/fs * n + phi + phi_c * pi + 2*pi/3);

v_trans = C * v2;
v_alpha = v_trans(2,:);
v_beta = v_trans(3,:);
v_complex = v_alpha + 1i * v_beta;

% CLMS
M = 1;
h = zeros(M,1);
mu = 0.01;
[~,h_all] = CLMS(v_complex,v_complex,M,mu,h);

% estimated system frequency
fo_estimated = fs / (2*pi) * atan(abs(imag(h_all) ./ real(h_all)));
figure;
plot(real(fo_estimated), '-r','LineWidth',1);
hold on;

% ACLMS
M = 1;
h = zeros(M,1);
g = zeros(M,1);
mu = 0.01;
[~,h_all,g_all] = ACLMS(v_complex,v_complex,M,mu,h,g);

% estimated system frequency
fo_estimated = fs / (2*pi) * atan(sqrt(imag(h_all).^2 - abs(g_all).^2) ./ real(h_all));
plot(real(fo_estimated), '-b','LineWidth',1);
ylim([0,60]);
grid on;
legend('CLMS','ACLMS','FontSize',fontsize,'interpreter','latex');
xlabel('Step $n$','FontSize',fontsize,'interpreter','latex');
ylabel('Estimated Frequency $f_o$ (Hz)','FontSize',fontsize,'interpreter','latex');
title('Unbalanced','FontSize',fontsize,'interpreter','latex');
