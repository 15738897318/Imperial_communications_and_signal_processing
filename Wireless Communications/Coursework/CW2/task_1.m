clc
clear all
close all

SNR_dB = 0:10;
snr = 10.^(SNR_dB/10);
C1 = log2(1+4*snr);
C2 = 2*log2(1+snr);

plot(SNR_dB, C1, '-b','LineWidth',1.5);
hold on;
plot(SNR_dB, C2, '-r','LineWidth',1.5);
grid on;
legend('H_1','H_2');
xlabel('P/N_0(dB)');
ylabel('Channel Capacity');

