function [Hk] = GaussMarkov(Hk,epsilon)
%Gauss-Markov process of the Rayleigh flat fading channel matrix
%   [Hk] = GaussMarkov(Hk,epsilon)
%Inputs:
%   Hk: the channel matrix at current time
%Outputs:
%   Hk: the channel matrix at next time
%Date: 27/02/2021
%Author: Zhaolin Wang

N = sqrt(1/2) * (randn(size(Hk)) + 1i*randn(size(Hk)));
Hk = epsilon * Hk + sqrt(1 - epsilon^2) * N;
end

