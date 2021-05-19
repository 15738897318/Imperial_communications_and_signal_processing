% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2021/01/27

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulate the MISO Rayleigh fading channel with slow and falt fading,
% using Alamouti scheme
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


function [BER] = fMISOChannel_Alamouti(symbolsIn, n_power, bits, phi, Es)
N = 2; % antenna numbers

L = size(symbolsIn,1); % lengh of the symbol sequence
h = sqrt(1/2) * (randn(1,N) + 1i * randn(1,N)); % Rayleigh fading
Heff = [h; conj(h(2)), -conj(h(1))];
noise = sqrt(n_power/2) * (randn(2,L/2) + 1i * randn(2,L/2)); % complex Gaussian noise

symbolsIn = reshape(symbolsIn,2,[]);
symbols_miso = Heff * (symbolsIn ./ sqrt(2)) + noise;% transmitted through the channel

r = Heff' * symbols_miso; % matched filter
r = reshape(r,1,[]);
bits_estimated = fQPSKDemodulator(r.',phi,Es);
[~,BER] = biterr(bits_estimated, bits);
end

