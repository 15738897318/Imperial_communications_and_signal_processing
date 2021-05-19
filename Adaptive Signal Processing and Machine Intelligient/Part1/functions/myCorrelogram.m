function [PSD] = myCorrelogram(acf, N, k, dB)
%myCorrelogram This function is to do the Correlogram spectrum estimation
%[PSD] = myCorrelogram(acf,N,dB)
%Inputs:
%   acf: the autocorrelation function (ACF) (biased or unbiased estimates)
%   N: the number of sequence number in frequency domain
%   k: the index of the ACF
%   dB: if dB = 'dB', the PSD will be calsulated in unit of dB
%Outputs:
%   PSD: power spectrum
%Date: 06/02/2021
%Author: Zhaolin Wang

w = 0:2*pi/(N-1):2*pi;
e = exp(1i * w);
PSD = zeros(N,1);
for i = 1:N
    PSD(i) = sum(acf .* e(i).^k);
end
PSD = real(PSD);

if strcmp(dB, 'dB')
    PSD = 10*log10(PSD); % represent in dB
end
end

