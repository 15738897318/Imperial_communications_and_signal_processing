clc
clear all
close all
addpath('./functions/');
fontsize = 13;
% Parameters
Fs = 1; % Sampling frequency                    
T = 1/Fs; % Sampling period       
N_all = 30:20:100; % Length of signal
nfft = 1024; % fft samples
f = Fs*(0:(nfft/2))/nfft; % frequency interval
sampleNum = 100; % number of samples

figure;
for i=1:length(N_all)
    N = N_all(i); % sequence length
    t = (0:N-1)*T; % time interval
    
    % generate complex signal
    noise = 0.2/sqrt(2)*(randn(1,N)+1i*randn(1,N));
    x = exp(1j*2*pi*0.3*t)+exp(1i*2*pi*0.32*t)+ noise;
    
    % Periodogram PSD estimation
    PSD = myPeriodogram(x,nfft,'dB','standard');
    subplot(2,2,i);
    plot(f, PSD, '-b','LineWidth', 1.5);
    grid on;
    xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex'); 
    ylabel('Power/frequency (dB/Hz)','FontSize',fontsize,'interpreter','latex');
    title(['Periodogram PSD Estimate (N=' num2str(N) ')'],'FontSize',fontsize,'interpreter','latex');
end