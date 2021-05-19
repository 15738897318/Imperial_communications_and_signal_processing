clc
clear all
close all

addpath('result\');
addpath('functions\');

tc_all = [];

load('R_baseline.mat');
[CDF_1,range_1] = CDF(R_average_all,0.01);
tc_all = [tc_all tc];

load('R_tc_1');
[CDF_2,range_2] = CDF(R_average_all,0.01);
tc_all = [tc_all tc];

load('R_tc_2');
[CDF_3,range_3] = CDF(R_average_all,0.01);
tc_all = [tc_all tc];


figure;
plot(range_2, CDF_2,'--r','LineWidth',1.5);
hold on;
plot(range_1, CDF_1,'-b','LineWidth',1.5);
plot(range_3, CDF_3,'-.m','LineWidth',1.5);
grid on;
xlabel('average user rate [bits/s/Hz]')
ylabel('CDF [%]');
legend('t_c = 1.1','t_c = 50','t_c = 1e4');