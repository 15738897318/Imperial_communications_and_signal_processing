clc
clear all
close all

addpath('functions\');
%Parameters
K = 1e6; % user number
P = 10^(46/10); % transmit power
noise_pow = 10^(-174/10); % noise power
neighBS = 6; % number of neighbouring BS

user_loc = (rand(K,1)*(250-35) + 35) .* exp(1i * rand(K,1)*2*pi); 
user_loc = [real(user_loc) imag(user_loc)];
interferer_loc = 500 * exp(1i * (0:2*pi/neighBS:(2*pi-2*pi/neighBS))).';
interferer_loc = [real(interferer_loc) imag(interferer_loc)];
% plotLocation(user_loc, interferer_loc);
SINR = zeros(K,1);
for k = 1:K
    user_loc_k = user_loc(k,:);
    d_BS = norm(user_loc_k)/1000;
    d_infer = sum(abs(user_loc_k - interferer_loc).^2,2).^(1/2) ./1000;
    
    SINR(k) = (P / pathLoss(d_BS)) / (noise_pow + sum(P ./ pathLoss(d_infer)));
end

SINR_dB = 10*log10(SINR);
range = floor(min(SINR_dB)) :0.5: ceil(max(SINR_dB));
CDF = zeros(length(range),1);
for i = 1:length(range)
    CDF(i) = length(SINR_dB(SINR_dB<range(i))) / length(SINR_dB) * 100;
end

figure;
plot(range, CDF,'-b','LineWidth',1.5);
grid on;
xlabel('Long-term SINR [dB]')
ylabel('CDF [%]');

    
    
    
