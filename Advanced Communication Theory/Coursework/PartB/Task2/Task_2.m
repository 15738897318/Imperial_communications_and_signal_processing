clc
clear all
close all

load('Rx1.mat');
load('Rx2.mat');
load('Rx3.mat');
load('Rx4.mat');
addpath('../CommonFunctions/');
%% System parameters
Fc = 2.4E9; % carrier frequency
c = 3E8; % propogation speed
alpha = 2;% path loss exponent
N = 4; % number of Rx
SNR = 20;
sigma_2 = 5; % noise power in dB
Ts = 5E-9; % sampling period
lambda = c/Fc;

%% Locations of Rxs
Rx = [0,0; 60,-88; 100,9;60,92];

%% RSS Localisation
fprintf('Estimate ranges from Tx to each Rx\n');
PTx = 150;
PTx = 10^(PTx/10) * 10^(-3); % transfer from dBm to Watt;

% Find the distances using the Riceived Siganal Strength Indicator
p1 = distanceRSS(x1_RSS, PTx, lambda,alpha);
p2 = distanceRSS(x2_RSS, PTx, lambda,alpha);
p3 = distanceRSS(x3_RSS, PTx, lambda,alpha);
p4 = distanceRSS(x4_RSS, PTx, lambda,alpha);

fprintf('RSS Localisation\n');
H = Rx(2:end,:);
b = 1/2*([norm(Rx(2,:))^2-p2^2;norm(Rx(3,:))^2-p3^2;norm(Rx(4,:))^2-p4^2] + p1^2); 
rm_RSS = inv(H'*H)*H'*b;
%% Plotting
figure();
plot(Rx(:,1),Rx(:,2),'or','MarkerSize',8,'LineWidth',2);xlabel('x');ylabel('y');
grid on;
hold on;
plot(rm_RSS(1),rm_RSS(2),'ob','MarkerSize',8,'LineWidth',2);
plotCircle(Rx(1,:),p1);
plotCircle(Rx(2,:),p2);
plotCircle(Rx(3,:),p3);
plotCircle(Rx(4,:),p4);
title('Received Signal Strength (RSS) Localisation');
legend('Rxs','Tx-RSS');
axis equal;

fprintf(['Tx location estimated by RSS is (' num2str(rm_RSS(1)) ',' num2str(rm_RSS(2)) ')\n']);
