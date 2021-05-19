% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/21

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Finds the locations of antenna array with half-wave length inter-antenna
% spacing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% num = Number of antennas in the antenna array
% angle = Angle that the 1st element anticlockwise with respect to the
% x-axis (in unit of radian)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% antennas (Nx3 Double) = Array locations in half unit wavelength
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [array] = antennaArray(num,angle)

d = 1/(2*sin(pi/num)); % distance bwteen antenna and origin
r = 2*pi/num; % angle difference bwteen adjecent antennas
array = zeros(num,3);
i = 1:num;
current_angle = angle + r*(i-1);
xy = d * exp(1i * current_angle); 
array(:,1) = real(xy)';
array(:,2) = imag(xy);
    
end

