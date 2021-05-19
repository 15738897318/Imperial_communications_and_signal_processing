clc
clear all
close all

addpath('result\');
addpath('functions\');

epsilon_all = [];

load('R_epsilon_1.mat');
[CDF_1,range_1] = CDF(R_average_all,0.01);
epsilon_all = [epsilon_all epsilon];

load('R_epsilon_2.mat');
[CDF_2,range_2] = CDF(R_average_all,0.01);
epsilon_all = [epsilon_all epsilon];

load('R_baseline.mat');
[CDF_3,range_3] = CDF(R_average_all,0.01);
epsilon_all = [epsilon_all epsilon];


figure;
plot(range_1, CDF_1,'--r','LineWidth',1.5);
hold on;
plot(range_3, CDF_3,'-b','LineWidth',1.5);
plot(range_2, CDF_2,'-.m','LineWidth',1.5);
grid on;
xlabel('average user rate [bits/s/Hz]')
ylabel('CDF [%]');
legend('\epsilon = 0','\epsilon = 0.85','\epsilon = 0.98');