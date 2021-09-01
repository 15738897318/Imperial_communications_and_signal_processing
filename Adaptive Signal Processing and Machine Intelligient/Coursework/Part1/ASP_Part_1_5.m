clc
clear all
close all

addpath('./functions/');
load('./data/RRI-DATA.mat');
load('./data/RAW-ECG.mat');
fontsize = 13;       
nfft = 2048; % fft samples
fsRRI = 4;
f= fsRRI*(0:(nfft/2))/nfft;
T = 1/fsRRI;
dB = 'dB';

xRRI1 = detrend(xRRI1);
xRRI2 = detrend(xRRI2);
xRRI3 = detrend(xRRI3);

%% RRI data
figure;
subplot(3,1,1); plot((0:length(xRRI1)-1)*T, xRRI1,'-b','LineWidth',1.5);
grid on; xlabel('time (s)');
subplot(3,1,2); plot((0:length(xRRI2)-1)*T, xRRI2,'-b','LineWidth',1.5);
grid on; xlabel('time (s)');
subplot(3,1,3); plot((0:length(xRRI3)-1)*T, xRRI3,'-b','LineWidth',1.5);
grid on; xlabel('time (s)');

%% standard periodogram
PSD_RRI_1 = myPeriodogram(xRRI1',nfft,dB,'standard');
PSD_RRI_2 = myPeriodogram(xRRI2',nfft,dB,'standard');
PSD_RRI_3 = myPeriodogram(xRRI3',nfft,dB,'standard');

figure;
subplot(3,1,1);plot(f, PSD_RRI_1,'-b','LineWidth',1);grid on;
ylim([-60,0]);xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
title('Standard Periodogram spectrum estimate (trial 1)','FontSize',fontsize,'interpreter','latex');
ylabel('Magnitude (dB)','FontSize',fontsize,'interpreter','latex');
subplot(3,1,2);plot(f, PSD_RRI_2,'-b','LineWidth',1);grid on;
ylim([-60,0]);xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
title('Standard Periodogram spectrum estimate (trial 2)','FontSize',fontsize,'interpreter','latex');
ylabel('Magnitude (dB)','FontSize',fontsize,'interpreter','latex');
subplot(3,1,3);plot(f, PSD_RRI_3,'-b','LineWidth',1);grid on;
ylim([-60,0]);xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
title('Standard Periodogram spectrum estimate (trial 3)','FontSize',fontsize,'interpreter','latex');
ylabel('Magnitude (dB)','FontSize',fontsize,'interpreter','latex');

%% windowed periodogram
tLen = 50;
wLen = tLen*fsRRI;
PSD_RRI_1 = myPeriodogram(xRRI1',nfft,dB,'bartlett', wLen);
PSD_RRI_2 = myPeriodogram(xRRI2',nfft,dB,'bartlett', wLen);
PSD_RRI_3 = myPeriodogram(xRRI3',nfft,dB,'bartlett', wLen);

figure;
subplot(3,1,1);plot(f, PSD_RRI_1,'-b','LineWidth',1);grid on;
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
title(['Periodogram spectrum estimate (trial 1) window length=' num2str(tLen) 's'],'FontSize',fontsize,'interpreter','latex');
ylabel('Magnitude (dB)','FontSize',fontsize,'interpreter','latex');
subplot(3,1,2);plot(f, PSD_RRI_2,'-b','LineWidth',1);grid on;
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
title(['Periodogram spectrum estimate (trial 2) window length=' num2str(tLen) 's'],'FontSize',fontsize,'interpreter','latex');
ylabel('Magnitude (dB)','FontSize',fontsize,'interpreter','latex');
subplot(3,1,3);plot(f, PSD_RRI_3,'-b','LineWidth',1);grid on;
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
title(['Periodogram spectrum estimate (trial 3) window length=' num2str(tLen) 's'],'FontSize',fontsize,'interpreter','latex');
ylabel('Magnitude (dB)','FontSize',fontsize,'interpreter','latex');

%% AR spectrum estimate
order = 40;
coeff = aryule(xRRI1, order); % estimate AR coefficients
PSD_RRI_1_AR = myARSpectrum(-coeff(2:end), coeff(1), nfft,'dB');
coeff = aryule(xRRI2, order);
PSD_RRI_2_AR = myARSpectrum(-coeff(2:end), coeff(1), nfft,'dB');
coeff = aryule(xRRI3, order);
PSD_RRI_3_AR = myARSpectrum(-coeff(2:end), coeff(1), nfft,'dB');
figure;
subplot(3,1,1); plot(f, PSD_RRI_1_AR(1:nfft/2+1),'-b','LineWidth',1); grid on; 
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
title('AR spectrum estimate (trial 1)','FontSize',fontsize,'interpreter','latex');
ylabel('Magnitude (dB)','FontSize',fontsize,'interpreter','latex');
subplot(3,1,2); plot(f, PSD_RRI_2_AR(1:nfft/2+1),'-b','LineWidth',1); grid on; 
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
title('AR spectrum estimate (trial 2)','FontSize',fontsize,'interpreter','latex');
ylabel('Magnitude (dB)','FontSize',fontsize,'interpreter','latex');
subplot(3,1,3); plot(f, PSD_RRI_3_AR(1:nfft/2+1),'-b','LineWidth',1); grid on; 
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
title('AR spectrum estimate (trial 3)','FontSize',fontsize,'interpreter','latex');
ylabel('Magnitude (dB)','FontSize',fontsize,'interpreter','latex');