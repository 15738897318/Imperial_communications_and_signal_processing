clc
clear all
close all

array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0];
directions = [30, 0; 35, 0 ; 90, 0];
% Z = my_pattern(array);
% plot2d3d(Z,[0:180],0,'gain in dB','initial pattern');

S = spv(array,directions);

% sigma2 = 0.0001;
sigma2 = 0.1;
SNR_dB = 10*log10(1 / sigma2);
Rmm = eye(3);
% Rmm = [1 1 0; 1 1 0; 0 0 1];
Rxx_theoretical = S*Rmm*S' + sigma2*eye(5,5);

load Xaudio/Xaudio.mat
load Ximage/Ximage.mat
% soundsc(real(X_au(2,:)), 11025);
% displayimage(X_im(2,:),image_size, 201,'The received signal at the 2nd antenna');

% covariance matrix in practice
Rxx_au = X_au*X_au' / length(X_au(1,:));
Rxx_im = X_im*X_im' / length(X_im(1,:));

%estimated parameters
directions = [];
Rmm = [];
S = [];
sigma2 = [];

%% Detection Problem
eig_theoretical = eig(Rxx_theoretical);
eig_au = eig(Rxx_au);
eig_im = eig(Rxx_im);

M = 3;

%% Estimation Problem
Sd = spv(array, [90,0]);
wopt = inv(Rxx_theoretical) * Sd;
Z = my_pattern(array, wopt);
plot2d3d(Z,[0:180],0,'gain in dB',['Wiener-Hopf array pattern (theoretical) SNR=',num2str(SNR_dB),'dB']);



%% MUSIC algorithm
% % Theoritical
% Z = music(array, Rxx_theoretical, M);
% plot2d3d(Z,[0:180],0,'gain in dB',['MuSIC spectrum (theoritical & coherent signals) SNR=' num2str(SNR_dB) 'dB']);

% % audio signal
% Z = music(array, Rxx_au, M);
% plot2d3d(Z,[0:180],0,'gain in dB',['MuSIC spectrum (audio signal)']);
% 
% % image signal
% Z = music(array, Rxx_im, M);
% plot2d3d(Z,[0:180],0,'gain in dB',['MuSIC spectrum (image signal)']);
% 
%% Smooth MUSIC
% Z = smooth_music(array, Rxx_theoretical, M, 4);
% plot2d3d(Z,[0:180],0,'gain in dB',['Spatial Smoothing MuSIC spectrum (theoritical & coherent signals) SNR=' num2str(SNR_dB) 'dB']);

