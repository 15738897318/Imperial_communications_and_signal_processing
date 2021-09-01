clc
clear all
close all
addpath('./functions/');

fontsize = 13;
% Parameters
Fs = 200; % Sampling frequency                    
T = 1/Fs; % Sampling period       
N = 128; % Length of signal
t = (0:N-1)*T; % time interval
nfft = 2048; % fft samples
f = Fs*(0:(nfft/2))/nfft; % frequency interval
sampleNum = 100; % number of samples


%% Sine signal
x = 0.7*sin(2*pi*30*t) + sin(2*pi*60*t) + 0.3*randn(1, length(t));

% Biased and Unbiased ACF
[acf_biased,k_biased] = myACF(x,'biased');
[acf_unbiased, k_unbiased] = myACF(x,'unbiased');

figure;
subplot(2,1,1);
plot(k_unbiased,acf_unbiased, '-r','LineWidth', 1.5);
hold on;
plot(k_biased,acf_biased, '-b','LineWidth', 1.5);
grid on;
xlabel('$k$','FontSize',fontsize,'interpreter','latex'); 
ylabel('Magnitude','FontSize',fontsize,'interpreter','latex'); 
title('ACF','FontSize',fontsize,'interpreter','latex'); 
xlim([-(N-1),N-1]);
legend('Unbiased estimator','Biased estimator','FontSize',fontsize,'interpreter','latex');

% Correlogram
[PSD_biased] = myCorrelogram(acf_biased,nfft,k_biased,'');
[PSD_unbiased] = myCorrelogram(acf_unbiased,nfft,k_unbiased,'');

subplot(2,1,2);
plot(f, PSD_unbiased(1:nfft/2+1),'-r', 'LineWidth', 1.5);
hold on;
plot(f, PSD_biased(1:nfft/2+1),'-b', 'LineWidth', 1.5);
grid on;
ylabel('Power/frequency (Hz$^{-1}$)','FontSize',fontsize,'interpreter','latex'); 
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
title('PSD estimated by Correlogram Spectral Estimator','FontSize',fontsize,'interpreter','latex');
legend('Uniased', 'Biased','FontSize',fontsize,'interpreter','latex');

%% WGN signal (average value is calculated)
acf_biased_ave = zeros(2*N-1,1);
acf_unbiased_ave = zeros(N,1);
PSD_biased_ave = zeros(nfft,1);
PSD_unbiased_ave = zeros(nfft,1);
num = 1000;
for i = 1:num
    x = randn(1, length(t)); % WGN signal
    
    % ACF and Correlogram
    [acf_biased,k_biased] = myACF(x,'biased');
    [acf_unbiased, k_unbiased] = myACF(x,'unbiased');
    [PSD_biased] = myCorrelogram(acf_biased,nfft,k_biased,'');
    [PSD_unbiased] = myCorrelogram(acf_unbiased,nfft,k_unbiased,'');
    
    acf_biased_ave = acf_biased_ave + acf_biased;
    acf_unbiased_ave = acf_unbiased_ave + acf_unbiased;
    PSD_biased_ave = PSD_biased_ave + PSD_biased;
    PSD_unbiased_ave = PSD_unbiased_ave + PSD_unbiased;
end
acf_biased_ave = acf_biased_ave ./ num;
acf_unbiased_ave = acf_unbiased_ave ./ num;
PSD_biased_ave = PSD_biased_ave ./ num;
PSD_unbiased_ave = PSD_unbiased_ave ./ num;

% plotting 
figure;
subplot(2,1,1);
plot(k_unbiased,acf_unbiased_ave, '-r','LineWidth', 1.5);
hold on;
plot(k_biased,acf_biased_ave, '-b','LineWidth', 1.5);
grid on;
xlabel('$k$','FontSize',fontsize,'interpreter','latex'); 
ylabel('Magnitude','FontSize',fontsize,'interpreter','latex'); 
title('ACF','FontSize',fontsize,'interpreter','latex'); xlim([-(N-1),N-1]);
legend('Unbiased estimator','Biased estimator','FontSize',fontsize,'interpreter','latex');

subplot(2,1,2);
plot(f, PSD_unbiased_ave(1:nfft/2+1),'-r', 'LineWidth', 1.5);
hold on;
plot(f, PSD_biased_ave(1:nfft/2+1),'-b', 'LineWidth', 1.5);
grid on;
ylabel('Power/frequency (Hz$^{-1}$)','FontSize',fontsize,'interpreter','latex'); 
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
title('PSD estimated by Correlogram Spectral Estimator','FontSize',fontsize,'interpreter','latex');
legend('Uniased', 'Biased','FontSize',fontsize,'interpreter','latex');