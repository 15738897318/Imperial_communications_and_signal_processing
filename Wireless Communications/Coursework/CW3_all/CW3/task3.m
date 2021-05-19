clc
clear all
close all

addpath('result\')
addpath('functions\');

load('R_baseline.mat');
[CDF_1,range_1] = CDF(R_average_all,0.01);


load('R_nr_2.mat');
[CDF_2,range_2] = CDF(R_average_all,0.01);

figure;
plot(range_1, CDF_1,'-b','LineWidth',1.5);
hold on;
plot(range_2, CDF_2,'--r','LineWidth',1.5);
grid on;
xlabel('average user rate [bits/s/Hz]')
ylabel('CDF [%]');
legend('n_r=1, n_t=4','n_r=2, n_t=4');









