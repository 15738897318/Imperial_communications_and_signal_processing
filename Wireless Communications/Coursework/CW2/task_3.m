clc
clear all
close all

addpath('./functions/')

nr = 2; % number of antenna at receiver
nt = 2; % number of antenna at transmitter
bitLength = 2000; % length of bit sequence
Es = 1; % symbol power
sample_num = 10000; % the sample number of channel matrix H in Monte Carlo method
SNR_dB = 0:1:20;
phi = pi/4;
QPSKsymbol = sqrt(Es/nt) * [cos(phi)+1i*sin(phi);cos(phi+pi/2)+1i*sin(phi+pi/2); 
                     cos(phi+pi)+ 1i*sin(phi+pi);cos(phi-pi/2)+1i*sin(phi-pi/2)]; % QPSK symbols
c = codebook(QPSKsymbol).'; % code for ML receiver
BER_ML = zeros(1,length(SNR_dB));
BER_ZF = zeros(1,length(SNR_dB));
BER_ZFSIC = zeros(1,length(SNR_dB));
for step = 1:length(SNR_dB)
    step
    snr = 10.^(SNR_dB(step)/10);
    N0 = Es/snr; % nosise power
    
    % Monte Carlo simulation
    for num = 1:sample_num
        bitSent = round(rand(bitLength, nt)); % random bit sequence
        symbolSent = zeros(bitLength/2, nt);
        for i = 1:nt
            [symbolSent(:,i)] = fQPSKModulator(bitSent(:,i), QPSKsymbol); % QPSK modulation
        end
        symbolSent = symbolSent.';
        H = sqrt(1/2) * (randn(nr,nt) + 1i * randn(nr,nt)); % i.i.d Rayleigh fading channel
        noise = sqrt(N0/2) * (randn(nr, length(symbolSent)) + 1i * randn(nr, length(symbolSent)));
        symbolRec = H * symbolSent + noise; % transmit through channel
        BER_ML(step) = BER_ML(step) + MLreceiver(symbolRec, bitSent, QPSKsymbol, H, c);
        BER_ZF(step) = BER_ZF(step) + ZFreceiver(symbolRec, bitSent, QPSKsymbol, H, Es);
        BER_ZFSIC(step) = BER_ZFSIC(step) + ZFSICreceiver(symbolRec, symbolSent, bitSent, QPSKsymbol, H, Es);
    end
    BER_ML(step) = BER_ML(step)/sample_num;
    BER_ZF(step) = BER_ZF(step)/sample_num;
    BER_ZFSIC(step) = BER_ZFSIC(step)/sample_num;
end

%% plotting
% load('./task_3.mat');
figure;
semilogy(SNR_dB, BER_ML,'-k','LineWidth',1.3);
hold on;
semilogy(SNR_dB, BER_ZF,'--k','LineWidth',1.3);
semilogy(SNR_dB, BER_ZFSIC,':k','LineWidth',1.3);
grid on;
xlabel('SNR (dB)');
ylabel('Bit Error Rate');
legend('ML','ZF','ZF SIC (perfect cancellation)');
