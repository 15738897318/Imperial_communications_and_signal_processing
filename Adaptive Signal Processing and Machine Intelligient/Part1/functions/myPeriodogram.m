function [PSD] = myPeriodogram(x, nfft, dB, type, wLen)
%myCorrelogram This function is to do the Periodogram spectrum estimation
%[PSD] = myCorrelogram(acf,N,dB)
%Inputs:
%   x: the discrete sequence
%   nfft: the number of sequence number in frequency domain
%   dB: if dB = 'dB', the PSD will be calsulated in unit of dB
%   type: 'standard' for the standarf periodogram method; 'bartlett' for
%   the averaged periodogram
%   wLen: if the type is 'bartlett', the window length should be defined
%Outputs:
%   PSD: power spectrum
%Date: 06/02/2021
%Author: Zhaolin Wang

N = length(x);
if (nargin<5)
        wLen = N;
end

% starndard
if strcmp(type, 'standard')
    PSD = abs(fft(x, nfft)).^2 ./ N;
    PSD = PSD(1:nfft/2+1);
    if strcmp(dB ,'dB')
        PSD = 10*log10(PSD);
    end
% averaged
elseif strcmp(type, 'bartlett')
    wNum = ceil(N / wLen);
    PSD = zeros(nfft/2+1,1);
    for i = 1:wNum
        sta = (i-1)*wLen+1;
        en = i*wLen;
        if en > N en = N; end
        x_sub = x(sta : en); 
        PSD = PSD + myPeriodogram(x_sub, nfft, dB, 'standard');
    end
    PSD = PSD ./ wNum;
end
end

