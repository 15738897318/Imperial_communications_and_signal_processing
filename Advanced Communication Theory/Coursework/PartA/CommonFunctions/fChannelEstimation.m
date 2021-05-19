% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/21

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Performs channel estimation for the desired source using the received
% signal.Only one antenna is used at the receiver and the channel fadding
% coefficients are assumed to be known.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% symbolsIn (Rx1 Complex) = R channel symbol chips received
% goldseq (Ncx1 Integers) = NC bits of 1's and 0's representing the gold
% sequence of the desired source used in the modulation process
% pathNum = Number of multipaths of desired user
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% delay_estimate = Vector of estimates of the delays of each path of the
% desired signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [delay_estimate]=fChannelEstimation(symbolsIn,goldseq,pathNum)
W = size(goldseq,1); % length of gold seq.
N = size(symbolsIn,1); % length of symbol seq.
k = floor(N/W)-1;
goldseq = (1 - 2*goldseq);

% Estimate the delays using correlator
results = zeros(W-1,1);
for i = 1:W-1
    sta = i;
    en = k*W+i-1;
    s = reshape(symbolsIn(sta:en),W,k);
    results(i) = mean(abs(goldseq' * s));
end
[~,delay_estimate] = maxk(results, pathNum);
delay_estimate = sort(delay_estimate - 1);
end