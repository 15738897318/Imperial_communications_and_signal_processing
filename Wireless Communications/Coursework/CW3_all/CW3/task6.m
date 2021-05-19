clc
clear all
close all

addpath('result\');
addpath('functions\');

t_all = [];

load('R_nr_2.mat');
[CDF_1,range_1] = CDF(R_average_all,0.01);
t_all = [t_all t];

load('R_nr_2_t_1.mat');
[CDF_2,range_2] = CDF(R_average_all,0.01);
t_all = [t_all t];

load('R_nr_2_t_2.mat');
[CDF_3,range_3] = CDF(R_average_all,0.01);
t_all = [t_all t];

load('R_nr_2_t_3.mat');
[CDF_4,range_4] = CDF(R_average_all,0.01);
t_all = [t_all t];



figure;

plot(range_2, CDF_2,'--r','LineWidth',1.5);
hold on;
plot(range_1, CDF_1,'-b','LineWidth',1.5);
plot(range_4, CDF_4,'-.g','LineWidth',1.5);
plot(range_3, CDF_3,'-.m','LineWidth',1.5);

grid on;
xlabel('average user rate [bits/s/Hz]')
ylabel('CDF [%]');

legend('n_r = 2, t = 0','n_r = 2, t = 0.5','n_r = 2, t = 0.9','n_r = 2, t = 1');