clc
clear all
close all

addpath('./functions/');

fontsize = 14;

sunspot = load('sunspot.dat');
sunspot = sunspot(:,2);
N = length(sunspot);
nfft = 2048; % fft samples

%% Remove Mean
sunspot_mean_rm = sunspot-mean(sunspot);

[Px] = myPeriodogram(sunspot, nfft, 'dB','standard');
[Px_mean_rm] = myPeriodogram(sunspot_mean_rm, nfft, 'dB', 'standard');

figure;
subplot(2,1,1); 
plot(sunspot, '-b', 'LineWidth', 1.5);
hold on;
plot(sunspot_mean_rm, '-r', 'LineWidth', 1.5);
grid on;
ylabel('Magnitude','FontSize',fontsize,'interpreter','latex'); xlabel('$n$','FontSize',fontsize,'interpreter','latex'); xlim([0,N]);
title('Sunspot Data','FontSize',fontsize,'interpreter','latex'); 
legend('sunspot', 'sunspot-mean-removed','FontSize',fontsize,'interpreter','latex')

subplot(2,1,2);
plot(Px,'-b','LineWidth',1.5);
hold on;
plot(Px_mean_rm,'-r','LineWidth',1.5);
grid on;
ylabel('Magnitude (dB)','FontSize',fontsize,'interpreter','latex'); xlabel('$k$','FontSize',fontsize,'interpreter','latex'); ylim([-20,60]);xlim([0,nfft/2+1]);
title('Power Spectral Density of Sunspot Data','FontSize',fontsize,'interpreter','latex');
legend('PSD', 'PSD-mean-removed','FontSize',fontsize,'interpreter','latex');


%% Removed Trend
sunspot_detrend = detrend(sunspot);
[Px_trend_rm] = myPeriodogram(sunspot_detrend, nfft,'dB', 'standard');

figure;
subplot(2,1,1); 
plot(sunspot, '-b', 'LineWidth', 1.5);
hold on;
plot(sunspot_detrend, '-r', 'LineWidth', 1.5);
grid on;
ylabel('Magnitude','FontSize',fontsize,'interpreter','latex'); xlabel('$n$','FontSize',fontsize,'interpreter','latex'); xlim([0,N]);
title('Sunspot Data','FontSize',fontsize,'interpreter','latex');
legend('sunspot', 'sunspot-trend-removed','FontSize',fontsize,'interpreter','latex');

subplot(2,1,2);
plot(Px,'-b','LineWidth',1.5);
hold on;
plot(Px_trend_rm,'-r','LineWidth',1.5);
grid on;
ylabel('Magnitude (dB)','FontSize',fontsize,'interpreter','latex'); xlabel('$k$','FontSize',fontsize,'interpreter','latex'); ylim([-20,60]);xlim([0,nfft/2+1]);
title('Power Spectral Density of Sunspot Data','FontSize',fontsize,'interpreter','latex');
legend('PSD', 'PSD-trend-removed','FontSize',fontsize,'interpreter','latex')

%% Apply logarithm to data
sunspot_log = 10*log10(sunspot);
sunspot_log = sunspot_log - mean(sunspot_log(sunspot_log~=-Inf));

figure;
subplot(2,1,1);
plot(sunspot, '-b', 'LineWidth', 1.5);
grid on; ylabel('Magnitude','FontSize',fontsize,'interpreter','latex'); xlabel('$n$','FontSize',fontsize,'interpreter','latex'); xlim([0,N]);
title('Sunspot Data','FontSize',fontsize,'interpreter','latex');

subplot(2,1,2);
plot(sunspot_log, '-r', 'LineWidth', 1.5);
grid on; ylabel('Magnitude (dB)','FontSize',fontsize,'interpreter','latex'); xlabel('$n$','FontSize',fontsize,'interpreter','latex'); xlim([0,N]);
title('Mean-removed Logarithmic Sunspot Data','FontSize',fontsize,'interpreter','latex');

