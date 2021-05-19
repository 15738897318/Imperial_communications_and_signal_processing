function [R] = tranCorrMatrix(t,Q)
%transmit correlation matrix of all users
%   [Hk] = GaussMarkov(Hk,epsilon)
%Inputs:
%   t: spatial correlation time
%   Q: number of users
%Outputs:
%   R: transmit correlation matrix
%Date: 27/02/2021
%Author: Zhaolin Wang

R = zeros(4,4,Q);
for q = 1:Q
    phi = rand(1) * 2*pi;
    tq = t * exp(1i * phi);
    R(:,:,q) = [1, tq, tq^2, tq^3;
      conj(tq), 1, tq, tq^2;
      conj(tq)^2, conj(tq), 1, tq;
      conj(tq)^3, conj(tq)^2, conj(tq),1];
end
end

