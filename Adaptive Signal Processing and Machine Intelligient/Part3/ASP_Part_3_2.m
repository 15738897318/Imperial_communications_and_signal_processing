clc
clear all
close all

addpath('./functions/');
fontsize = 13;
% frequency signal
f = zeros(1500,1);
f(1:500) = 100;
n = 501:1000;
f(n) = 100 + (n-500)/2;
n = 1001:1500;
f(n) = 100 + ((n-1000)/25).^2;

% phase signal
phi = cumsum(f);
fs = 1000;
eta = sqrt(0.05) * (randn(1500,1) + 1i * randn(1500,1));
y = exp( 1i * (2*pi/fs * phi) ) + eta;


%% AR(1) model
a = aryule(y,1);
[h_AR,w_AR] = freqz(1,a,1024);

%% Adaptive AR(1) model
[e_all,a_all] = CLMS(y,y,1,0.05,0);

for n = 1:length(a_all)
    
    [h,w] = freqz(1, [1; -conj(a_all(n))], 1024);
    H(:,n) = abs(h).^2;
      
end
% Remove outliers in the matrix H
medianH = 50*median(median(H));
H(H > medianH) = medianH;


%% plotting
figure;
plot(1:1500,f,'-b','LineWidth',1.5);
xlabel('Time $n$','FontSize',fontsize,'interpreter','latex'); 
ylabel('$f(n)$','FontSize',fontsize,'interpreter','latex');
xlim([1,1500]);
ylim([0,500]);
grid on;
title('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');

figure;
plot(w_AR/pi * fs/2,20*log10(abs(h_AR)),'-b','LineWidth',1.5)
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
ylabel('Magnitude (dB)','FontSize',fontsize,'interpreter','latex');
grid on;
title('Power spectrum estimated by AR(1) model','FontSize',fontsize,'interpreter','latex')

figure;
[xx,yy] = meshgrid(1:length(a_all),w/pi * fs/2);
mesh(xx, yy,  H);
view(2);
ylabel('Frequancy (Hz)','FontSize',fontsize,'interpreter','latex');
xlabel('Time $n$','FontSize',fontsize,'interpreter','latex');
colormap pink;
colorbar;
title('Time-frequency spectrum estimated by adaptive AR model','FontSize',fontsize,'interpreter','latex');


