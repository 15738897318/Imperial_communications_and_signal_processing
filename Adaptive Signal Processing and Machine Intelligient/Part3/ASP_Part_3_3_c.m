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


% DFT-LMS algorithm
N = 1500;
l = 0:(N-1);
l = l';
w_all = zeros(N, 1500);
w = zeros(1500,1);
mu = 1;
for n = 1:1500
    
    % complex phasor  
    x_n = 1/N * exp( 1i * 2*(n-1)*pi/N * l );
    
    y_n = w' * x_n;
    e_n = y(n) - y_n;
    w = w + mu * conj(e_n) * x_n; 
    
    w_all(:,n) = w;
end

% reorder the weight to show the true frequency
w_reorder = [w_all(N/2+1:end,:);w_all(1:N/2,:)];

% true frequency interval
l = -N/2+1:N/2;
l = l * fs/1500;

% plotting
figure;
[xx,yy] = meshgrid(1:1500,l);
mesh(xx, yy,  abs(w_reorder));
view(2);
ylabel('Frequancy (Hz)','FontSize',fontsize,'interpreter','latex');
xlabel('Time $n$','FontSize',fontsize,'interpreter','latex');
colormap pink;
colorbar;
title('Time-frequency spectrum estimated by DFT-CLMS','FontSize',fontsize,'interpreter','latex');

