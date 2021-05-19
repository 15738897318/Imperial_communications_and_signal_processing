% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/20

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Perform DS-QPSK Modulation on a vector of bits with channel symbols set by a phase phi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% bitsIn (Px1 Integers) = P bits of 1's and 0's to be modulated
% phi (Integer) = Angle index in degrees of the QPSK constellation points
% Es (Double) = Power of symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% symbolsOut (Nx1 Complex) = N channel symbol chips after QPSK Modulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [symbolOut]=fQPSKModulator(bitsIn,phi, Es)
%% QPSK modulation
L = size(bitsIn,1) / 2; % length of symbol sequence
% symbolOut = zeros(L,1);
symbol = sqrt(Es) * [cos(phi)+1i*sin(phi);cos(phi+pi/2)+1i*sin(phi+pi/2); 
                     cos(phi+pi)+ 1i*sin(phi+pi);cos(phi-pi/2)+1i*sin(phi-pi/2)];
map = ([1 2] * [0 0; 0 1; 1 1; 1 0]')';

bitsIn = reshape(bitsIn, 2, L);
[index,~] = find(map==([1 2] * bitsIn));
symbolOut = symbol(index);

end