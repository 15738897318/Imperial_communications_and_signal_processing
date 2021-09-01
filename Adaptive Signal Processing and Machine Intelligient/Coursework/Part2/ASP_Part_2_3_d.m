clc
clear all
close all

addpath('./functions/');

load('./data/EEG_Data_Assignment2.mat');

fontsize = 13;
T = 1/fs; % sampling period
L = length(POz); % length of sequence

figure;
spectrogram(POz,1000,500,1024,fs);

colormap hot;
title('Spectrum of EEG data (POz)','FontSize',fontsize,'interpreter','latex');
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
ylabel('Time (minutes)','FontSize',fontsize,'interpreter','latex');
hcb=colorbar;
ylabel(hcb,'Power/frequency (dB/Hz)','FontSize',10,'interpreter','latex')

% reference signal
n = 1:L;
r = sin(2*pi*50*n'*T) + randn(L,1);


% ANC
mu = 0.01;
M = 15;
w = zeros(M,1);
e = zeros(length(n),1);
for j = M+1:length(r)
    u_n = flip(r(j-M+1:j));
    d_n = POz(j);
    x_n = w'*u_n;
    e_n = d_n - x_n;
    e(j) = e_n;
    w = w + mu * e_n * u_n;
end
figure;
spectrogram(e,1000,500,1024,fs);
colormap hot;
title(['Spectrum of denoised EEG data (POz) $\mu$ = ' num2str(mu) ', $M$ = ' num2str(M)],'FontSize',fontsize,'interpreter','latex');
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
ylabel('Time (minutes)','FontSize',fontsize,'interpreter','latex');
hcb=colorbar;
ylabel(hcb,'Power/frequency (dB/Hz)','FontSize',10,'interpreter','latex')
