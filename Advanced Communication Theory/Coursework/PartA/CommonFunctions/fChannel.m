% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/21

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Models the channel effects in the system
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% paths (Mx1 Integers) = Number of paths for each source in the system.
% For example, if 3 sources with 1, 3 and 2 paths respectively then
% paths=[1;3;2]
% symbolsIn (MxR Complex) = Signals being transmitted in the channel
% delay (Cx1 Integers) = Delay for each path in the system starting with
% source 1
% beta (Cx1 Integers) = Fading Coefficient for each path in the system
% starting with source 1
% DOA = Direction of Arrival for each source in the system in the form
% [Azimuth, Elevation]
% SNR = Signal to Noise Ratio in dB
% array = Array locations in half unit wavelength. If no array then should
% be [0,0,0]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% symbolsOut (FxN Complex) = F channel symbol chips received from each antenna
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [symbolsOut]=fChannel(paths,symbolsIn,delay,beta,DOA,SNR,array)

L = size(symbolsIn,2); % length of symbol sequence
N = size(array,1); % number of antennas
M = size(symbolsIn,1); % number of sources
symbolsOut = zeros(N, L+max(delay));
path_num = 1;
for i = 1:M
    for j = 1:paths(i)
        source = zeros(1,L+max(delay));
        d = delay(path_num); % delay of this path
        source(:,d+1:L+d) = symbolsIn(i,:); % delayed signal
        azi = DOA(path_num,1);
        ele = DOA(path_num,2);
        S = exp(-1i*array*K(azi*pi/180,ele*pi/180)); % array manifold vectors
        symbolsPath = S * (beta(path_num) .* source);
        symbolsOut = symbolsOut + symbolsPath;
        path_num = path_num + 1;
    end
end

Pd_dB = 10*log10(sum(abs((beta(1:paths(1)) .* symbolsIn(1,1))).^2)); % power of desired signal

Pn_dB = Pd_dB - SNR; % noise power
Pn = 10.^(Pn_dB/10);
noise = sqrt(Pn/2) * (randn(size(symbolsOut)) + 1i * randn(size(symbolsOut))); % AWGN noise
symbolsOut = symbolsOut + noise;
symbolsOut = symbolsOut.';
end