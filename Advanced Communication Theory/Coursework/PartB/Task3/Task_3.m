clc
clear all
close all

load('Xmatrix_1_DFarray.mat');
load('Xmatrix_2_DFarray.mat');
load('Xmatrix_3_DFarray.mat');
load('Xmatrix_4_DFarray.mat');
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

%% DOA Localisation
fprintf('Estimate directions of arrival at each Rx\n');

array = [0.1250,0,0;
         0.0625,0.1083,0;
         -0.0625,0.1083,0;
         -0.1250,0,0;
         -0.0625,-0.1083,0;
         0.0625,-0.1083,0];
array = array / (lambda/2); % transfer from meter to half wavelength

% Estimate DOAs using MuSiC cost function
figure();
subplot(2,2,1);
DOAs = zeros(4,1);
DOAs(1) = DOAestimation(x1_DOA,array,'MuSiC cost function Rx_1');
subplot(2,2,2);
DOAs(2) = DOAestimation(x2_DOA,array,'MuSiC cost function Rx_2'); 
subplot(2,2,3);
DOAs(3) = DOAestimation(x3_DOA,array,'MuSiC cost function Rx_3');
subplot(2,2,4);
DOAs(4) = DOAestimation(x4_DOA,array,'MuSiC cost function Rx_4');

fprintf('Program paused. Press enter to continue.\n\n');
pause;

fprintf('DOA Localisation\n');
% Find the angle according to the geometric relationship
p12 = Rx(2,:) - Rx(1,:);
theta12 = atan(p12(2) / p12(1)) * 180/pi + 180;
p34 = Rx(3,:) - Rx(4,:);
theta34 = atan(p34(2) / p34(1)) * 180/pi + 180;
theta = zeros(4,1);
theta(1) = 180-theta12+DOAs(1);
theta(2) = theta12 - DOAs(2);
theta(3) = DOAs(3) - theta34;
theta(4) = 180+theta34-DOAs(4);
theta = theta*pi/180;

% Calculate the distances according to the geometric relationship
p = zeros(4,1);
p(1) = norm(p12) * sin(theta(2)) / sin(theta(1)+theta(2));
p(2) = norm(p12) * sin(theta(1)) / sin(theta(1)+theta(2));
p(3) = norm(p34) * sin(theta(4)) / sin(theta(3)+theta(4));
p(4) = norm(p34) * sin(theta(3)) / sin(theta(3)+theta(4));

b = zeros(2,N);
for i=1:N
    b(1,i) = Rx(i,1) + p(i)*cos(DOAs(i)*pi/180);
    b(2,i) = Rx(i,2) + p(i)*sin(DOAs(i)*pi/180); 
end
b = b(:);
H = kron(ones(N,1),eye(2));
rm_DOA = inv(H'*H)*H'*b;

%% Plotting
figure();
plot(Rx(:,1),Rx(:,2),'or','MarkerSize',8,'LineWidth',2);
grid on;
hold on;
plot(rm_DOA(1),rm_DOA(2),'ob','MarkerSize',8,'LineWidth',2);
plotLine(Rx(1,:),DOAs(1)*pi/180);
plotLine(Rx(2,:),DOAs(2)*pi/180);
plotLine(Rx(3,:),DOAs(3)*pi/180);
plotLine(Rx(4,:),DOAs(4)*pi/180);
title('Direction of Arrival (DOA) Localisation');
axis equal;
legend('Rxs','Tx-DOA');
fprintf(['Tx location estimated by DOA is (' num2str(rm_DOA(1)) ',' num2str(rm_DOA(2)) ')\n']);