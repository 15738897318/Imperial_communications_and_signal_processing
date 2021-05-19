clc
clear all
close all

fontsize = 13;
% Parameters
Fs = 1; % Sampling frequency                    
T = 1/Fs; % Sampling period       
N = 30; % Length of signal
t = (0:N-1)*T; % time interval
nfft = 1024; % fft samples
f = Fs*(0:(nfft/2))/nfft; % frequency interval

% generate complex signal
noise = 0.2/sqrt(2)*(randn(1,N)+1i*randn(1,N));
x = exp(1j*2*pi*0.3*t)+exp(1i*2*pi*0.32*t)+ noise;

[X,R] = corrmtx(x,14,'mod');
[S,F] = pmusic(R,2,[ ],1,'corr');
plot(F,S,'-b','linewidth',2); set(gca,'xlim',[0.25 0.40]);
grid on; xlabel('Hz','FontSize',fontsize,'interpreter','latex'); 
ylabel('Pseudospectrum','FontSize',fontsize,'interpreter','latex');