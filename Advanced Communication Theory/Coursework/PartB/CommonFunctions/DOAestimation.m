% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/26

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Performs DOAs estimation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% X (NxL Complex) = L extended symbols with dimension of N
% array (Nx3 Doubles) = Array locations in half unit wavelength
% str = String shown as the title of the figure;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% DOA_estimate = Estimates of the azimuth of each path of the
% desired signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DOA_estimate = DOAestimation(X, array, str)
L = size(X,2);
N = size(array,1);
Rxx = X*X'/L;
M = MDL(Rxx,N,L);
[nc,DOA_estimate] = music(array, Rxx, M);
plot(0:180,real(nc));
grid on;
title(str);
DOA_estimate = DOA_estimate(1);
end

