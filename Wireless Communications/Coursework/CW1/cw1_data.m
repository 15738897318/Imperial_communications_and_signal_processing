clc
clear all
close all

addpath('./functions');
%% Parameters
SNR_dB = 0:2:20; % SNE in dB
L = 5000; % size of bit sequence
phi = pi/4; % phase of QPSK modulation
Es = 2; % power of QPSK symbols
steps = 10000; % steps for Monte Carlo simulation

%% Monte Carlo Simulation
BER_siso_all = zeros(1,length(SNR_dB));
BER_simo_all = zeros(1,length(SNR_dB));
BER_miso_mrt_all = zeros(1,length(SNR_dB));
BER_miso_alamouti_all = zeros(1,length(SNR_dB));
for i = 1:length(SNR_dB)
    i
    snr = 10.^(SNR_dB(i)/10);
    n_power = Es / snr;
    
    BER_siso = 0;
    BER_simo = 0;
    BER_miso_mrt = 0;
    BER_miso_alamouti = 0;
    for step = 1:steps
        bits = round(rand(L,1)); % random bit sequence
        symbols = fQPSKModulator(bits, phi, Es); % QPSK modulation
        
        BER_siso = BER_siso + fSISOChannel(symbols, n_power, bits, phi, Es); % SISO
        BER_simo = BER_simo + fSIMOChannel(symbols, n_power, bits, phi, Es); % SIMO with MRC
        BER_miso_mrt = BER_miso_mrt + fMISOChannel_MRT(symbols, n_power, bits, phi, Es); % MISO with MRT
        BER_miso_alamouti = BER_miso_alamouti + fMISOChannel_Alamouti(symbols, n_power, bits, phi, Es); % MISO with space-time coding
    end
    BER_siso_all(i) = BER_siso/steps;
    BER_simo_all(i) = BER_simo/steps;
    BER_miso_mrt_all(i) = BER_miso_mrt/steps;
    BER_miso_alamouti_all(i) = BER_miso_alamouti/steps;
end

save cw1.mat BER_siso_all BER_simo_all BER_miso_mrt_all BER_miso_alamouti_all