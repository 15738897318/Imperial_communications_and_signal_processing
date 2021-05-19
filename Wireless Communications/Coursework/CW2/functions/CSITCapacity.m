function [C] = CSITCapacity(nr,nt,SNR_dB,sample_num)
%Calculate the ergodic capacity with CSIT (full channel knowledge at
%transmitter)
%[C] = CSITCapacity(nr,nt,SNR_dB,sample_num)
%Inputs:
%   nr: number of antennas at receiver
%   nt: number antennas at transmitter
%   SNR_dB: the signal to nosie ratio in unit of dB
%   sample_num: the sample number of channel matrix H in Monte Carlo method
%Outputs:
%   C: the ergodic channel capacity
%Date: 13/02/2021
%Author: Zhaolin Wang

snr = 10.^(SNR_dB/10);
N0 = 1/snr; % noise power

C = 0;
for i = 1:sample_num
    H = sqrt(1/2) * (randn(nr,nt) + 1i * randn(nr,nt)); % i.i.d Rayleigh fading channel
    [s,sigma] = waterFilling(H,N0); % optimal power allocation
    C = C + sum(log2(1 + s .* sigma.^2 / N0)); % instantaneous  capacity
end
C = C/sample_num; % ergodic capacity
end

