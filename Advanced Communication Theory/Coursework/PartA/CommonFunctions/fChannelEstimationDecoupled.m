% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/23

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Performs decoupled spatiotemporal channel estimation for the desired
% source using the receied signal.The space characteristics are estimated
% firstly, and the time characteristics are estimated sequentially. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% symbolsIn (NxL Complex) = L channel symbol chips received at N antennas
% array (Nx3 Doubles) = Array locations in half unit wavelength
% desired = Vectors of the number of desired paths. For example, the
% estimated DOAs are sorted from small to large. If the desired paths are
% associated with the first and the third DOAs in the sorted estimated
% DOAs, the value of deisred should be [1,3].
% goldSeq (Ncx1 Integers) = Nc bits of 1's and 0's representing the gold
% sequence of the desired source used in the modulation process
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% delay_estimate = Estimates of the delays of each path of the desired signal
% DOA_estimate = Estimates of the azimuth and elevation of each path of the
% desired signal
% symbols = Symbols botained by superresolution beamformer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [delay_estimate, DOA_estimate, symbols] = fChannelEstimationDecoupled(symbolsIn, array, desired, goldSeq)
%% DOA estimation
N = size(symbolsIn, 1); % num of antennas
L = size(symbolsIn, 2); % length of sequence
Rxx = symbolsIn*symbolsIn' / L;
pathNum = size(desired,2);
% estimate number of souces (MDL criterion)
M = MDL(Rxx,N,L);

% extimation DOAs (MuSIC algorithm)
[nc,DOA_estimate] = music(array, Rxx, M);
figure();
plot(0:180,real(nc));xlabel('azimuth \theta');
title('MuSiC Cost function');grid on;
symbols = zeros(pathNum,size(symbolsIn,2));

%% Beamforming and TOA estimation
delay_estimate = [];
W = size(goldSeq,2); % length of gold seq.
k = floor(L/W)-1;
goldSeq = (1 - 2*goldSeq);
for i = 1:pathNum
    %% Superresolution Beamformering
    w = superBeamformer(array, DOA_estimate, desired(i));
    Z = arrayPattern(array,w,'Array pattern of superresolution beamformer');
    
    symbolsSinglePath = w' * symbolsIn;
    symbols(i,:) = symbolsSinglePath;
    
    %% TOA Estimation
    results = zeros(W-1,1);
    for j = 1:W-1
        sta = j;
        en = k*W+j-1;
        s = reshape(symbolsSinglePath(sta:en),W,k);
        results(j) = mean(abs(goldSeq * s)); % correlator
    end
    [~,d] = maxk(results, 1);
    d = sort(d - 1);
    delay_estimate = [delay_estimate d];
end
end
