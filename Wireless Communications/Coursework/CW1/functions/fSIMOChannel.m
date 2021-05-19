% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2021/01/25

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulate the SIMO Rayleigh fading channel with slow and falt fading
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% symbolsIn (Nx1 Complex) = N channel symbol chips
% n_power (Double) = Power of nosie
% bits (Px1 Integers) = P original bits of 1's and 0's
% phi (Double) = Angle index in degrees of the QPSK constellation points
% Es (Double) = Power of symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% BER (Double) = Bit error rate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [BER] = fSIMOChannel(symbolsIn, n_power, bits, phi, Es)
N = 2; % antenna numbers

L = size(symbolsIn,1); % lengh of the symbol sequence
h = sqrt(1/2) * (randn(N,1) + 1i * randn(N,1)); % Rayleigh fading
noise = sqrt(n_power/2) * (randn(N,L) + 1i * randn(N,L)); % complex Gaussian noise
symbols_simo = h * symbolsIn.' + noise; % transmitted through the channel

% Maximal Ratio Combining
r = h'*symbols_simo;
bits_estimated = fQPSKDemodulator(r.',phi,Es);
[~,BER] = biterr(bits_estimated, bits);
end

