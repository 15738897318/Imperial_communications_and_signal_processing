% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/23

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculates and plot the arrya pattern based on the beamforming weights
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% array (Nx3 Doubles) = Array locations in half unit wavelength.
% w (Nx1 Complex) = Weight of beamformer
% str = String shown as the title of the figure;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% Z (1x181 Doubles) = Array pattern
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Z=arrayPattern(array,w,str)
Z = [];
for azi=0:360
    S=exp(-1i*array*K(azi*pi/180,0));
    Z=[Z;abs(w'*S)];
end
% Z=10*log10(Z);

figure();
plot([0:360], Z);
grid on;
title(str);
xlabel('azimuth \theta');
ylabel('gain');
end



