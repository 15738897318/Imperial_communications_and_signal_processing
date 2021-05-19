% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/20

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Perform DS-QPSK Modulation on a vector of bits using a gold sequence
% with channel symbols set by a phase phi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% bitsIn (Px1 Integers) = P bits of 1's and 0's to be modulated
% goldseq (Ncx1 Integers) = Nc bits of 1's and 0's representing the gold
% sequence to be used in the modulation process
% phi (Integer) = Angle index in degrees of the QPSK constellation points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% symbolsOut (Rx1 Complex) = R channel symbol chips after DS-QPSK Modulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [symbolOut]=fDSQPSKModulator(bitsIn,goldseq,phi)

%% QPSK modulation
L = size(bitsIn,1) / 2; % length of symbol sequence
symbolSeq = zeros(L,1);
symbol = sqrt(2) * [cos(phi)+1i*sin(phi);cos(phi+pi/2)+1i*sin(phi+pi/2); 
                     cos(phi+pi)+ 1i*sin(phi+pi);cos(phi-pi/2)+1i*sin(phi-pi/2)];
map = [1 2] * [0 0; 0 1; 1 1; 1 0]';

for i = 1:L
    bits = bitsIn(2*i-1:2*i);
    index = [1 2] * bits;
    symbolSeq(i) = symbol(map == index);
end

%% Discrete Sequence Spread Spectrum
goldseq = (1 - 2*goldseq); % transfer goldseq to 1/-1
symbolOut = goldseq * symbolSeq.';
symbolOut = symbolOut(:);
end