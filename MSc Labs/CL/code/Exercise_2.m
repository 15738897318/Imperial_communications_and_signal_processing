clc;
close all;
clear all;
SNR_dB = 0:5:35;
symbol_num = 100000;
N = 2; % #antenna
bit_symbol = 2;
bit_seq = round(rand(N,symbol_num * bit_symbol));
BERs_ZF = zeros(1,size(SNR_dB,2));
BERs_ML = zeros(1,size(SNR_dB,2));
BERs_MMSE = zeros(1,size(SNR_dB,2));
% H = sqrt(1/2) * (randn(N) + 1i*randn(N));
H_num = 200;
for i = 1:size(SNR_dB,2)
    i
    ML_buffer = zeros(1,H_num);
    ZF_buffer = zeros(1,H_num);
    MMSE_buffer = zeros(1,H_num);
    for j = 1:H_num
        tic
        H = sqrt(1/2) * (randn(N) + 1i*randn(N));
        ML_buffer(j) = MIMO_ML(SNR_dB(i),symbol_num,bit_seq, H, N, bit_symbol);
        H = sqrt(1/2) * (randn(N) + 1i*randn(N));
        ZF_buffer(j) = MIMO_ZF(SNR_dB(i),symbol_num,bit_seq, H, N, bit_symbol);
        H = sqrt(1/2) * (randn(N) + 1i*randn(N));
        MMSE_buffer(j) = MIMO_MMSE(SNR_dB(i),symbol_num,bit_seq, H, N, bit_symbol);
        toc
    end
    BERs_ZF(i) = mean(ZF_buffer);
    BERs_ML(i) = mean(ML_buffer);
    BERs_MMSE(i) = mean(MMSE_buffer);
end
figure(1);
semilogy(SNR_dB, BERs_ZF);
hold on;
semilogy(SNR_dB, BERs_ML);
semilogy(SNR_dB, BERs_MMSE);
grid on;
axis([0,35,-inf,1]);
xlabel('SNR(dB)');
ylabel('Bit Error Rate');
legend('ZF','ML','MMSE');