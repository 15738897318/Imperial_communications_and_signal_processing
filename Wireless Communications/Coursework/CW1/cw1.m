clc
clear all
close all
%% Parameters
SNR_dB = 0:2:20; % SNE in dB
phi = pi/4; % phase of QPSK modulation
Es = 2; % power of QPSK symbols

%% Simulation BER
addpath('./functions');
load('cw1.mat');

%% Theoretical BER
[BER_siso_th, BER_simo_th, BER_miso_mrt_th, BER_miso_alamouti_th] = BER_theoretical(2, SNR_dB);

%% Plotting

% comparison
figure;
symbol = sqrt(Es) * [cos(phi)+1i*sin(phi);cos(phi+pi/2)+1i*sin(phi+pi/2); 
                     cos(phi+pi)+ 1i*sin(phi+pi);cos(phi-pi/2)+1i*sin(phi-pi/2)];
plot(real(symbol), imag(symbol),'*r','linewidth', 4);
grid on; axis square; 
xlim([-2,2]); ylim([-2,2]);
xlabel('Re'); ylabel('Im');
title('Constellation of QPSK with gray coding');
txt = {'00', '01', '11','10'};
text(real(symbol)+0.1, imag(symbol)+0.1, txt);

figure;
semilogy(SNR_dB, BER_siso_all, '*-r','linewidth',1.5);
hold on;
semilogy(SNR_dB, BER_simo_all, '*-g','linewidth',1.5);
semilogy(SNR_dB, BER_miso_mrt_all, '*-b','linewidth',1.5);
semilogy(SNR_dB, BER_miso_alamouti_all, '*-m','linewidth',1.5);
legend('SISO', 'SIMO with MRC','MISO with MRT','MISO with Alamouti');
x = [0.8 0.7];
y = [0.65 0.35];
a = annotation('textarrow',x,y,'String',{'diversity gain', '(slope increase)'}); a.LineWidth = 1;
x = [0.5 0.15];
y = [0.75 0.75];
a = annotation('textarrow',x,y,'String',{'array gain', '(SNR shift)'}); a.LineWidth = 1;
ylabel('Bit Error Rate');
xlabel('SNR (dB)');
grid on;

% SISO
figure;
subplot(2,2,1);
semilogy(SNR_dB, BER_siso_all, '*-r','linewidth',1);
hold on;
semilogy(SNR_dB, BER_siso_th,'o--b','linewidth',1);
legend('Simulation','Theoretical');
title('SISO');
ylabel('Bit Error Rate');
xlabel('SNR (dB)');
grid on;

% SIMO
subplot(2,2,2);
semilogy(SNR_dB, BER_simo_all, '*-r','linewidth',1);
hold on;
semilogy(SNR_dB, BER_simo_th,'o--b','linewidth',1);
legend('Simulation','Theoretical');
title('SIMO, MRC');
ylabel('Bit Error Rate');
xlabel('SNR (dB)');
grid on;

% MISO with MRT
subplot(2,2,3);
semilogy(SNR_dB, BER_miso_mrt_all, '*-r','linewidth',1);
hold on;
semilogy(SNR_dB, BER_miso_mrt_th,'o--b','linewidth',1);
legend('Simulation','Theoretical');
title('MISO, MRT');
ylabel('Bit Error Rate');
xlabel('SNR (dB)');
grid on;

% MISO with Alamouti scheme
subplot(2,2,4);
semilogy(SNR_dB, BER_miso_alamouti_all, '*-r','linewidth',1);
hold on;
semilogy(SNR_dB, BER_miso_alamouti_th,'o--b','linewidth',1);
legend('Simulation','Theoretical');
title('MISO, Alamouti');
ylabel('Bit Error Rate');
xlabel('SNR (dB)');
grid on;
