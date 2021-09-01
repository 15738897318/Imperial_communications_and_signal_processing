clc
clear all
close all

addpath('./functions/');
load('./dataset/EEG_Data_Assignment1.mat');

fontsize = 13;
a = 1000;
N = 1200;

% EEG data
y = POz(a:a+N-1);

w_all = zeros(N, N);
w = zeros(N,1);
mu = 1;
l = 0:(N-1);
l = l';
for n = 1:N
    
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
l = l * fs/N;

% plotting
figure;
[xx,yy] = meshgrid(a:a+N-1,l);
mesh(xx, yy,  abs(w_all));
view(2);
ylabel('Frequancy (Hz)','FontSize',fontsize,'interpreter','latex');
xlabel('Time $n$','FontSize',fontsize,'interpreter','latex');
colormap pink;
colorbar;
title('Time-frequency spectrum estimated by DFT-CLMS','FontSize',fontsize,'interpreter','latex');