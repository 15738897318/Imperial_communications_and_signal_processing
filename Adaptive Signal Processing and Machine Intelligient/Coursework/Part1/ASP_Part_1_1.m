clc
clear all
close all

addpath('./functions/');

Fs = 1000; % Sampling frequency                    
T = 1/Fs; % Sampling period       
L = 200; % Length of signal
t = (0:L-1)*T; 
nfft = 2048; % fft samples
f = Fs*(0:(nfft/2))/nfft;

% sin signal
x = sin(2*pi*300*t)+0.2*randn(1, length(t));

% % delta signal
% x = zeros(1, length(t));
% x(1) = 10;


figure;
subplot(3,1,1);
plot(t,x,'-b','LineWidth',1);title('Sequence','FontSize',13,'interpreter','latex');
grid on;
xlabel('Time t','FontSize',13,'interpreter','latex');
ylabel('Magenitude','FontSize',13,'interpreter','latex');

%% Autocovariance
[acf_x, lags] = xcorr(x);
acf_x = acf_x / L;
subplot(3,1,2);
plot(lags,acf_x,'-b','LineWidth',1);title('ACF','FontSize',13,'interpreter','latex');
grid on;
xlabel('$k$','FontSize',13,'interpreter','latex');
ylabel('Magenitude','FontSize',13,'interpreter','latex');

%% Power Spectral Density

% Definition 2 (Periodogram)
[Px] = myPeriodogram(x, nfft, 'dB', 'standard');
subplot(3,1,3);
plot(f, Px,'-b','LineWidth',1);
grid on;
xlabel('Frequency (Hz)','FontSize',13,'interpreter','latex');
ylabel('Power/frequency (dB/Hz)','FontSize',13,'interpreter','latex');
title('PSD','FontSize',13,'interpreter','latex');
