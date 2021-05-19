clc;
close all;
clear all;
SNR_dB = 0:5:35;
symbol_num = 50000;
N = 2; % #antenna
bit_symbol = 2;
bit_seq = round(rand(N,symbol_num * bit_symbol));
H = sqrt(1/2) * (randn(N) + 1i*randn(N));
BERs_SC = zeros(1,size(SNR_dB,2));
BERs = zeros(1,size(SNR_dB,2));

H_num = 200;
for i = 1:size(SNR_dB,2)
    i
    ML_buffer = zeros(1,H_num);
    MLSC_buffer = zeros(1,H_num);
    for j = 1:H_num
        tic
        H = sqrt(1/2) * (randn(N) + 1i*randn(N));
        ML_buffer(j) = MIMO_ML(SNR_dB(i),symbol_num,bit_seq, H, N, bit_symbol);
        H = sqrt(1/2) * (randn(N) + 1i*randn(N));
        MLSC_buffer(j) = MIMO_ML_SC(SNR_dB(i),symbol_num,bit_seq, H, N, bit_symbol);
        toc
    end
    BERs(i) = mean(ML_buffer);
    BERs_SC(i) = mean(MLSC_buffer);
end
figure(1);
semilogy(SNR_dB, BERs);
hold on;
semilogy(SNR_dB, BERs_SC);
grid on;
axis([0,35,-inf,1]);
xlabel('SNR(dB)');
ylabel('Bit Error Rate');
legend('ML','ML with space coding');