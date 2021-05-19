clc
clear all
close all

addpath('functions\');
addpath('result\');

load('R_10_4.mat');
[CDF1, rang1] = CDF(R_average_all,0.01);

load('R_10_16.mat');
[CDF2, rang2] = CDF(R_average_all,0.01);

load('R_10_64.mat');
[CDF3, rang3] = CDF(R_average_all,0.01);

load('R_5_4.mat');
[CDF4, rang4] = CDF(R_average_all,0.01);

load('R_5_16.mat');
[CDF5, rang5] = CDF(R_average_all,0.01);

load('R_5_64.mat');
[CDF6, rang6] = CDF(R_average_all,0.01);

load('R_7_4.mat');
[CDF7, rang7] = CDF(R_average_all,0.01);
load('R_7_16.mat');
[CDF8, rang8] = CDF(R_average_all,0.01);
load('R_7_64.mat');
[CDF9, rang9] = CDF(R_average_all,0.01);


figure;
plot(rang4, CDF4, '--b', 'LineWidth', 2);
hold on;
plot(rang5, CDF5, '--r', 'LineWidth', 2);
plot(rang6, CDF6, '--g', 'LineWidth', 2);

plot(rang7, CDF7, ':b', 'LineWidth', 2);
plot(rang8, CDF8, ':r', 'LineWidth', 2);
plot(rang9, CDF9, ':g', 'LineWidth', 2);

plot(rang1, CDF1, '-b','LineWidth',2);
plot(rang2, CDF2, '-r', 'LineWidth', 2);
plot(rang3, CDF3, '-g', 'LineWidth', 2);

xlabel('average user rate [bits/s/Hz]');
ylabel('CDF [%]');

grid on;
legend('K = 5,   n_t = 4','K = 5,   n_t = 16','K = 5,   n_t = 64','K = 7,   n_t = 4','K = 7,   n_t = 16','K = 7,   n_t = 64','K = 10, n_t = 4','K = 10, n_t = 16','K = 10, n_t = 64');
