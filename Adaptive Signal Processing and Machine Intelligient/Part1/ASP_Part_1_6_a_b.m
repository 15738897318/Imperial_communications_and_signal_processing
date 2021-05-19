clc
clear all
close all

addpath('./functions/');
load('./data/PCAPCR.mat');

fontsize = 13;
%% Singular Value Decomposition
[U,S,V] = svd(X);
[Unoise, Snoise, Vnoise] = svd(Xnoise);

figure;
subplot(3,1,1);
stem(diag(S),'-ob','LineWidth', 1.5);
grid on; title('Singular Values of $\bf{X}$','FontSize',fontsize,'interpreter','latex');

subplot(3,1,2);
stem(diag(Snoise),'-ob','LineWidth', 1.5);
grid on; title('Singular Values of ${\bf{X}}_{noise}$','FontSize',fontsize,'interpreter','latex');

subplot(3,1,3);
stem(diag((Snoise-S).^2),'-ob','LineWidth', 1.5);
grid on; title('Square Error','FontSize',fontsize,'interpreter','latex');


%% Low rank approximation
rank = 3;
Xdenoise = Unoise(:,1:rank) * Snoise(1:rank, 1:rank) * Vnoise(:,1:rank)';
[Udenoise, Sdenoise, Vdenoise] = svd(Xdenoise);

figure;
subplot(3,1,2);
stem(diag(Sdenoise),'-ob','LineWidth', 1.5);
grid on; title('Singular Values of ${\bf{X}}_{denoise}$','FontSize',fontsize,'interpreter','latex');

%% difference (error)

error_noise = mean((X-Xnoise).^2);
error_denoise = mean((X-Xdenoise).^2);

subplot(3,1,3);
stem(error_noise,'-ob','LineWidth', 1.5);
hold on;
stem(error_denoise,'-or','LineWidth', 1.5);
grid on; title('Mean Square Error of each column in $\bf{X}$','FontSize',fontsize,'interpreter','latex');
xlabel('Column','FontSize',fontsize,'interpreter','latex');
legend('${\bf{X}}_{noise}$', '${\bf{X}}_{denoise}$','FontSize',fontsize,'interpreter','latex');