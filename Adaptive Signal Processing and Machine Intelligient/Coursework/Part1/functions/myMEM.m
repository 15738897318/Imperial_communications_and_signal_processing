function [PSD] = myMEM(acf, p, N, dB)
%myMEM This function is to do the AR spectrum estimation
%[PSD] = myMEM(acf,p,N,dB)
%Inputs:
%   acf: the autocorrelation function (biased or unbiased estimates)
%   p: the order of the AR model
%   N: the number of sequence number in frequency domain
%   dB: if dB = 'dB', the PSD will be calsulated in unit of dB
%Outputs:
%   PSD: power spectrum
%Date: 06/02/2021
%Author: Zhaolin Wang

o = (length(acf)+1)/2; % position of the origin
% Calculate the correlation matrix
R = zeros(p+1, p+1);
for i=0:p
    acf_shift = circshift(acf,i);
    R(:,i+1) = acf_shift(o:o+p);
end
l = zeros(p+1,1);
l(1) = 1;

% Yule-Walker equation
result = inv(R) * l;
sigma_2 = 1/result(1);
ar_coeff = -result(2:end)' * sigma_2;

PSD = myARSpectrum(ar_coeff,sigma_2,N,dB);
end

