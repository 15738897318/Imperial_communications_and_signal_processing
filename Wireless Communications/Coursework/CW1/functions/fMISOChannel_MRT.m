% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2021/01/25

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulate the MISO Rayleigh fading channel with slow and falt fading,
% using maximum ratio transmission (MRT)
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

function [BER] = fMISOChannel_MRT(symbolsIn, n_power, bits, phi, Es)
N = 2; % antenna numbers

L = size(symbolsIn,1); % lengh of the symbol sequence
h = sqrt(1/2) * (randn(1,N) + 1i * randn(1,N)); % Rayleigh fading
noise = sqrt(n_power/2) * (randn(1,L) + 1i * randn(1,L)); % complex Gaussian noise

w = h' / norm(h);
symbols_mrt = w * symbolsIn.'; % Matched Beamforming
symbols_miso = h * symbols_mrt + noise; % transmitted through the channel

r = symbols_miso;
bits_estimated = fQPSKDemodulator(r.',phi,Es);
[~,BER] = biterr(bits_estimated, bits);

end

