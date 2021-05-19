clc
clear all

array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0]; % locations of array sensors
directions = [30, 0; 35, 0 ; 90, 0]; % DOAs of sources
Z = my_pattern(array);  % array pattern



figure(1);
plot2d3d(Z,[0:180],0,'gain in dB','initial pattern');

S = spv(array,directions); % array manifold vectors

sigma2 = 0.0001; % noise power
Rmm = eye(3); 
Rxx_theoretical = S*Rmm*S' + sigma2*eye(5,5); % covariance matirx of received signals

