%% initialization
Nc = 10;
N = 1;
lambda = 0.28;
h = [.1+.1i, .2+.8i, .01+.2i, .1+.9i, .3+.1i, .1+.7i, .09+.02i, .1+.8i, .4+.8i, .1+.3i];
h_2 = abs(h).^2;

%% calaulate the power allocation
P = 1/(lambda * log(2)) - N./h_2;
P(P<=0) = 0;
% check validation of the result by assuming Pn is zero
validation = h_2./(N * log(2)) - lambda;

%% plotting
carrierNoise = N ./ h_2;
bar(P+carrierNoise, 1);
hold on;
bar(carrierNoise, 1);
grid on;
title('Water Filling Solution Using KKT')
legend('allocated power of each subchannel', 'noise to channel ratio');
ylabel('Power');
xlabel('No. of Sub-channels');
