function [acf, k] = myACF(x,type)
%myMEM This function is to calculate the biased or unbiased ACF
%[acf, k] = myACF(x, type)
%Inputs:
%   x: the discrete sequence
%   type: 'biased' for biased estimate; 'unbiased' for unbiased estimate
%Outputs
%   acf: autocorrelation function
%   k: interval of acf
%Date: 06/02/2021
%Author: Zhaolin Wang

N = length(x);
x_zp = zeros(3*N,1);
x_zp(N+1:2*N) = x; % padding x with zeros

% Biased estimate
if strcmp(type, 'biased')
    k = -(N-1) : (N-1);
    k = k';
    acf = zeros(length(k),1);
    for i = 1:length(k)
        acf(i) = 1/N * sum(x_zp .* circshift(x_zp, k(i)));
    end
% Unbiased estimates 
elseif strcmp(type, 'unbiased')
    k = 0: (N-1);
    k = k';
    acf = zeros(length(k),1);
    for i = 1:length(k)
        acf(i) = 1/(N-k(i)) * sum(x_zp .* circshift(x_zp, k(i)));
    end    
end
end

