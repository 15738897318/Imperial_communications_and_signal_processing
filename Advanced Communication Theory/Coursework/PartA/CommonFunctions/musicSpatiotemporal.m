% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/23

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Performs directions of arrival and delays estimation using 2D MuSiC-type
% cost function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% array (Nx3 Doubles) = Array locations in half unit wavelength
% symbolsIn ((2*N*Nc)xL Complex) = L extended symbols with dimension of 2*N*Nc
% goldSeq (Ncx1 Integers) = Nc bits of 1's and 0's representing the gold
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% nc = 2D MuSiC-type cost function
% delay_estimate = Estimates of the delays of each path of the desired signal
% DOA_estimate = Estimates of the azimuth and elevation of each path of the
% desired signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [nc,delay_estimate, DOA_estimate] = musicSpatiotemporal(array, symbolsIn, goldSeq)
% MUSCI algorithm

Nc = size(goldSeq,1);
Next = Nc * 2;

% Shitfing Matrix
J = [zeros(1, Next-1) 0;
     eye(Next-1) zeros(Next-1,1)];
goldSeq = (1 - 2*goldSeq);
c = [goldSeq' zeros(1,Nc)]';
L = size(symbolsIn,2);
Rxx = symbolsIn*symbolsIn'/L;
Pn = projectNoiseSpace(Rxx,L);

nc = zeros(181,Nc); % gain of different directions and delays
for azimuth = 0:180
    for delay = 0:Nc-1
        S = exp(-1i*array*K(azimuth*pi/180,0));
        h = kron(S,(J^delay * c));
        nc(azimuth+1, delay+1) = h'*Pn*h;
    end
end

nc = -10*log10(nc); % 2D MuSiC-type cost function


%% Search the DOAs and Delays
threshold = (max(max(nc)) + min(min(nc))) / 2;
nc_threshold = nc -  threshold;
nc_threshold(nc_threshold<0) = 0;
nc_search = zeros(183,Nc+2);
nc_search(2:182,2:Nc+1) = nc_threshold;
delay_estimate = [];
DOA_estimate = [];
for azimuth = 1:181
    for delay = 1:Nc
        x = azimuth+1;
        y = delay+1;
        if nc_search(x, y) > nc_search(x-1,y) && nc_search(x, y) > nc_search(x,y-1) && nc_search(x, y) > nc_search(x+1,y) && nc_search(x, y) > nc_search(x,y+1)
            DOA_estimate = [DOA_estimate; [azimuth-1,0]];
            delay_estimate = [delay_estimate;delay-1];
        end
    end
end
end