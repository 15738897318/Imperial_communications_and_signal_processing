clc
clear all
close all
%% initialization
Nc = 10;
N = 1;
lambda = 0.2;
mu = 0.2;
h = [.1+.1i, .2+.8i, .01+.2i, .1+.9i, .3+.1i, .1+.7i, .09+.02i, .1+.8i, .4+.8i, .1+.3i];
h_2 = abs(h).^2;

%% calaulate the power allocation
P = 1./((lambda - mu.*h_2) * log(2)) - N ./h_2;
P(P<=0) = 0;
% check validation of the result by assuming Pn is zero
validation = h_2./(N * log(2)) - lambda + mu .* h_2;
%% plot
figure(1);
carrierNoise = N ./ h_2;
bar(P+carrierNoise, 1);
hold on;
bar(carrierNoise, 1);
grid on;
legend('allocated power of each subchannel', 'noise to channel ratio');
title(['\lambda = 0.2, \mu = 0.2']);

figure(2);
mu = [0,0.1,0.15,0.2,0.21,0.23,0.24,0.242,0.2435,0.2439];
for i = 1:size(mu,2)
    P = 1./((lambda - mu(i).*h_2) * log(2)) - N ./h_2;
    P(P<=0) = 0;
%     P_all(i,:) = P;
    subplot(2,5,i)
    bar(P+carrierNoise, 1);
    hold on;
    bar(carrierNoise, 1);
    title(['\lambda = 0.2, \mu = ', num2str(mu(i))]);
    grid on;
    hold off;
    ylabel('Power');
    xlabel('No. of Sub-channels');
end
sgtitle('power allocation with the increase of P_d');



