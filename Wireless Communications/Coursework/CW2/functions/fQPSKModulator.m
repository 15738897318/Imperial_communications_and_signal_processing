function [symbolOut]=fQPSKModulator(bitsIn,symbol)
%Perform DS-QPSK Modulation on a vector of bits with channel symbols set by a phase phi
%[symbolOut]=fQPSKModulator(bitsIn,phi, Es)
% Inputs
%   bitsIn: the bits of 1's and 0's to be modulated
%   symbols: the QPSK symbols
% Outputs
%   symbolsOut: the channel symbol chips after QPSK Modulation
% Date: 20/12/2020
% Last Edit Date: 14/02/2020
% Author: Zhaolin Wang

L = size(bitsIn,1) / 2; % length of symbol sequence
% symbol = sqrt(Es) * [cos(phi)+1i*sin(phi);cos(phi+pi/2)+1i*sin(phi+pi/2); 
%                      cos(phi+pi)+ 1i*sin(phi+pi);cos(phi-pi/2)+1i*sin(phi-pi/2)];
map = ([1 2] * [0 0; 0 1; 1 1; 1 0]')';

bitsIn = reshape(bitsIn, 2, L);
[index,~] = find(map==([1 2] * bitsIn));
symbolOut = symbol(index);

end