% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/21

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Perform QPSK demodulation of the received data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% symbolsIn (NxL Complex) = L channel symbol chips received.
% phi (Double) = Angle index in degrees of the QPSK constellation points
% Es (Double) = Power of symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% bitsOut (Px1 Integers) = P demodulated bits of 1's and 0's
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [bitsOut]=fQPSKDemodulator(symbolsIn,phi, Es)
%% QPSK demodulation (ML detection)
% L = size(symbolsIn,1);
symbols = sqrt(Es) * [cos(phi)+1i*sin(phi);cos(phi+pi/2)+1i*sin(phi+pi/2); 
                     cos(phi+pi)+ 1i*sin(phi+pi);cos(phi-pi/2)+1i*sin(phi-pi/2)].';
map = [0 0; 0 1; 1 1; 1 0];% map from QPSK symbols to bits
symbolsIn = repmat(symbolsIn,1,4);
distance = abs(symbolsIn-symbols);
[index,~] = find((distance == min(distance,[],2))');% find the minimum distance
bitsOut = map(index,:)';
bitsOut = bitsOut(:);

% bitsOut = zeros(L*2, 1);
% for i = 1:size(index,1)
%     bitsOut(2*i-1:2*i) = map(index(i),:)';
% end
end