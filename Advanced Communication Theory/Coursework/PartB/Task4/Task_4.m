clc
clear all
close all
load('Xmatrix_LAA.mat');
addpath('../CommonFunctions/');
%% System parameters
Fc = 2.4E9; % carrier frequency
c = 3E8; % propogation speed
alpha = 2;% path loss exponent
N = 4; % number of Rx
SNR = 20;
sigma_2 = 5; % noise power in dB
Ts = 5E-9; % sampling period
% lambda = c/Fc;
%% Locations of Rxs
Rx = [0,0; 60,-88; 100,9;60,92];

%% LAA Localisation
for i=1:N
    x = x0_LAA ./ x0_LAA(i,:) .* x0_LAA(1,:);% reference point transformation
    Rxx = x * x' / size(x,2); % covariance matrix
    eigenValues = eig(Rxx);
    eigenValues = sort(eigenValues,'descend');
    r = eigenValues(1); % largest eigenvalues
    sigma_2 = mean(eigenValues(2:end)); % estimated noise power
    lambda(i) = r - sigma_2;
end
K = (lambda(2:end) ./ lambda(1)) .^ (1/(2*alpha));

% Metric fusion stage
H = [2*(ones(N-1,1) * Rx(1,:) - Rx(2:end,:)), (ones(N-1,1) - (K').^2)];
b = norm(Rx(1,:)).^2 * ones(N-1,1) - Rx(2:end,1).^2 - Rx(2:end,2).^2;
rm_LAA = inv(H'*H)*H'*b;

%% Plotting
% Three loci
rc1 = 1/(1-K(1)^2) * Rx(2,:) - K(1)^2/(1-K(1)^2) * Rx(1,:);
Rc1 = abs(K(1)/(1-K(1)^2)) * norm(Rx(2,:) - Rx(1,:));

rc2 = 1/(1-K(2)^2) * Rx(3,:) - K(2)^2/(1-K(2)^2) * Rx(1,:);
Rc2 = abs(K(2)/(1-K(2)^2)) * norm(Rx(3,:) - Rx(1,:));

rc3 = 1/(1-K(3)^2) * Rx(4,:) - K(3)^2/(1-K(3)^2) * Rx(1,:);
Rc3 = abs(K(3)/(1-K(3)^2)) * norm(Rx(4,:) - Rx(1,:));

figure();
grid on;
hold on;
plot(Rx(:,1),Rx(:,2),'or','MarkerSize',8,'LineWidth',2);xlabel('x');ylabel('y');
plot(rm_LAA(1),rm_LAA(2),'ob','MarkerSize',8,'LineWidth',2);
plotCircle(rc1,Rc1);plot(rc1(1),rc1(2),'.k');text(rc1(1),rc1(2),'r_c_1');
plotCircle(rc2,Rc2);plot(rc2(1),rc2(2),'.k');text(rc2(1),rc2(2),'r_c_2');
plotCircle(rc3,Rc3);plot(rc3(1),rc3(2),'.k');text(rc3(1),rc3(2),'r_c_3');
title('Large Aperture Array (LAA) Localisation');
legend('Rxs','Tx-LAA');
axis equal;
fprintf(['Tx location estimated by LAA is (' num2str(rm_LAA(1)) ',' num2str(rm_LAA(2)) ')\n']);