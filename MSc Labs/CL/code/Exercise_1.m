clc;
clear all;
close all;
%% basic parameters
N = [6 12 24]; % num of antennas at input and output
N_ave = 10000;
SNR_dB = 0:5:60;
SNR = power(10, SNR_dB/10);
C_buff= zeros(1,N_ave);
C_ergodic = zeros(size(N,2), size(SNR,2));

C_buff_unitary= zeros(1,N_ave);
C_ergodic_unitary = zeros(size(N,2), size(SNR,2));

%% calculate the capacity
for n = 1:size(N,2)
    for k = 1:size(SNR,2)
        % iid Gaussian channel gain
        for i=1:N_ave
            H = sqrt(1/2) * (randn(N(n)) + 1i*randn(N(n))); % channel gain (iid case)
            C_H = det(eye(N(n)) + SNR(k) / N(n) * H * H');
            C_H = log2(C_H); % instance capacity
            C_buff(i) = C_H;
        end   
        % get average value
        C_ergodic(n,k) = real(mean(C_buff)); % ergodic capacity
        
        % unitary channel gain
        C_H_unitary = det(eye(N(n)) + SNR(k) * eye(N(n)));
        C_ergodic_unitary(n,k) = real(log2(C_H_unitary));
    end
end

%% plot
figure(1);
labels = strings(1, 2*size(N,2));
for n = 1:size(N,2)
    plot(SNR_dB, C_ergodic(n,:),'*--');
    hold on;
    plot(SNR_dB, C_ergodic_unitary(n,:),'o-');
    labels(2*n-1) = ['iid Gaussian ' num2str(N(n)) 'x' num2str(N(n))];
    labels(2*n) = ['Unitary ' num2str(N(n)) 'x' num2str(N(n))];
end
legend(labels);
grid on;
ylabel('Capacitty(bps/Hz)');
xlabel('SNR(dB)');
title('Comparision of the unitary channel matrix and iid Gaussian matrix in MIMO');