clc
clear all
close all
addpath('./functions/');
num = 10000; % sample numbers
ar_coeff = [2.76, -3.81, 2.65, -0.92]; % coefficients of AR process
nf = 1024; % num of frequency samples
N = length(ar_coeff);
sigma2 = 1;

fontsize = 13;
%% Generate AR signal
x = zeros(num+N,1);
ar_coeff_flip = flip(ar_coeff);
for i = N+1:num+N
    x(i) = ar_coeff_flip * x(i-4:i-1) + sqrt(sigma2) * randn(1,1);
end
x = x(N+1:num+N);
x = x(num/2:end);

%% True Power Spectrum
w = 0:2*pi/(nf-1):pi+2*pi/(nf-1);
w = w./pi;
PSD_true = myARSpectrum(ar_coeff,sigma2,nf,'');


%% Estimate Power Spectrum
[acf_biased,k] = myACF(x, 'biased');

% find best model order
p = 2:14;
error = zeros(1,length(p));
for i = 1:length(p)
    PSD_estimated = myMEM(acf_biased,p(i), nf, '');
    error(i) = mean((PSD_true-PSD_estimated) .^2); % mean square error (MSE)
end
figure;
subplot(2,1,1);
semilogy(p, error, '-ob', 'LineWidth', 1.5);
xlabel('$p$','FontSize',fontsize,'interpreter','latex'); 
ylabel('Mean Square Error','FontSize',fontsize,'interpreter','latex'); grid on;

[~,p] = min(error); % minimum MSE
p = p+1;
PSD_estimated_dB = myMEM(acf_biased,p, nf,'dB'); % Best estimate
PSD_true_dB = myARSpectrum(ar_coeff,sigma2,nf,'dB');

subplot(2,1,2);
plot(w, PSD_true_dB(1:nf/2+1),'-b','LineWidth',1.5);
hold on;
plot(w, PSD_estimated_dB(1:nf/2+1), '-r','LineWidth',1.5);
grid on;
xlabel('Frequency (units of $\pi$)','FontSize',fontsize,'interpreter','latex'); 
ylabel('Magnitude(dB)','FontSize',fontsize,'interpreter','latex');xlim([0:1]);
legend('True PSD', ['Best Estimated PSD (p=' num2str(p) ')'],'FontSize',fontsize,'interpreter','latex');

% figure;
% plot(k, acf_biased,'-b','LineWidth', 1.5);
% xlabel('k'); ylabel('Magenitude');
% title('Biased Estimate of ACF'); grid on;

