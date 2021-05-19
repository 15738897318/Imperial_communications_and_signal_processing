clc
clear all
close all

addpath('./functions/');
fontsize = 13;
n = 0:1000; % length of signal
fs = 1000; % sampling frequency
fo = 50; % system frequency
phi = 0; % phase

% Clarke Matrix
C = sqrt(2/3) * [sqrt(1/2) sqrt(1/2)  sqrt(1/2) ;
                 1 -1/2 -1/2;
                 0 sqrt(3)/2 -sqrt(3)/2];


%% Balanced signal
V = 1;
v(1,:) = V * cos(2*pi*fo/fs * n + phi);
v(2,:) = V * cos(2*pi*fo/fs * n + phi - 2*pi/3);
v(3,:) = V * cos(2*pi*fo/fs * n + phi + 2*pi/3);

v_trans = C * v;
v_alpha_b = v_trans(2,:);
v_beta_b = v_trans(3,:);

figure;
scatter(v_alpha_b, v_beta_b,50,'r','filled');
axis equal;axis square;grid on;
xlabel('Real','FontSize',fontsize,'interpreter','latex');ylabel('Imaginary','FontSize',fontsize,'interpreter','latex');
title({'Balanced'; '$V_a=V_b=V_c=1$, $\Delta_b=\Delta_c=0$, $\phi=0$'},'FontSize',fontsize,'interpreter','latex');
xlim([-2,2]);
ylim([-2,2]);

%% Unbalanced signal
Va = 1;
Vb = 1;
Vc = 2;
phi_b = 1/2;
phi_c = 1/3;
v(1,:) = Va * cos(2*pi*fo/fs * n + phi);
v(2,:) = Vb * cos(2*pi*fo/fs * n + phi + phi_b * pi - 2*pi/3);
v(3,:) = Vc * cos(2*pi*fo/fs * n + phi + phi_c * pi + 2*pi/3);

v_trans = C * v;
v_alpha = v_trans(2,:);
v_beta = v_trans(3,:);
figure;
scatter(v_alpha, v_beta,50,'b','filled');
axis equal;axis square;grid on;
xlabel('Real','FontSize',fontsize,'interpreter','latex');ylabel('Imaginary','FontSize',fontsize,'interpreter','latex');
title({'Unbalanced'; [ '$V_a=$' num2str(Va) ', $V_b=$' num2str(Vb) ', $V_c=$' num2str(Vc) ', $\Delta_b=$' num2str(rats(phi_b,3)) '$\pi$, $\Delta_c=$' num2str(rats(phi_c,3)) '$\pi$']},'FontSize',fontsize,'interpreter','latex');
k = 3;
xlim([-k,k]);
ylim([-k,k]);
hold on;
scatter(v_alpha_b, v_beta_b,20,'r','filled');
