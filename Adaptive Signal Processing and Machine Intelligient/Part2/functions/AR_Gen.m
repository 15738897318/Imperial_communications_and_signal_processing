function [x] = AR_Gen(ar_coeff,sigma2,num)
%AR_Gen This function is to generate an AR model
%[x] = AR_Gen(ar_coeff,sigma2,num)
%Inputs:
%   ar_coeff: AR coefficients
%   sigma2: power of noise
%   num: length of AR signal
%Outputs:
%   x: AR signal
%Date: 14/03/2021
%Author: Zhaolin Wang

num = 2*num;
N = length(ar_coeff);

% Generate AR signal
x = zeros(num+N,1);
ar_coeff_flip = flip(ar_coeff);
for i = N+1:num+N
    x(i) = ar_coeff_flip * x(i-N:i-1) + sqrt(sigma2) * randn(1,1);
end
x = x(N+1:num+N);
x = x(num/2+1:end);
end

