% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/25

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Performs STAR channel estimation for the desired source using the
% received signal. The delays and DOAs are jointly estimated
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% symbolsIn ((2*N*Nc)xL Complex) = L extended symbols with dimension of 2*N*Nc
% array (Nx3 Doubles) = Array locations in half unit wavelength
% goldSeq (Ncx1 Integers) = Nc bits of 1's and 0's representing the gold
% sequence of the desired source used in the modulation process
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% delay_estimate = Vector of estimates of the delays of each path of the
% desired signal
% DOA_estimate = Estimates of the azimuth and elevation of each path of the
% desired signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [delay_estimate, DOA_estimate]=fChannelEstimationSTAR(symbolsIn, array, goldSeq)
Nc = size(goldSeq,1); % length of gold sequence

% extimation DOAs (2D MuSIC-type algorithm)
[nc,delay_estimate,DOA_estimate] = musicSpatiotemporal(array, symbolsIn, goldSeq);
figure();
subplot(1,2,1);
mesh(0:Nc-1,0:180,real(nc));xlabel('delay \tau'); ylabel('azimuth \theta');
title('STAR 2D MuSiC-type Cost function'); axis square;

subplot(1,2,2);
contour(0:Nc-1,0:180,real(nc));
xlabel('delay \tau'); ylabel('azimuth \theta');grid on;
axis square;
title('Contour of Cost function'); axis square;
end
