% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/25

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculates and plot the 2D STAR arrya pattern based on the beamforming weights
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% array (Nx3 Doubles) = Array locations in half unit wavelength.
% w ((2*N*Nc)x1 Complex) = Weight of spatiatemporal beamformer
% J ((2*Nc)x(2*Nc) Double) = Shifting matrix
% c ((2*Nc)x 1 Double) = 2Nc bits of 1's and 0's representing gold sequence
% of desired user padding with Nc zeros
% str = String shown as the title of the figure;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% Z (181xNc Doubles) = Array pattern
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Z = arrayPatternSTAR(array,w,J,c,str)
Nc = size(c,1)/2;
Z = zeros(181,Nc);
for i = 1:181
    for j = 1:Nc
        S = exp(-1i*array*K((i-1)*pi/180,0));
        h = kron(S,(J^(j-1) * c));
        Z(i,j) = w'*h;
    end
end
figure();
mesh(0:Nc-1, 0:180, abs(Z));
title(str);
xlabel('delay \tau');
ylabel('azimuth \theta');
zlabel('gain');
axis square;
end

