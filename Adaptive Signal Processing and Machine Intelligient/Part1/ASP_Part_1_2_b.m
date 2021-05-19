clc
clear all
close all

addpath('./functions/');
load('./data/EEG_Data_Assignment1.mat');

fontsize = 13;
T = 1/fs; % sampling period
L = length(POz); % length of sequence
t = (0:L-1)*T; 
% nfft = 2^ceil(log2(L));
nfft = 5*fs;
f = fs*(0:(nfft/2))/nfft;

figure;
plot(t, POz,'-b','LineWidth',1);
title('EEG Signal','FontSize',fontsize,'interpreter','latex'); grid on; 
xlabel('Time (s)','FontSize',fontsize,'interpreter','latex'); ylabel('Magnitude (Volts)','FontSize',fontsize,'interpreter','latex');

%% Standard Periodogram
[Px] = myPeriodogram(POz, nfft, '', 'standard');

figure;
plot(f, Px,'-b','LineWidth',1.5);
hold on;
title('PSD of EEG Signal (Periodogram)','FontSize',fontsize,'interpreter','latex'); grid on; xlim([11,20]);
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex'); ylabel('Power/frequency (Watt/Hz)','FontSize',fontsize,'interpreter','latex');

%% Bartlett's Method
tLen = 10; 
wLen = tLen / T; % window length
Px_bartlett_10 = myPeriodogram(POz, nfft, '','bartlett', wLen);
plot(f, Px_bartlett_10,'-r','LineWidth',1.5); 
xlim([11,20]);
legend('standard', 'window length=10s','FontSize',fontsize,'interpreter','latex');


wLen = 5 / T; % window length
Px_bartlett_5 = myPeriodogram(POz, nfft, '','bartlett', wLen);
wLen = 1 / T; % window length
Px_bartlett_1 = myPeriodogram(POz, nfft, '','bartlett', wLen);

figure;
plot(f, Px_bartlett_10,'-r','LineWidth',1.5); 
hold on;
plot(f, Px_bartlett_5,'-g','LineWidth',1.5); 
plot(f, Px_bartlett_1,'-b','LineWidth',1.5); 
title('PSD of EEG Signal (Periodogram)','FontSize',fontsize,'interpreter','latex'); grid on; xlim([11,20]);
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex'); ylabel('Power/frequency (Watt/Hz)','FontSize',fontsize,'interpreter','latex');
legend('window length= 10s', 'window length= 5s', 'window length= 1s','FontSize',fontsize,'interpreter','latex');
