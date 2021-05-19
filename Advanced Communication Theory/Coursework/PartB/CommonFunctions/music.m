% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/21

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Performs directions of arrival estimation using MuSiC cost function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% array (Nx3 Doubles) = Array locations in half unit wavelength
% RXX (NxN Complex) = Covariance matrix of received signal
% M (Integer) = Number of sources
% N_sub = Used for smoothed MuSiC algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% nc = MuSiC cost function
% DOA_estimate = Estimates of the azimuth and elevation of each path of the
% desired signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [nc,DOA_estimate] = music(array, Rxx, M, N_sub)
% MUSCI algorithm
N = size(Rxx,1);
if nargin<=3
    N_sub = N; % for spatital smoothing techniques
end

[E, D] = eig(Rxx); %eigenvalues and eigenvectors
D = diag(D);
[~,I] = sort(D,'descend');

E = E(:,I);
En = E(:,M+1:end); % eigenvectors of nosie subspace

nc = []; % gain of different directions
for azimuth = 0:180
    S = exp(-1i*array*K(azimuth*pi/180,0));
    S = S(1:N_sub);
    nc = [nc S'*(En*En')*S];
end

nc = -10*log10(nc);
[~,DOA_estimate] = max(nc); % only one direction of arrival
end