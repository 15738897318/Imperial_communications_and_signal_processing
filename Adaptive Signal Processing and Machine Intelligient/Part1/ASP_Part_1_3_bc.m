clc
clear all
close all
addpath('./functions/');

fontsize = 13;
% Parameters
Fs = 200; % Sampling frequency                    
T = 1/Fs; % Sampling period       
N = 32; % Length of signal
t = (0:N-1)*T; % time interval
nfft = 2048; % fft samples
f = Fs*(0:(nfft/2))/nfft; % frequency interval
sampleNum = 100; % number of samples

PSD_average = zeros(nfft, 1);
PSD_all = zeros(nfft, sampleNum);
figure;
subplot(2,1,1);
for i=1:sampleNum
    x = 0.7*sin(2*pi*30*t) + sin(2*pi*60*t) + 0.3*randn(1, length(t));
    [acf,k] = myACF(x,'biased'); % Biased ACF
    [PSD] = myCorrelogram(acf,nfft,k,''); % PSD
    plot(f, PSD(1:nfft/2+1),'-c');
    hold on;
    PSD_average = PSD_average + PSD;
    PSD_all(:,i) = PSD;
end

% Average
PSD_average = PSD_average ./ sampleNum;
plot(f, PSD_average(1:nfft/2+1),'-b','LineWidth', 3);
grid on;
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex'); 
ylabel('Power/frequency (Hz$^{-1}$)','FontSize',fontsize,'interpreter','latex');
title('PSD estimates (different realisations and mean)','FontSize',fontsize,'interpreter','latex');

% Standard devition
PSD_std = sqrt(1/sampleNum * sum((PSD_all - PSD_average).^2, 2));
subplot(2,1,2);
plot(f, PSD_std(1:nfft/2+1),'-r','LineWidth', 3);
grid on;
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex'); 
ylabel('Magnitude','FontSize',fontsize,'interpreter','latex');
title('Standard devition of the PSD estimate','FontSize',fontsize,'interpreter','latex');


%% plotting in dB

% Average
PSD_all_dB = 10*log10(PSD_all);
figure;
subplot(2,1,1);
for i = 1:sampleNum
    PSD_dB = PSD_all_dB(:,i);
    plot(f, PSD_dB(1:nfft/2+1),'-c');
    hold on;
end

PSD_average = sum(PSD_all_dB,2) ./ sampleNum;
plot(f, PSD_average(1:nfft/2+1),'-b','LineWidth', 3);
grid on;
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex'); 
ylabel('Power/frequency (dB/Hz)','FontSize',fontsize,'interpreter','latex');
title('PSD estimates (different realisations and mean)','FontSize',fontsize,'interpreter','latex');

% Standard devition
PSD_std = sqrt(1/sampleNum * sum((PSD_all_dB - PSD_average).^2, 2));
subplot(2,1,2);
plot(f, PSD_std(1:nfft/2+1),'-r','LineWidth', 3);
grid on;
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex'); 
ylabel('Magnitude','FontSize',fontsize,'interpreter','latex');
title('Standard devition of the PSD estimate','FontSize',fontsize,'interpreter','latex');

