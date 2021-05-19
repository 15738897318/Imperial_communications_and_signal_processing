clc
clear all
close all


addpath('./functions/');
fontsize = 13;
%% low wind
load('./dataset/low-wind.mat');
figure;
scatter(v_east, v_north,'.b');
axis equal;axis square;grid on;
xlabel('Real','FontSize',fontsize,'interpreter','latex');
ylabel('Imaginary','FontSize',fontsize,'interpreter','latex');
title('Low Wind','FontSize',fontsize,'interpreter','latex');
xlim([-0.4,0.4]);
ylim([-0.4,0.4]);

% circularity coefficient 
v_low = v_east + 1i * v_north;
c = 1/length(v_low) * v_low'*v_low;
p = 1/length(v_low) * v_low.'*v_low;
r_low = real(abs(p) / c);
fprintf('Circularity coefficient of low wind is %.3f\n',r_low);

%% medium wind
load('./dataset/medium-wind.mat');
figure;
scatter(v_east, v_north,'.b');
axis equal;axis square;grid on;
xlabel('Real','FontSize',fontsize,'interpreter','latex');
ylabel('Imaginary','FontSize',fontsize,'interpreter','latex');
title('Medium Wind','FontSize',fontsize,'interpreter','latex');
xlim([-2,2]);
ylim([-2,2]);

% circularity coefficient 
v_medium = v_east + 1i * v_north;
c = 1/length(v_medium) * v_medium'*v_medium;
p = 1/length(v_medium) * v_medium.'*v_medium;
r_medium = real(abs(p) / c);
fprintf('Circularity coefficient of medium wind is %.3f\n',r_medium);

%% high wind
load('./dataset/high-wind.mat');
figure;
scatter(v_east, v_north,'.b');
axis equal;axis square;grid on;
xlabel('Real','FontSize',fontsize,'interpreter','latex');
ylabel('Imaginary','FontSize',fontsize,'interpreter','latex');
title('High Wind','FontSize',fontsize,'interpreter','latex');
xlim([-4,4]);
ylim([-4,4]);

% circularity coefficient 
v_high = v_east + 1i * v_north;
c = 1/length(v_high) * v_high'*v_high;
p = 1/length(v_high) * v_high.'*v_high;
r_high = real(abs(p) / c);
fprintf('Circularity coefficient of high wind is %.3f\n',r_high);
