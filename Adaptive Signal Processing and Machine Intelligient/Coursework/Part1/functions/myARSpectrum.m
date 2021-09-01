function [PSD] = myARSpectrum(coeff, sigma_2, N, dB)
%myARSpectrum This function is to calculate the AR spectrum basd on AR
%coefficients
%[PSD] = myMEM(coeff,sigma_2,N,dB)
%Inputs:
%   coeff: the coefficients of the AR model
%   sigma_2: the noise power of the AR model
%   N: the number of sequence number in frequency domain
%   dB: if dB = 'dB', the PSD will be calsulated in unit of dB
%Outputs:
%   PSD: power spectrum
%Date: 06/02/2021
%Author: Zhaolin Wang

w = 0:2*pi/(N-1):2*pi;
e = exp(-1i * w);
PSD = zeros(N,1);
k = 1:length(coeff);
for i = 1:N
    PSD(i) = sigma_2 / abs(1 - sum(coeff .* e(i).^k))^2;
end

if strcmp(dB, 'dB')
    PSD = 10*log10(PSD); % represent in dB
end

end

