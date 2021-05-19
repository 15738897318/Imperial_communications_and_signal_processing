clc
clear all
close all

addpath('./functions/');

fontsize = 13;
mu = 0.0001; % step size
ind = 1:10; % filter orders

%% low wind
load('./dataset/low-wind.mat');
v = v_east + 1i * v_north;
[Rp_CLMS,Rp_ACLMS] = windPredict(v,mu);

figure;
plot(ind,10*log10(Rp_ACLMS),'-b','LineWidth',1.5);
hold on;
plot(ind,10*log10(Rp_CLMS),'-r','LineWidth',1.5);
grid on;
ylabel('Prediction gain $R_p$ (dB)','FontSize',fontsize,'interpreter','latex');
xlabel('Filter length $M$','FontSize',fontsize,'interpreter','latex');


%% medium wind
load('./dataset/medium-wind.mat');
v = v_east + 1i * v_north;
[Rp_CLMS,Rp_ACLMS] = windPredict(v,mu);

plot(ind,10*log10(Rp_ACLMS),'--b','LineWidth',1.5);
hold on;
plot(ind,10*log10(Rp_CLMS),'--r','LineWidth',1.5);


%% high wind
load('./dataset/high-wind.mat');
v = v_east + 1i * v_north;
[Rp_CLMS,Rp_ACLMS] = windPredict(v,mu);

plot(ind,10*log10(Rp_ACLMS),'-.b','LineWidth',1.5);
hold on;
plot(ind,10*log10(Rp_CLMS),'-.r','LineWidth',1.5);
ylim([0,10]);
legend('low, ACLMS','low, CLMS','medium, ACLMS','medium, CLMS','high, ACLMS','high, CLMS','FontSize',11,'interpreter','latex');
