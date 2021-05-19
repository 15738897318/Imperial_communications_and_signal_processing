function [bitsOut]=fQPSKDemodulator(symbolsIn,symbols)
%Perform QPSK demodulation of the received data
%[bitsOut]=fQPSKDemodulator(symbolsIn,phi, Es)
% Inputs
%   symbolsIn: channel symbol chips received.
%   symbols: the QPSK symbols
% Outputs
%   bitsOut: the demodulated bits of 1's and 0's
% Date: 21/12/2020
% Last Edit Date: 14/02/2020
% Author: Zhaolin Wang

% symbols = sqrt(Es) * [cos(phi)+1i*sin(phi);cos(phi+pi/2)+1i*sin(phi+pi/2); 
%                      cos(phi+pi)+ 1i*sin(phi+pi);cos(phi-pi/2)+1i*sin(phi-pi/2)].';
map = [0 0; 0 1; 1 1; 1 0];% map from QPSK symbols to bits
symbolsIn = repmat(symbolsIn,1,4);
distance = abs(symbolsIn-symbols.');
[index,~] = find((distance == min(distance,[],2))');% find the minimum distance
bitsOut = map(index,:)';
bitsOut = bitsOut(:);
end