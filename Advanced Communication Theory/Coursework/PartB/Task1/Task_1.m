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

%% Locations of Rxs
Rx = [0,0; 60,-88; 100,9;60,92];

%% Time of Arrival
fprintf('Estimate time of arrival at each Rx\n');

figure();
subplot(2,2,1);
t1 = arrivalTime(x1_Time,'t_1') * Ts;
subplot(2,2,2);
t2 = arrivalTime(x2_Time,'t_2') * Ts;
subplot(2,2,3);
t3 = arrivalTime(x3_Time,'t_3') * Ts;
subplot(2,2,4);
t4 = arrivalTime(x4_Time,'t_4') * Ts;

fprintf('Program paused. Press enter to continue.\n\n');
pause;
%% TOA Localisation
fprintf('TOA Localisation.\n');

t0 = 20 * Ts;
p1 = (t1-t0) * c;
p2 = (t2-t0) * c;
p3 = (t3-t0) * c;
p4 = (t4-t0) * c;

H = Rx(2:end,:);
b = 1/2*([norm(Rx(2,:))^2-p2^2;norm(Rx(3,:))^2-p3^2;norm(Rx(4,:))^2-p4^2] + p1^2); 

rm_TOA = inv(H'*H)*H'*b;

% Plotting
figure();
plot(Rx(:,1),Rx(:,2),'or','MarkerSize',8,'LineWidth',2);xlabel('x');ylabel('y');
grid on;
hold on;
plot(rm_TOA(1),rm_TOA(2),'ob','MarkerSize',8,'LineWidth',2);
plotCircle(Rx(1,:),p1);
plotCircle(Rx(2,:),p2);
plotCircle(Rx(3,:),p3);
plotCircle(Rx(4,:),p4);
title('Time of Arrival (TOA) Localisation');
axis equal
legend('Rxs','Tx-TOA');

fprintf(['Tx location estimated by TOA is (' num2str(rm_TOA(1)) ',' num2str(rm_TOA(2)) ')\n']);
fprintf('Program paused. Press enter to continue.\n\n');
pause;

%% TDOA Localisation
fprintf('TDOA Localisation.\n');
p21 = (t2-t1) * c;
p31 = (t3-t1) * c;
p41 = (t4-t1) * c;

% estimate p1
syms p1_unkonwn;
b = 1/2*[
    norm(Rx(2,:))^2-p21^2-2*p21*p1_unkonwn;
    norm(Rx(3,:))^2-p31^2-2*p31*p1_unkonwn;
    norm(Rx(4,:))^2-p41^2-2*p41*p1_unkonwn];
rm = inv(H'*H)*H'*b;
eqn = p1_unkonwn^2 == rm'*rm;
S = solve(eqn,p1_unkonwn);
S = double(S);

p1_estimated = S(S>0); % positive root
b = 1/2*[
    norm(Rx(2,:))^2-p21^2-2*p21*p1_estimated;
    norm(Rx(3,:))^2-p31^2-2*p31*p1_estimated;
    norm(Rx(4,:))^2-p41^2-2*p41*p1_estimated];
rm_TDOA = inv(H'*H)*H'*b;

% Plotting
figure();
plot(Rx(:,1),Rx(:,2),'or','MarkerSize',8,'LineWidth',2);
grid on;
hold on;
plot(rm_TDOA(1),rm_TDOA(2),'ob','MarkerSize',8,'LineWidth',2);
plotCircle(Rx(1,:),p1_estimated);
plotHyperbola(Rx(2,:),Rx(1,:),p21);
plotHyperbola(Rx(3,:),Rx(1,:),p31);
plotHyperbola(Rx(4,:),Rx(1,:),p41);
title('Time Difference of Arrival (TDOA) Localisation');
xlabel('x');ylabel('y');
legend('Rxs','Tx-TDOA');
axis equal

fprintf(['Tx location estimated by TDOA is (' num2str(rm_TDOA(1)) ',' num2str(rm_TDOA(2)) ')\n']);